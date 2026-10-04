# [Endpoint Name]

<!--
TEMPLATE: API Endpoint Documentation
Use this template for documenting REST API endpoints.
Delete this comment block when using.
-->

```
METHOD /path/to/endpoint
```

Brief description of what this endpoint does.

---

## Authentication

**Required:** Yes / No

**Method:** Bearer Token / API Key / None

```
Authorization: Bearer <token>
```

---

## Request

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `id` | string | Yes | The resource ID |

### Query Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `page` | integer | `1` | Page number for pagination |
| `limit` | integer | `20` | Items per page (max 100) |
| `sort` | string | `created_at` | Sort field |
| `order` | string | `desc` | Sort order: `asc` or `desc` |

### Headers

| Header | Required | Description |
|--------|----------|-------------|
| `Authorization` | Yes | Bearer token |
| `Content-Type` | Yes | `application/json` |
| `X-Request-ID` | No | Optional request tracking ID |

### Request Body

```json
{
  "field1": "string value",
  "field2": 123,
  "nested": {
    "property": "value"
  },
  "array": ["item1", "item2"]
}
```

**Fields:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `field1` | string | Yes | Description |
| `field2` | integer | No | Description (default: 0) |
| `nested.property` | string | No | Description |

---

## Response

### Success Response

**Status:** `200 OK` / `201 Created`

```json
{
  "id": "abc123",
  "field1": "value",
  "created_at": "2026-01-20T12:00:00Z",
  "updated_at": "2026-01-20T12:00:00Z"
}
```

**Fields:**

| Field | Type | Description |
|-------|------|-------------|
| `id` | string | Unique identifier |
| `created_at` | string | ISO 8601 timestamp |

### Paginated Response

```json
{
  "data": [...],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 100,
    "total_pages": 5
  }
}
```

---

## Errors

| Status | Code | Description |
|--------|------|-------------|
| `400` | `INVALID_REQUEST` | Request body validation failed |
| `401` | `UNAUTHORIZED` | Missing or invalid authentication |
| `403` | `FORBIDDEN` | Insufficient permissions |
| `404` | `NOT_FOUND` | Resource not found |
| `409` | `CONFLICT` | Resource already exists |
| `422` | `UNPROCESSABLE` | Business logic error |
| `429` | `RATE_LIMITED` | Too many requests |
| `500` | `INTERNAL_ERROR` | Server error |

### Error Response Format

```json
{
  "error": {
    "code": "INVALID_REQUEST",
    "message": "Human readable error message",
    "details": [
      {
        "field": "email",
        "message": "Invalid email format"
      }
    ]
  }
}
```

---

## Examples

### cURL

```bash
curl -X POST "https://api.example.com/v1/endpoint" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "field1": "value",
    "field2": 123
  }'
```

### JavaScript

```javascript
const response = await fetch('https://api.example.com/v1/endpoint', {
  method: 'POST',
  headers: {
    'Authorization': 'Bearer YOUR_TOKEN',
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({
    field1: 'value',
    field2: 123,
  }),
});

const data = await response.json();
```

### Python

```python
import requests

response = requests.post(
    'https://api.example.com/v1/endpoint',
    headers={
        'Authorization': 'Bearer YOUR_TOKEN',
        'Content-Type': 'application/json',
    },
    json={
        'field1': 'value',
        'field2': 123,
    }
)

data = response.json()
```

---

## Rate Limits

| Plan | Requests/minute |
|------|-----------------|
| Free | 60 |
| Pro | 1000 |
| Enterprise | Unlimited |

---

## Related Endpoints

- [GET /endpoint](get-endpoint.md) - Retrieve resource
- [DELETE /endpoint](delete-endpoint.md) - Delete resource
- [List endpoints](list-endpoints.md) - List all resources
