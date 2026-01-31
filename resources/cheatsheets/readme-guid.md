# README.md Cheatsheet

## What is a README?

A README is the first file visitors see when they visit your repository. It's a markdown file that explains what your project does, how to install and use it, and how to contribute. A good README can make the difference between someone using your project or moving on.

---

## Why Write a Good README?

- **First Impressions** - README is often the first thing people see
- **Documentation** - Explains how to use your project
- **Onboarding** - Helps new contributors get started
- **Discoverability** - Better READMEs improve search rankings
- **Professionalism** - Shows you care about your project
- **Time Saver** - Reduces repetitive questions

---

## Essential Sections

Every good README should include:

1. **Project Title & Description**
2. **Installation Instructions**
3. **Usage Examples**
4. **Features**
5. **Contributing Guidelines**
6. **License**

---

## README Template

```markdown
# Project Name

Short description of what this project does and who it's for.

![Build Status](https://github.com/username/repo/workflows/CI/badge.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Version](https://img.shields.io/badge/version-1.0.0-green.svg)

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [API Reference](#api-reference)
- [Contributing](#contributing)
- [License](#license)

## Features

- ✅ Feature one
- ✅ Feature two
- ✅ Feature three
- 🚧 Feature four (coming soon)

## Demo

![Demo GIF](docs/images/demo.gif)

Or link to live demo: [Live Demo](https://example.com)

## Installation

### Prerequisites

- Node.js 18+
- npm or yarn
- Docker (optional)

### Quick Start

```bash
# Clone the repository
git clone https://github.com/username/project.git

# Navigate to directory
cd project

# Install dependencies
npm install

# Start the application
npm start
```

### Docker

```bash
docker run -p 3000:3000 username/project
```

## Usage

### Basic Example

```javascript
const project = require('project');

const result = project.doSomething('input');
console.log(result);
```

### Advanced Example

```javascript
const project = require('project');

const config = {
  option1: true,
  option2: 'value'
};

const instance = new project.Client(config);
await instance.connect();
```

## Configuration

Create a `.env` file in the root directory:

```env
DATABASE_URL=postgres://localhost:5432/mydb
API_KEY=your-api-key
DEBUG=true
```

| Variable | Description | Default |
|----------|-------------|---------|
| `DATABASE_URL` | Database connection string | Required |
| `API_KEY` | API authentication key | Required |
| `DEBUG` | Enable debug mode | `false` |

## API Reference

### `doSomething(input)`

Performs the main operation.

**Parameters:**
- `input` (string): The input value

**Returns:**
- (Promise<Object>): The result object

**Example:**
```javascript
const result = await doSomething('test');
// { success: true, data: '...' }
```

## Project Structure

```
project/
├── src/
│   ├── index.js
│   ├── utils/
│   └── components/
├── tests/
├── docs/
├── .github/
│   └── workflows/
├── package.json
└── README.md
```

## Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) first.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Testing

```bash
# Run all tests
npm test

# Run with coverage
npm run test:coverage

# Run specific test
npm test -- --grep "test name"
```

## Roadmap

- [x] Initial release
- [x] Add feature X
- [ ] Add feature Y
- [ ] Mobile support
- [ ] Internationalization

See the [open issues](https://github.com/username/project/issues) for a full list of proposed features.

## FAQ

<details>
<summary>How do I do X?</summary>

Answer to the question about X.
</details>

<details>
<summary>Why doesn't Y work?</summary>

Answer to the question about Y.
</details>

## Troubleshooting

### Common Issues

**Error: Module not found**
```bash
npm install
```

**Error: Port already in use**
```bash
lsof -i :3000
kill -9 <PID>
```

## Acknowledgments

- [Library 1](https://example.com) - Description
- [Library 2](https://example.com) - Description
- Inspired by [Project](https://example.com)

## Authors

- **Your Name** - *Initial work* - [@username](https://github.com/username)

See the list of [contributors](https://github.com/username/project/contributors).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- 📧 Email: support@example.com
- 💬 Discord: [Join Server](https://discord.gg/example)
- 🐦 Twitter: [@username](https://twitter.com/username)

---

Made with ❤️ by [Your Name](https://github.com/username)
```

---

## Markdown Syntax Reference

### Headings

```markdown
# Heading 1
## Heading 2
### Heading 3
#### Heading 4
```

### Text Formatting

```markdown
**Bold text**
*Italic text*
~~Strikethrough~~
`Inline code`
```

### Lists

```markdown
# Unordered
- Item 1
- Item 2
  - Nested item

# Ordered
1. First
2. Second
3. Third

# Task list
- [x] Completed task
- [ ] Incomplete task
```

### Links & Images

```markdown
# Link
[Link text](https://example.com)

# Image
![Alt text](image.png)

# Image with link
[![Alt text](image.png)](https://example.com)

# Reference style
[link text][reference]
[reference]: https://example.com
```

### Code Blocks

````markdown
# Inline code
Use `npm install` to install.

# Code block with syntax highlighting
```javascript
const hello = "world";
console.log(hello);
```

```bash
npm install
npm start
```

```yaml
name: CI
on: push
```
````

### Tables

```markdown
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Row 1    | Data     | Data     |
| Row 2    | Data     | Data     |

# Alignment
| Left | Center | Right |
|:-----|:------:|------:|
| L    | C      | R     |
```

### Blockquotes

```markdown
> This is a quote.
>
> It can span multiple lines.

> **Note:** Important information here.

> **Warning:** Be careful!
```

### Collapsible Sections

```markdown
<details>
<summary>Click to expand</summary>

Hidden content here.

- Item 1
- Item 2

</details>
```

### Badges

```markdown
# Shields.io badges
![Build](https://img.shields.io/github/actions/workflow/status/user/repo/ci.yml)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Version](https://img.shields.io/npm/v/package.svg)
![Downloads](https://img.shields.io/npm/dm/package.svg)

# Custom badge
![Custom](https://img.shields.io/badge/custom-badge-orange.svg)
```

### Emojis

```markdown
:rocket: :star: :bug: :sparkles: :memo:
:white_check_mark: :x: :warning: :bulb:

# Or use Unicode
🚀 ⭐ 🐛 ✨ 📝 ✅ ❌ ⚠️ 💡
```

---

## Best Practices

### Do's ✅

- Keep it concise but complete
- Include working code examples
- Add screenshots/GIFs for visual projects
- Keep installation steps simple
- Update README when project changes
- Use badges for quick status overview
- Include table of contents for long READMEs

### Don'ts ❌

- Don't leave it empty or minimal
- Don't include outdated information
- Don't assume knowledge level
- Don't forget to explain prerequisites
- Don't skip the license section
- Don't include sensitive information

---

## README for Different Projects

### Library/Package

Focus on: Installation, API documentation, examples

### CLI Tool

Focus on: Installation, command reference, flags/options

### Web Application

Focus on: Demo link, screenshots, setup instructions

### API

Focus on: Authentication, endpoints, request/response examples

### Tutorial/Learning

Focus on: Prerequisites, step-by-step instructions, exercises

---

## Tools

### README Generators

- [readme.so](https://readme.so/) - Interactive editor
- [Make a README](https://www.makeareadme.com/) - Simple generator
- [GitHub Profile README Generator](https://rahuldkjain.github.io/gh-profile-readme-generator/)

### Badges

- [Shields.io](https://shields.io/) - Custom badges
- [Badge Generator](https://badgen.net/) - Fast badge service

### Screenshots & GIFs

- [Carbon](https://carbon.now.sh/) - Beautiful code screenshots
- [Terminalizer](https://terminalizer.com/) - Terminal GIF recorder
- [LICEcap](https://www.cockos.com/licecap/) - GIF screen recorder

---

## Quick Reference

| Element | Syntax |
|---------|--------|
| Heading | `# H1` `## H2` `### H3` |
| Bold | `**text**` |
| Italic | `*text*` |
| Code | `` `code` `` |
| Link | `[text](url)` |
| Image | `![alt](url)` |
| List | `- item` or `1. item` |
| Quote | `> quote` |
| Table | `\| col \| col \|` |
| Checkbox | `- [x] done` |

---

## Resources

- [GitHub Markdown Guide](https://docs.github.com/en/get-started/writing-on-github)
- [Awesome README](https://github.com/matiassingers/awesome-readme)
- [Standard README](https://github.com/RichardLitt/standard-readme)
- [Make a README](https://www.makeareadme.com/)