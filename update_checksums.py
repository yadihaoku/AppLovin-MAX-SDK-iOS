import re
import subprocess
import os
import sys

def main():
    package_path = 'Package.swift'

    if not os.path.exists(package_path):
        print(f'Error: {package_path} not found!')
        sys.exit(1)

    with open(package_path, 'r') as f:
        content = f.read()

    # Updated regex to be more flexible with whitespace and formatting
    # Matches: .binaryTarget( name: "...", url: "...", checksum: "..." )
    # Captures: (name, url, placeholder_checksum)
    pattern = re.compile(
        r'\.binaryTarget\s*\(\s*'
        r'name:\s*"([^"]+)",\s*'
        r'url:\s*"([^"]+)",\s*'
        r'checksum:\s*"(<#SHA256_CHECKSUM_FOR_[^#]+#>)"\s*'
        r'\)',
        re.DOTALL
    )

    matches = pattern.findall(content)
    print(f'Found {len(matches)} targets to update.')

    if not matches:
        print("No placeholders found. Exiting.")
        return

    for name, url, placeholder in matches:
        print(f'Processing {name} ({url})...')
        filename = url.split('/')[-1]
        
        try:
            # Download file
            print(f'  Downloading {filename}...')
            subprocess.run(['curl', '-L', '-o', filename, url], check=True)
            
            # Compute checksum
            print(f'  Computing checksum...')
            result = subprocess.check_output(['swift', 'package', 'compute-checksum', filename])
            checksum = result.decode('utf-8').strip()
            print(f'  Checksum: {checksum}')
            
            # Replace placeholder in content
            content = content.replace(placeholder, checksum)
            
        except subprocess.CalledProcessError as e:
            print(f'  Error processing {filename}: {e}')
        except Exception as e:
            print(f'  An unexpected error occurred: {e}')
        finally:
            if os.path.exists(filename):
                os.remove(filename)

    with open(package_path, 'w') as f:
        f.write(content)

    print('Done! Package.swift has been updated.')

if __name__ == "__main__":
    main()
