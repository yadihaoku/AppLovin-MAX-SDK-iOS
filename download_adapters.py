import re
import subprocess
import os
import sys

def main():
    package_file = 'Package.swift'
    output_file = 'checksums.txt'
    
    if not os.path.exists(package_file):
        print(f"Error: {package_file} not found.")
        sys.exit(1)

    with open(package_file, 'r') as f:
        content = f.read()

    # Regex to extract name and URL from binaryTarget definition
    # Matches both commented and uncommented lines
    # Pattern looks for: name: "Name", url: "URL"
    # We use a flexible regex that captures the name and the URL
    # It assumes 'name:' comes before 'url:' in the binaryTarget block
    pattern = re.compile(r'name:\s*"([^"]+)",\s*url:\s*"(https?://[^"]+)"', re.DOTALL)
    
    matches = pattern.findall(content)
    
    print(f"Found {len(matches)} adapters to process.")
    
    results = []

    for name, url in matches:
        # Skip AppLovinSDK if we want to focus on adapters, but user said "adapters", 
        # usually AppLovinSDK is already set. Let's include everything just in case.
        if name == "AppLovinSDK":
            continue

        filename = url.split('/')[-1]
        print(f"\nProcessing {name}...")
        print(f"  URL: {url}")
        
        # 1. Download
        if os.path.exists(filename):
            print(f"  File {filename} already exists, skipping download.")
        else:
            print(f"  Downloading {filename}...")
            try:
                subprocess.run(['curl', '-L', '-O', url], check=True)
            except subprocess.CalledProcessError:
                print(f"  Error: Failed to download {url}")
                continue

        # 2. Compute Checksum
        print(f"  Computing checksum for {filename}...")
        try:
            checksum_output = subprocess.check_output(['swift', 'package', 'compute-checksum', filename])
            checksum = checksum_output.decode('utf-8').strip()
            print(f"  SHA256: {checksum}")
            results.append((name, checksum))
        except subprocess.CalledProcessError:
            print(f"  Error: Failed to compute checksum for {filename}")

    # 3. Output results
    print("\n" + "="*40)
    print("SUMMARY OF CHECKSUMS")
    print("="*40)
    
    with open(output_file, 'w') as f:
        for name, checksum in results:
            line = f'Target: {name}\nChecksum: {checksum}\n'
            print(line)
            f.write(line + "\n")
            
    print(f"\nChecksums have been saved to {output_file}")
    print("You can now manually copy these checksums into your Package.swift")

if __name__ == "__main__":
    main()
