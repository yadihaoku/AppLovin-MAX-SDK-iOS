import re
import subprocess
import os
import sys

# List of adapters and their URLs based on the user's previous Package.swift content
# I will extract them from the file dynamically to be safe.

PACKAGE_FILE = 'Package.swift'

def get_binary_targets(content):
    # Regex to find binary targets with url
    # .binaryTarget(
    #     name: "AppLovinMediationGoogleAdapter",
    #     url: "...",
    #     checksum: "..."
    # )
    # We want to capture name, url, and the current checksum (to replace it)
    pattern = re.compile(r'\.binaryTarget\s*\(\s*name:\s*"([^"]+)",\s*url:\s*"([^"]+)",\s*checksum:\s*"([^"]+)"\s*\)')
    return pattern.findall(content)

def compute_checksum(url, name):
    filename = f"{name}.zip"
    print(f"Downloading {name} from {url}...")
    try:
        # Download with curl
        subprocess.run(['curl', '-L', '-o', filename, url], check=True)
        
        print(f"Computing checksum for {filename}...")
        # Use swift package compute-checksum
        result = subprocess.check_output(['swift', 'package', 'compute-checksum', filename])
        checksum = result.decode('utf-8').strip()
        
        # Clean up
        os.remove(filename)
        return checksum
    except subprocess.CalledProcessError as e:
        print(f"Error processing {name}: {e}")
        if os.path.exists(filename):
            os.remove(filename)
        return None
    except Exception as e:
        print(f"Unexpected error for {name}: {e}")
        if os.path.exists(filename):
            os.remove(filename)
        return None

def main():
    if not os.path.exists(PACKAGE_FILE):
        print(f"Error: {PACKAGE_FILE} not found.")
        sys.exit(1)
        
    with open(PACKAGE_FILE, 'r') as f:
        content = f.read()
        
    targets = get_binary_targets(content)
    print(f"Found {len(targets)} binary targets.")
    
    new_content = content
    
    for name, url, old_checksum in targets:
        # Skip AppLovinSDK if it already has a valid checksum (starts with a hex digit, not <)
        # Actually, let's verify all of them or just the ones that look like placeholders?
        # The user wants to "get sha256 data", so let's check placeholders first.
        # But if I commented them out, the regex might not find them if I don't uncomment first.
        # Wait, I commented them out in the previous turn!
        # I need to uncomment them first or parse the commented out blocks.
        pass

    # Re-enable the commented out blocks for processing
    # The previous turn commented out the block with /* ... */
    # Let's naive replace /* and */ around the adapters
    if "/*" in new_content and "*/" in new_content:
        print("Uncommenting adapter block for processing...")
        new_content = new_content.replace("/*", "").replace("*/", "")
        
    # Re-parse targets after uncommenting
    targets = get_binary_targets(new_content)
    
    updated_count = 0
    for name, url, old_checksum in targets:
        if name == "AppLovinSDK" and not old_checksum.startswith("<#"):
            continue # Skip core SDK if it looks valid
            
        checksum = compute_checksum(url, name)
        if checksum:
            print(f"Updated {name} checksum: {checksum}")
            # Replace the specific instance of checksum for this target
            # Be careful with find/replace if multiple targets have same checksum (unlikely for placeholders)
            # We construct the old string and new string
            
            # Use regex substitution to ensure we replace the checksum for THIS target
            # pattern: .binaryTarget(name: "NAME", url: "URL", checksum: "OLD")
            # We need to escape special chars in url
            escaped_url = re.escape(url)
            escaped_old_checksum = re.escape(old_checksum)
            
            target_pattern = rf'(\.binaryTarget\s*\(\s*name:\s*"{name}",\s*url:\s*"{escaped_url}",\s*checksum:\s*)"{escaped_old_checksum}"'
            new_content = re.sub(target_pattern, rf'\1"{checksum}"', new_content)
            updated_count += 1
            
    if updated_count > 0:
        with open(PACKAGE_FILE, 'w') as f:
            f.write(new_content)
        print(f"Successfully updated {updated_count} checksums in {PACKAGE_FILE}.")
    else:
        print("No checksums needed update or all downloads failed.")

if __name__ == "__main__":
    main()
