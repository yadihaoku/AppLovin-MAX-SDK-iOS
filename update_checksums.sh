#!/bin/bash

# 定义 Package.swift 路径
PACKAGE_FILE="Package.swift"

# 检查文件是否存在
if [ ! -f "$PACKAGE_FILE" ]; then
    echo "Error: $PACKAGE_FILE not found!"
    exit 1
fi

echo "Starting to update checksums in $PACKAGE_FILE..."

# 逐行读取文件，寻找带有 url 和 placeholder checksum 的块
# 这是一个简单的状态机解析
TEMP_FILE="${PACKAGE_FILE}.tmp"
cp "$PACKAGE_FILE" "$TEMP_FILE"

# 提取所有需要处理的 URL 和对应的 placeholder
# 假设格式是标准的：
# url: "..."
# checksum: "<#...#>"

# 使用 Python 脚本来处理文件替换，因为 shell 处理多行比较复杂
python3 -c "
import re
import subprocess
import os

package_path = '$PACKAGE_FILE'
with open(package_path, 'r') as f:
    content = f.read()

# 正则匹配 url 和 checksum 占位符
# 匹配格式: 
# .binaryTarget(
#    name: \"Name\",
#    url: \"URL\",
#    checksum: \"<#SHA256_CHECKSUM_FOR_Name#>\" 
# )
pattern = re.compile(r'url:\s*\"(https?://[^\"]+)\",\s*checksum:\s*\"(<#SHA256_CHECKSUM_FOR_[^#]+#>)\"')

matches = pattern.findall(content)

print(f'Found {len(matches)} targets to update.')

for url, placeholder in matches:
    print(f'Processing {url}...')
    filename = url.split('/')[-1]
    
    # 下载文件
    if not os.path.exists(filename):
        print(f'  Downloading {filename}...')
        subprocess.run(['curl', '-L', '-o', filename, url], check=True)
    
    # 计算 checksum
    print(f'  Computing checksum...')
    try:
        result = subprocess.check_output(['swift', 'package', 'compute-checksum', filename])
        checksum = result.decode('utf-8').strip()
        print(f'  Checksum: {checksum}')
        
        # 替换文件内容
        content = content.replace(placeholder, checksum)
        
        # 删除下载的文件
        os.remove(filename)
    except subprocess.CalledProcessError as e:
        print(f'  Error computing checksum for {filename}: {e}')

# 写回文件
with open(package_path, 'w') as f:
    f.write(content)

print('Done! Package.swift has been updated.')
"

# 检查 Python 脚本执行结果
if [ $? -eq 0 ]; then
    rm "$TEMP_FILE"
    echo "Successfully updated checksums."
else
    echo "Failed to update checksums. Restoring original file."
    mv "$TEMP_FILE" "$PACKAGE_FILE"
fi
