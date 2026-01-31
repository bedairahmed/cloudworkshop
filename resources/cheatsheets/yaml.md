# YAML Cheatsheet

## What is YAML?

YAML (YAML Ain't Markup Language) is a human-readable data serialization format. It's widely used for configuration files in DevOps tools like Kubernetes, Docker Compose, Ansible, CI/CD pipelines, and more. YAML uses indentation to represent structure, making it easy to read and write.

---

## Why Use YAML?

- **Human Readable** - Clean, easy-to-read syntax
- **Widely Adopted** - Standard for Kubernetes, Docker, CI/CD
- **Flexible** - Supports complex data structures
- **Comments** - Unlike JSON, YAML supports comments
- **Multiple Documents** - Single file can contain multiple documents

---

## Key Rules

| Rule | Description |
|------|-------------|
| **Indentation** | Use spaces only (not tabs), typically 2 spaces |
| **Case Sensitive** | `Name` and `name` are different |
| **Colons** | Key-value pairs use `: ` (colon + space) |
| **Dashes** | List items start with `- ` (dash + space) |
| **Comments** | Start with `#` |

---

## Basic Syntax

### Key-Value Pairs (Scalars)

```yaml
# Strings
name: John Doe
message: "Hello, World!"
description: 'Single quotes work too'
multiword: This is also valid without quotes

# Numbers
count: 42
price: 19.99
hex: 0x1A
octal: 0o755

# Booleans
enabled: true
disabled: false
also_true: yes
also_false: no

# Null
empty: null
also_null: ~

# Dates
date: 2025-01-31
datetime: 2025-01-31T10:30:00Z
```

### Strings

```yaml
# Plain strings
name: simple string

# Quoted strings (preserve special characters)
special: "colon: and hash # inside"
escaped: "line1\nline2"           # \n becomes newline

# Literal block (preserves newlines)
description: |
  This is line 1.
  This is line 2.
  Newlines are preserved.

# Literal block with chomp (removes trailing newlines)
text: |-
  Line 1
  Line 2

# Folded block (newlines become spaces)
summary: >
  This is a long
  paragraph that will
  be folded into one line.

# Folded with chomp
summary: >-
  This paragraph
  becomes one line
```

### Lists (Arrays)

```yaml
# Simple list
fruits:
  - apple
  - banana
  - orange

# Inline list
colors: [red, green, blue]

# List of numbers
ports:
  - 80
  - 443
  - 8080

# Mixed types
items:
  - "string"
  - 42
  - true
  - null
```

### Dictionaries (Maps/Objects)

```yaml
# Nested dictionary
person:
  name: John
  age: 30
  email: john@example.com

# Inline dictionary
address: {city: New York, zip: "10001"}

# Deeply nested
database:
  connection:
    host: localhost
    port: 5432
    credentials:
      username: admin
      password: secret
```

### List of Dictionaries

```yaml
# Common pattern in Kubernetes
users:
  - name: Alice
    role: admin
    active: true
  - name: Bob
    role: user
    active: false

# Environment variables
env:
  - name: DATABASE_URL
    value: postgres://localhost:5432/db
  - name: API_KEY
    valueFrom:
      secretKeyRef:
        name: my-secret
        key: api-key
```

### Dictionary of Lists

```yaml
# Permissions by role
permissions:
  admin:
    - read
    - write
    - delete
  user:
    - read
    - write
  guest:
    - read
```

---

## Advanced Features

### Anchors & Aliases (Reuse)

```yaml
# Define anchor with &
defaults: &default_settings
  timeout: 30
  retries: 3
  logging: true

# Reference with *
development:
  <<: *default_settings         # Merge defaults
  debug: true

production:
  <<: *default_settings         # Merge defaults
  timeout: 60                   # Override specific value
  debug: false

# Anchor for value
base_image: &image nginx:1.25

services:
  web:
    image: *image               # Use anchor
  api:
    image: *image               # Reuse
```

### Multiple Documents

```yaml
# Document 1
apiVersion: v1
kind: ConfigMap
metadata:
  name: config-1
data:
  key: value

---                             # Document separator

# Document 2
apiVersion: v1
kind: ConfigMap
metadata:
  name: config-2
data:
  key: another-value
```

---

## Common Patterns

### Kubernetes Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  labels:
    app: my-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: my-app
          image: my-app:1.0.0
          ports:
            - containerPort: 8080
          env:
            - name: ENV
              value: production
```

### Docker Compose

```yaml
version: "3.8"

services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    depends_on:
      - db

  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: secret
    volumes:
      - db-data:/var/lib/postgresql/data

volumes:
  db-data:
```

---

## Common Mistakes

```yaml
# ❌ Wrong - using tabs
name:
	value                    # Tab character

# ✅ Correct - using spaces
name:
  value                      # 2 spaces

# ❌ Wrong - no space after colon
key:value

# ✅ Correct
key: value

# ❌ Wrong - inconsistent indentation
items:
  - one
   - two                     # 3 spaces instead of 2

# ✅ Correct
items:
  - one
  - two

# ❌ Wrong - special characters unquoted
message: Hello: World        # Colon breaks parsing

# ✅ Correct
message: "Hello: World"
```

---

## YAML Validation

```bash
# Using Python
python -c "import yaml; yaml.safe_load(open('file.yaml'))"

# Using yamllint
pip install yamllint
yamllint file.yaml

# Online validators
# - https://www.yamllint.com/
# - https://yamlvalidator.com/
```

---

## Quick Reference

| Syntax | Description |
|--------|-------------|
| `key: value` | Key-value pair |
| `- item` | List item |
| `#` | Comment |
| `---` | Document separator |
| `\|` | Literal block (preserve newlines) |
| `>` | Folded block (join lines) |
| `&name` | Define anchor |
| `*name` | Reference anchor |
| `<<:` | Merge anchor |
| `~` or `null` | Null value |

---

## Resources

- [YAML Specification](https://yaml.org/spec/)
- [Learn YAML in Y Minutes](https://learnxinyminutes.com/docs/yaml/)
- [YAML Lint](https://www.yamllint.com/)