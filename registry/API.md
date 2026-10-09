# Mahi UI Verse — API Specification & Data Contract

This document specifies the read-only public API contract designed to consume `registry/resources.json` directly or via a serverless edge runtime (e.g. Cloudflare Workers, Vercel Functions, or static JSON routes).

---

## Architecture Overview

All endpoints operate over HTTPS, output UTF-8 JSON, and map directly to the canonical schema defined in [`registry/schemas/resource.schema.json`](schemas/resource.schema.json).

```text
Static/CDN Mode:
https://raw.githubusercontent.com/mahi-developer-universe/mahi-ui-verse/main/registry/resources.json
https://raw.githubusercontent.com/mahi-developer-universe/mahi-ui-verse/main/registry/search-index.json

Edge/Serverless Mode:
GET /api/v1/resources
GET /api/v1/resources/:id
GET /api/v1/search?q={query}&category={cat}&pricing={price}
```

---

## Endpoints

### 1. `GET /api/v1/resources`

Returns a list of resources matching the filter criteria.

**Query Parameters:**
| Parameter | Type | Example | Description |
|---|---|---|---|
| `category` | string | `ui` | Filter by primary category (`ui`, `ux`, `frontend`, `resources`, `demos`, `videos`) |
| `subcategory` | string | `component-libraries` | Filter by subcategory |
| `type` | string | `component-library` | Filter by resource type |
| `pricing` | string | `free` | Filter by pricing (`free`, `freemium`, `paid`, `open-source`) |
| `openSource` | boolean | `true` | Filter for open-source repositories |
| `hasDemo` | boolean | `true` | Filter for resources with live interactive demos |
| `hasGithub` | boolean | `true` | Filter for resources with GitHub repositories |
| `status` | string | `active` | Resource operational status |
| `limit` | integer | `50` | Maximum results to return (default: `50`, max: `100`) |
| `offset` | integer | `0` | Offset for pagination |

**Response Format (`200 OK`):**
```json
{
  "total": 458,
  "count": 1,
  "offset": 0,
  "limit": 50,
  "data": [
    {
      "id": "shadcn-ui",
      "name": "shadcn/ui",
      "slug": "shadcn-ui",
      "category": "ui",
      "subcategory": "component-libraries",
      "type": "component-library",
      "description": "Beautifully designed components that you can copy and paste into your apps.",
      "website": "https://ui.shadcn.com/",
      "demo": "https://ui.shadcn.com/",
      "documentation": "https://ui.shadcn.com/docs",
      "github": "https://github.com/shadcn-ui/ui",
      "video": "",
      "framework": ["React", "Next.js"],
      "technology": ["Tailwind CSS", "Radix UI"],
      "pricing": "free",
      "license": "MIT",
      "openSource": true,
      "tags": ["components", "accessible", "tailwind", "react"],
      "status": "active",
      "lastVerified": "2026-10-09"
    }
  ]
}
```

---

### 2. `GET /api/v1/resources/:id`

Fetch a single canonical resource by its unique slug or ID.

**Response (`200 OK`):** Returns the resource object.
**Response (`404 Not Found`):**
```json
{
  "error": "Resource not found",
  "id": "unknown-id"
}
```

---

### 3. `GET /api/v1/search`

Full-text search across resource `name`, `description`, and `tags`.

**Query Parameters:**
| Parameter | Type | Required | Description |
|---|---|---|---|
| `q` | string | Yes | Query string (minimum 2 characters) |
| `category` | string | No | Filter within a category |

**Response Format (`200 OK`):**
```json
{
  "query": "charts",
  "totalMatches": 1,
  "results": [
    {
      "id": "evil-charts",
      "name": "Evil Charts",
      "website": "https://evilcharts.com/",
      "description": "Collection of minimalist and evil-styled interactive SVG/canvas charts.",
      "category": "ui",
      "tags": ["charts", "visualization", "svg"]
    }
  ]
}
```

---

### 4. `GET /api/v1/stats`

Returns aggregated real-time counts from the verified registry.

**Response Format (`200 OK`):**
```json
{
  "totalResources": 458,
  "categories": 5,
  "subcategories": 16,
  "openSource": 5,
  "free": 447,
  "paid": 6,
  "withGithub": 1,
  "withDemo": 458,
  "active": 458,
  "generated": "2026-10-09 12:34:20"
}
```

---

### 5. `GET /api/v1/random`

Returns a random curated resource for serendipitous discovery.

**Query Parameters:**
- `category` (optional): Filter random pool to a specific category.
