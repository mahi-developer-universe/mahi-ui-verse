import json
import os

root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
registry_path = os.path.join(root, 'registry', 'resources.json')
output_path = os.path.join(root, 'registry', 'search-index.json')

if not os.path.exists(registry_path):
    print(f"Error: {registry_path} not found.")
    exit(1)

with open(registry_path, 'r', encoding='utf-8-sig') as f:
    resources = json.load(f)

# Build a compact search index item: id, name, desc, cat, sub, tags, url, pricing, os
search_index = []
for r in resources:
    search_index.append({
        "id": r.get("id", ""),
        "name": r.get("name", ""),
        "slug": r.get("slug", ""),
        "cat": r.get("category", ""),
        "sub": r.get("subcategory", ""),
        "desc": r.get("description", ""),
        "url": r.get("website", ""),
        "tags": r.get("tags", []),
        "pricing": r.get("pricing", "unknown"),
        "os": bool(r.get("openSource", False)),
        "gh": r.get("github", "")
    })

with open(output_path, 'w', encoding='utf-8') as f:
    json.dump(search_index, f, separators=(',', ':'), ensure_ascii=False)

file_size_kb = os.path.getsize(output_path) / 1024
print(f"Successfully generated {output_path}")
print(f"Total indexed resources: {len(search_index)}")
print(f"Index payload size: {file_size_kb:.2f} KB (optimized for instant web/client search)")
