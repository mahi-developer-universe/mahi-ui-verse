# Resource Data Standards

## Required fields

Each canonical resource should have:

- id: stable unique identifier
- name: display name
- url: canonical official URL
- category: primary category
- description: concise and accurate summary
- status: verification state

## Optional fields

- tags
- frameworks
- secondary_categories
- demo_url
- video_urls
- pricing
- license
- attribution
- last_checked
- notes

## Example JSON record

{
  "id": "resource-example",
  "name": "Example Resource",
  "url": "https://example.org/",
  "category": "component-libraries",
  "description": "Description awaiting verification.",
  "tags": [],
  "frameworks": [],
  "demo_url": null,
  "video_urls": [],
  "pricing": "unknown",
  "license": "unknown",
  "attribution": null,
  "last_checked": null,
  "status": "needs-review"
}

This is a schema example, not a real resource recommendation.

## Allowed status values

- verified
- needs-review
- blocked
- unavailable

Use verified only when the relevant facts were actually checked.

## Pricing

Suggested values:

- free
- freemium
- paid
- open-source
- unknown

Open-source and pricing are different concepts. Do not assume that
an open-source project has no paid services or that a free website
offers unrestricted commercial asset usage.

## Canonical URL policy

- Prefer official domains.
- Remove tracking parameters when safe.
- Remove fragments when comparing page identity.
- Preserve meaningful query parameters.
- Preserve distinct paths.
- Review redirects manually when identity is ambiguous.

## Multiple categories

Store one canonical resource record. Reference that record from as many
categories as needed instead of maintaining conflicting descriptions.

## Licensing and attribution

Record a license only when supported by an authoritative source.
Link to license terms when possible. Flag unclear cases for review.

## Videos and demos

Store direct URLs when available. Do not substitute a homepage for a
specific demo or video without clearly labeling the link type.
