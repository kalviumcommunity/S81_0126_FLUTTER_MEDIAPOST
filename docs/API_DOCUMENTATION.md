# API Documentation - Instagram Clone Firebase Services

**Version:** 1.0.0  
**Last Updated:** January 2026  
**Format:** REST API with JSON payloads

---

## Table of Contents

1. [Base Information](#base-information)
2. [Authentication](#authentication)
3. [Users API](#users-api)
4. [Posts API](#posts-api)
5. [Comments API](#comments-api)
6. [Storage API](#storage-api)
7. [Error Handling](#error-handling)
8. [Rate Limiting](#rate-limiting)

---

## Base Information

### API Endpoints

| Service | Base URL |
|---------|----------|
| Firebase Auth | `https://identitytoolkit.googleapis.com/v1/accounts` |
| Firestore | `https://firestore.googleapis.com/v1/projects/{projectId}/databases/(default)/documents` |
| Cloud Storage | `https://www.googleapis.com/upload/storage/v1/b/{bucket}/o` |

### Authentication

All endpoints (except signup/login) require Firebase ID token:

```
Authorization: Bearer {idToken}
```

### Request Headers

```
Content-Type: application/json
Authorization: Bearer {idToken}
X-Request-ID: {uuid}  # Recommended for tracking
```

---

## Authentication

### Sign Up

Create a new user account with email and password.

**Endpoint:** `POST /signUp?key={apiKey}`  
**Auth:** Not required

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "SecurePassword123!",
  "returnSecureToken": true
}
```

**Response (200):**
```json
{
  "kind": "identitytoolkit#SignupNewUserResponse",
  "idToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjI2YzEyN2E...",
  "email": "user@example.com",
  "refreshToken": "AEu4IL...",
  "expiresIn": "3600",
  "localId": "UOHuZs..."
}
```

**Error (400):**
```json
{
  "error": {
    "code": 400,
    "message": "EMAIL_EXISTS",
    "errors": [
      {
        "message": "EMAIL_EXISTS",
        "domain": "global",
        "reason": "invalid"
      }
    ]
  }
}
```

---

### Sign In

Authenticate user with email and password.

**Endpoint:** `POST /signInWithPassword?key={apiKey}`  
**Auth:** Not required

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "SecurePassword123!",
  "returnSecureToken": true
}
```

**Response (200):**
```json
{
  "kind": "identitytoolkit#VerifyPasswordResponse",
  "localId": "UOHuZs...",
  "email": "user@example.com",
  "displayName": "John Doe",
  "idToken": "eyJhbGciOiJSUzI1NiIs...",
  "registered": true,
  "refreshToken": "AEu4IL...",
  "expiresIn": "3600"
}
```

---

### Refresh Token

Get new ID token using refresh token.

**Endpoint:** `POST https://securetoken.googleapis.com/v1/token?key={apiKey}`  
**Auth:** Not required

**Request Body (x-www-form-urlencoded):**
```
grant_type=refresh_token
refresh_token={refreshToken}
```

**Response (200):**
```json
{
  "expires_in": "3600",
  "token_type": "Bearer",
  "refresh_token": "AEu4IL...",
  "id_token": "eyJhbGciOiJSUzI1NiIs...",
  "user_id": "UOHuZs...",
  "project_id": "instagram-clone"
}
```

---

### Verify ID Token

Verify and get current user info.

**Endpoint:** `POST /lookup?key={apiKey}`  
**Auth:** Required

**Request Body:**
```json
{
  "idToken": "{idToken}"
}
```

**Response (200):**
```json
{
  "kind": "identitytoolkit#GetAccountInfoResponse",
  "users": [
    {
      "localId": "UOHuZs...",
      "email": "user@example.com",
      "emailVerified": false,
      "displayName": "John Doe",
      "providerUserInfo": [],
      "validSince": "1704067200",
      "salt": "...",
      "passwordHash": "...",
      "passwordUpdatedAt": 1704067200000,
      "createdAt": 1704067200000,
      "lastLoginAt": 1704067200000
    }
  ]
}
```

---

## Users API

### Create User Profile

Create user document in Firestore.

**Endpoint:** `POST /databases/{database}/documents/users`  
**Auth:** Required (Bearer token)

**Request Body:**
```json
{
  "fields": {
    "uid": {"stringValue": "user123"},
    "email": {"stringValue": "user@example.com"},
    "username": {"stringValue": "john_doe"},
    "bio": {"stringValue": "Photography enthusiast"},
    "photoUrl": {"stringValue": "https://..."},
    "followers": {"arrayValue": {"values": []}},
    "following": {"arrayValue": {"values": []}},
    "createdAt": {"timestampValue": "2026-01-28T10:00:00Z"}
  }
}
```

**Response (200):**
```json
{
  "name": "projects/instagram-clone/databases/(default)/documents/users/user123",
  "fields": {
    "uid": {"stringValue": "user123"},
    "email": {"stringValue": "user@example.com"},
    "username": {"stringValue": "john_doe"},
    "createdAt": {"timestampValue": "2026-01-28T10:00:00Z"}
  },
  "createTime": "2026-01-28T10:00:00Z",
  "updateTime": "2026-01-28T10:00:00Z"
}
```

---

### Get User Profile

Retrieve user document.

**Endpoint:** `GET /databases/{database}/documents/users/{userId}`  
**Auth:** Required

**Response (200):**
```json
{
  "name": "projects/instagram-clone/databases/(default)/documents/users/user123",
  "fields": {
    "uid": {"stringValue": "user123"},
    "email": {"stringValue": "user@example.com"},
    "username": {"stringValue": "john_doe"},
    "bio": {"stringValue": "Photography enthusiast"},
    "photoUrl": {"stringValue": "https://..."},
    "followers": {
      "arrayValue": {
        "values": [
          {"stringValue": "user456"},
          {"stringValue": "user789"}
        ]
      }
    },
    "following": {
      "arrayValue": {
        "values": [
          {"stringValue": "user321"}
        ]
      }
    }
  },
  "createTime": "2026-01-28T10:00:00Z",
  "updateTime": "2026-01-28T10:00:00Z"
}
```

---

### Update User Profile

Update user document fields.

**Endpoint:** `PATCH /databases/{database}/documents/users/{userId}`  
**Auth:** Required

**Request Body:**
```json
{
  "fields": {
    "bio": {"stringValue": "Updated bio"},
    "photoUrl": {"stringValue": "https://new-photo.jpg"}
  }
}
```

**Response (200):**
```json
{
  "name": "projects/instagram-clone/databases/(default)/documents/users/user123",
  "fields": {
    "bio": {"stringValue": "Updated bio"},
    "photoUrl": {"stringValue": "https://new-photo.jpg"},
    "updateTime": "2026-01-28T11:00:00Z"
  }
}
```

---

### Search Users

Find users by username pattern.

**Endpoint:** `GET /databases/{database}/documents/users?where=username:john`  
**Auth:** Required

**Response (200):**
```json
{
  "documents": [
    {
      "name": "projects/instagram-clone/databases/(default)/documents/users/user123",
      "fields": {
        "username": {"stringValue": "john_doe"},
        "email": {"stringValue": "user@example.com"}
      }
    },
    {
      "name": "projects/instagram-clone/databases/(default)/documents/users/user456",
      "fields": {
        "username": {"stringValue": "john_smith"},
        "email": {"stringValue": "smith@example.com"}
      }
    }
  ]
}
```

---

### Follow User

Add user to following array.

**Endpoint:** `PATCH /databases/{database}/documents/users/{userId}`  
**Auth:** Required

**Request Body:**
```json
{
  "fields": {
    "following": {
      "arrayValue": {
        "values": [
          {"stringValue": "targetUserId"}
        ]
      }
    }
  }
}
```

**Response (200):** User document updated

---

### Unfollow User

Remove user from following array.

**Endpoint:** `PATCH /databases/{database}/documents/users/{userId}`  
**Auth:** Required

**Request Body:**
```json
{
  "fields": {
    "following": {
      "arrayValue": {
        "values": []
      }
    }
  }
}
```

---

## Posts API

### Create Post

Create new post document.

**Endpoint:** `POST /databases/{database}/documents/posts`  
**Auth:** Required

**Request Body:**
```json
{
  "fields": {
    "postId": {"stringValue": "post123"},
    "uid": {"stringValue": "user123"},
    "username": {"stringValue": "john_doe"},
    "userImage": {"stringValue": "https://..."},
    "description": {"stringValue": "Beautiful sunset"},
    "postUrl": {"stringValue": "https://firebasestorage.googleapis.com/..."},
    "likes": {"arrayValue": {"values": []}},
    "commentCount": {"integerValue": "0"},
    "datePublished": {"timestampValue": "2026-01-28T10:00:00Z"}
  }
}
```

**Response (200):**
```json
{
  "name": "projects/instagram-clone/databases/(default)/documents/posts/post123",
  "fields": {
    "postId": {"stringValue": "post123"},
    "uid": {"stringValue": "user123"},
    "datePublished": {"timestampValue": "2026-01-28T10:00:00Z"}
  },
  "createTime": "2026-01-28T10:00:00Z",
  "updateTime": "2026-01-28T10:00:00Z"
}
```

---

### Get Feed

Retrieve posts ordered by date.

**Endpoint:** `GET /databases/{database}/documents/posts?pageSize=20&orderBy=datePublished`  
**Auth:** Required

**Response (200):**
```json
{
  "documents": [
    {
      "name": "projects/instagram-clone/databases/(default)/documents/posts/post1",
      "fields": {
        "postId": {"stringValue": "post1"},
        "description": {"stringValue": "Beautiful sunset"},
        "likes": {
          "arrayValue": {
            "values": [
              {"stringValue": "user456"},
              {"stringValue": "user789"}
            ]
          }
        },
        "commentCount": {"integerValue": "3"},
        "datePublished": {"timestampValue": "2026-01-28T10:00:00Z"}
      }
    }
  ],
  "nextPageToken": "CjsSEgoIcG9zdGluZzoZIg..."
}
```

---

### Get User Posts

Retrieve posts by specific user.

**Endpoint:** `GET /databases/{database}/documents/posts?where=uid==user123`  
**Auth:** Required

**Response (200):** Array of user's posts

---

### Like Post

Add user ID to likes array.

**Endpoint:** `PATCH /databases/{database}/documents/posts/{postId}`  
**Auth:** Required

**Request Body:**
```json
{
  "fields": {
    "likes": {
      "arrayValue": {
        "values": [
          {"stringValue": "user456"},
          {"stringValue": "currentUserId"}
        ]
      }
    }
  }
}
```

**Response (200):** Post document with updated likes

---

### Unlike Post

Remove user ID from likes array.

**Endpoint:** `PATCH /databases/{database}/documents/posts/{postId}`  
**Auth:** Required

**Request Body:**
```json
{
  "fields": {
    "likes": {
      "arrayValue": {
        "values": [
          {"stringValue": "user456"}
        ]
      }
    }
  }
}
```

---

### Delete Post

Delete post document.

**Endpoint:** `DELETE /databases/{database}/documents/posts/{postId}`  
**Auth:** Required (must be post owner)

**Response (200):** Empty response

---

## Comments API

### Create Comment

Create comment on post.

**Endpoint:** `POST /databases/{database}/documents/comments`  
**Auth:** Required

**Request Body:**
```json
{
  "fields": {
    "commentId": {"stringValue": "comment123"},
    "postId": {"stringValue": "post123"},
    "uid": {"stringValue": "user456"},
    "username": {"stringValue": "jane_doe"},
    "text": {"stringValue": "Amazing photo!"},
    "createdAt": {"timestampValue": "2026-01-28T10:30:00Z"}
  }
}
```

**Response (200):** Comment document created

---

### Get Post Comments

Retrieve all comments for post.

**Endpoint:** `GET /databases/{database}/documents/comments?where=postId==post123`  
**Auth:** Required

**Response (200):**
```json
{
  "documents": [
    {
      "name": "projects/instagram-clone/databases/(default)/documents/comments/comment1",
      "fields": {
        "username": {"stringValue": "jane_doe"},
        "text": {"stringValue": "Amazing photo!"},
        "createdAt": {"timestampValue": "2026-01-28T10:30:00Z"}
      }
    }
  ]
}
```

---

### Delete Comment

Delete comment.

**Endpoint:** `DELETE /databases/{database}/documents/comments/{commentId}`  
**Auth:** Required (must be comment owner)

---

## Storage API

### Upload Image

Upload image to Cloud Storage.

**Endpoint:** `POST /b/{bucket}/o?uploadType=media&name=posts%2F{userId}%2F{timestamp}.jpg`  
**Auth:** Required

**Request Body:**
```
[Binary image data]
```

**Response (200):**
```json
{
  "kind": "storage#object",
  "name": "posts/user123/1704067200000.jpg",
  "bucket": "instagram-clone.appspot.com",
  "generation": "1704067200000",
  "metageneration": "1",
  "contentType": "image/jpeg",
  "timeCreated": "2026-01-28T10:00:00Z",
  "updated": "2026-01-28T10:00:00Z",
  "storageClass": "STANDARD",
  "size": "524288",
  "md5Hash": "rL0Y20zessFPIJfqB5zFMg=="
}
```

---

### Get Download URL

Generate CDN download URL.

**Endpoint:** `GET /b/{bucket}/o/posts%2F{userId}%2F{timestamp}.jpg?alt=media`  
**Auth:** Required

**Response:** Image file (binary)

**URL Format:**
```
https://firebasestorage.googleapis.com/v0/b/
instagram-clone.appspot.com/o/
posts%2Fuser123%2F1704067200000.jpg?alt=media
```

---

### Delete Image

Delete image from Cloud Storage.

**Endpoint:** `DELETE /b/{bucket}/o/posts%2F{userId}%2F{timestamp}.jpg`  
**Auth:** Required

**Response (204):** No content (successfully deleted)

---

## Error Handling

### Error Response Format

All errors follow standard format:

```json
{
  "error": {
    "code": 401,
    "message": "PERMISSION_DENIED",
    "status": "PERMISSION_DENIED",
    "details": [
      {
        "@type": "type.googleapis.com/google.rpc.ErrorInfo",
        "reason": "AUTH_ERROR",
        "domain": "firebase.com"
      }
    ]
  }
}
```

### Common Error Codes

| Code | Message | Meaning |
|------|---------|---------|
| 400 | INVALID_ARGUMENT | Invalid request parameters |
| 401 | UNAUTHENTICATED | Missing or invalid auth token |
| 403 | PERMISSION_DENIED | User lacks required permissions |
| 404 | NOT_FOUND | Resource not found |
| 409 | ALREADY_EXISTS | Document/user already exists |
| 429 | RESOURCE_EXHAUSTED | Rate limit exceeded |
| 500 | INTERNAL | Server error |
| 503 | UNAVAILABLE | Service temporarily unavailable |

---

## Rate Limiting

### Limits

**Authenticated Users:**
- 100 requests/minute per user
- 1,000 requests/day per user
- 10 concurrent requests

**Unauthenticated:**
- 10 requests/minute
- 100 requests/day

### Rate Limit Headers

```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1704067260
```

### Exceeding Limits

When limit exceeded:

```
HTTP 429 Too Many Requests

{
  "error": {
    "code": 429,
    "message": "RESOURCE_EXHAUSTED",
    "status": "RESOURCE_EXHAUSTED"
  }
}

Retry-After: 60
```

---

## Best Practices

### Request Optimization

1. **Use pagination** for large result sets
   ```
   ?pageSize=20&pageToken={nextToken}
   ```

2. **Filter server-side** instead of client-side
   ```
   ?where=uid==user123
   ```

3. **Batch operations** when possible
   ```
   WriteBatch batch = Firestore.batch();
   batch.update(...);
   batch.update(...);
   await batch.commit();
   ```

4. **Cache responses** to reduce API calls
   ```dart
   final cachedUser = _userCache[userId];
   if (cachedUser != null) return cachedUser;
   ```

### Security

1. **Always validate** on server (security rules)
2. **Never expose** API keys in client code
3. **Use HTTPS** for all requests
4. **Encrypt tokens** before storing locally
5. **Validate input** before sending

### Error Handling

```dart
try {
  final user = await getUser(userId);
  return user;
} on FirebaseAuthException catch (e) {
  // Handle auth-specific errors
  print('Auth error: ${e.code}');
} on FirebaseException catch (e) {
  // Handle Firebase errors
  print('Firebase error: ${e.code}');
} catch (e) {
  // Handle generic errors
  print('Unknown error: $e');
}
```

---

## Changelog

### v1.0.0 (January 2026)
- Initial API documentation
- Firebase Auth endpoints
- Firestore CRUD operations
- Cloud Storage integration
- Rate limiting documentation
- Security best practices

---

## Support

For issues or questions:
1. Check [ARCHITECTURE.md](../ARCHITECTURE.md) for architecture details
2. Review [Concept-4 Documentation](../CONCEPT_4_DOCUMENTATION.md) for patterns
3. Check Firebase Console for service status
4. Review [Troubleshooting Guide](../ARCHITECTURE.md#common-issues--solutions)

