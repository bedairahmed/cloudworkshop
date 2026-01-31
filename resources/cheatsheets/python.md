# Python Cheatsheet

## What is Python?

Python is a high-level, interpreted programming language known for its simplicity and readability. It's widely used in web development, data science, automation, DevOps scripting, machine learning, and cloud infrastructure. Python's extensive library ecosystem makes it ideal for virtually any programming task.

---

## Why Use Python?

- **Easy to Learn** - Clean, readable syntax
- **Versatile** - Web, data science, automation, AI/ML
- **Large Ecosystem** - Thousands of packages available
- **Cross-Platform** - Runs on Windows, Mac, Linux
- **DevOps Friendly** - Great for scripting and automation
- **Cloud SDKs** - Official SDKs for Azure, AWS, GCP

---

## Installation

### Windows

```powershell
# Using winget
winget install Python.Python.3.12

# Or download from
# https://www.python.org/downloads/
```

### Mac

```bash
# Using Homebrew
brew install python@3.12

# Or download from python.org
```

### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install python3 python3-pip python3-venv
```

### Verify Installation

```bash
python --version
python3 --version
pip --version
```

---

## Virtual Environments

```bash
# Create virtual environment
python -m venv venv

# Activate (Linux/Mac)
source venv/bin/activate

# Activate (Windows)
venv\Scripts\activate

# Deactivate
deactivate

# Install packages in venv
pip install requests

# Save dependencies
pip freeze > requirements.txt

# Install from requirements
pip install -r requirements.txt
```

---

## Basic Syntax

### Variables & Data Types

```python
# Variables (no type declaration needed)
name = "John"
age = 30
price = 19.99
is_active = True

# Type checking
type(name)  # <class 'str'>

# Type conversion
str(42)      # "42"
int("42")    # 42
float("3.14") # 3.14
bool(1)      # True

# Multiple assignment
x, y, z = 1, 2, 3
a = b = c = 0
```

### Strings

```python
# String creation
name = "John"
message = 'Hello'
multiline = """
This is a
multiline string
"""

# String formatting (f-strings - recommended)
name = "Alice"
age = 30
print(f"Name: {name}, Age: {age}")

# String methods
text = "hello world"
text.upper()        # "HELLO WORLD"
text.lower()        # "hello world"
text.capitalize()   # "Hello world"
text.title()        # "Hello World"
text.strip()        # Remove whitespace
text.split()        # ["hello", "world"]
text.replace("world", "python")  # "hello python"
text.startswith("hello")  # True
text.endswith("world")    # True

# String slicing
s = "Python"
s[0]      # "P"
s[-1]     # "n"
s[0:3]    # "Pyt"
s[::2]    # "Pto" (every 2nd char)
s[::-1]   # "nohtyP" (reverse)

# Join
"-".join(["a", "b", "c"])  # "a-b-c"
```

### Lists

```python
# Create list
fruits = ["apple", "banana", "orange"]
numbers = [1, 2, 3, 4, 5]
mixed = [1, "hello", True, 3.14]

# Access elements
fruits[0]      # "apple"
fruits[-1]     # "orange"
fruits[1:3]    # ["banana", "orange"]

# List methods
fruits.append("grape")     # Add to end
fruits.insert(0, "mango")  # Insert at index
fruits.remove("banana")    # Remove by value
fruits.pop()               # Remove and return last
fruits.pop(0)              # Remove and return at index
fruits.sort()              # Sort in place
fruits.reverse()           # Reverse in place
len(fruits)                # Length

# List comprehension
squares = [x**2 for x in range(10)]
evens = [x for x in range(20) if x % 2 == 0]
```

### Dictionaries

```python
# Create dictionary
person = {
    "name": "John",
    "age": 30,
    "city": "New York"
}

# Access values
person["name"]           # "John"
person.get("name")       # "John"
person.get("email", "N/A")  # "N/A" (default)

# Modify
person["age"] = 31
person["email"] = "john@example.com"

# Dictionary methods
person.keys()    # dict_keys(['name', 'age', 'city'])
person.values()  # dict_values(['John', 30, 'New York'])
person.items()   # dict_items([('name', 'John'), ...])
person.pop("age")  # Remove and return value

# Dictionary comprehension
squares = {x: x**2 for x in range(5)}
# {0: 0, 1: 1, 2: 4, 3: 9, 4: 16}
```

### Control Flow

```python
# If/elif/else
age = 18
if age < 13:
    print("Child")
elif age < 20:
    print("Teenager")
else:
    print("Adult")

# Ternary operator
status = "adult" if age >= 18 else "minor"

# For loop
for fruit in fruits:
    print(fruit)

for i in range(5):      # 0, 1, 2, 3, 4
    print(i)

for i, fruit in enumerate(fruits):
    print(f"{i}: {fruit}")

# While loop
count = 0
while count < 5:
    print(count)
    count += 1

# Break and continue
for i in range(10):
    if i == 3:
        continue    # Skip this iteration
    if i == 7:
        break       # Exit loop
    print(i)
```

### Functions

```python
# Basic function
def greet(name):
    return f"Hello, {name}!"

# Default parameters
def greet(name="World"):
    return f"Hello, {name}!"

# Multiple parameters
def add(a, b):
    return a + b

# *args (variable positional arguments)
def sum_all(*args):
    return sum(args)

sum_all(1, 2, 3, 4)  # 10

# **kwargs (variable keyword arguments)
def print_info(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")

print_info(name="John", age=30)

# Lambda functions
square = lambda x: x**2
add = lambda a, b: a + b
```

### Classes

```python
class Person:
    # Class variable
    species = "Human"
    
    # Constructor
    def __init__(self, name, age):
        self.name = name    # Instance variable
        self.age = age
    
    # Instance method
    def greet(self):
        return f"Hello, I'm {self.name}"
    
    # String representation
    def __str__(self):
        return f"Person({self.name}, {self.age})"

# Create instance
person = Person("Alice", 30)
print(person.greet())
print(person.name)

# Inheritance
class Employee(Person):
    def __init__(self, name, age, employee_id):
        super().__init__(name, age)
        self.employee_id = employee_id
    
    def work(self):
        return f"{self.name} is working"
```

---

## File Operations

```python
# Read file
with open("file.txt", "r") as f:
    content = f.read()        # Read entire file
    
with open("file.txt", "r") as f:
    lines = f.readlines()     # Read as list of lines

# Write file
with open("file.txt", "w") as f:
    f.write("Hello, World!")

# Append to file
with open("file.txt", "a") as f:
    f.write("\nNew line")

# Read JSON
import json
with open("data.json", "r") as f:
    data = json.load(f)

# Write JSON
with open("data.json", "w") as f:
    json.dump(data, f, indent=2)

# Read YAML
import yaml
with open("config.yaml", "r") as f:
    config = yaml.safe_load(f)

# Write YAML
with open("config.yaml", "w") as f:
    yaml.dump(config, f)
```

---

## Error Handling

```python
# Try/except
try:
    result = 10 / 0
except ZeroDivisionError:
    print("Cannot divide by zero!")
except Exception as e:
    print(f"Error: {e}")
finally:
    print("This always runs")

# Raise exception
def validate_age(age):
    if age < 0:
        raise ValueError("Age cannot be negative")
    return age

# Custom exception
class CustomError(Exception):
    pass
```

---

## Common Modules

### os - Operating System

```python
import os

# Current directory
os.getcwd()

# Change directory
os.chdir("/path/to/dir")

# List directory
os.listdir(".")

# Create directory
os.mkdir("new_folder")
os.makedirs("path/to/nested/folder")

# Remove
os.remove("file.txt")
os.rmdir("folder")

# Environment variables
os.environ.get("HOME")
os.environ["MY_VAR"] = "value"

# Path operations
os.path.exists("file.txt")
os.path.isfile("file.txt")
os.path.isdir("folder")
os.path.join("path", "to", "file.txt")
os.path.basename("/path/to/file.txt")  # "file.txt"
os.path.dirname("/path/to/file.txt")   # "/path/to"
```

### subprocess - Run Commands

```python
import subprocess

# Run command
result = subprocess.run(["ls", "-la"], capture_output=True, text=True)
print(result.stdout)
print(result.returncode)

# Run with shell
result = subprocess.run("echo Hello", shell=True, capture_output=True, text=True)

# Check output
output = subprocess.check_output(["git", "status"], text=True)
```

### requests - HTTP Requests

```python
import requests

# GET request
response = requests.get("https://api.example.com/data")
print(response.status_code)
print(response.json())

# GET with parameters
response = requests.get(
    "https://api.example.com/search",
    params={"q": "python", "limit": 10}
)

# POST request
response = requests.post(
    "https://api.example.com/data",
    json={"name": "John", "age": 30},
    headers={"Authorization": "Bearer token123"}
)

# Handle errors
response.raise_for_status()  # Raises exception for 4xx/5xx
```

### pathlib - Modern Path Handling

```python
from pathlib import Path

# Create path
p = Path("/home/user/documents")
p = Path.cwd()  # Current directory
p = Path.home()  # Home directory

# Path operations
p / "subfolder" / "file.txt"  # Join paths
p.exists()
p.is_file()
p.is_dir()
p.name       # "file.txt"
p.stem       # "file"
p.suffix     # ".txt"
p.parent     # Parent directory

# Read/write
content = Path("file.txt").read_text()
Path("file.txt").write_text("Hello")

# Iterate directory
for file in Path(".").glob("*.py"):
    print(file)

for file in Path(".").rglob("*.py"):  # Recursive
    print(file)
```

---

## Cloud SDKs

### Azure SDK

```python
# Install
# pip install azure-identity azure-mgmt-resource

from azure.identity import DefaultAzureCredential
from azure.mgmt.resource import ResourceManagementClient

credential = DefaultAzureCredential()
client = ResourceManagementClient(credential, "subscription-id")

# List resource groups
for rg in client.resource_groups.list():
    print(rg.name)
```

### AWS SDK (boto3)

```python
# Install
# pip install boto3

import boto3

# S3 client
s3 = boto3.client('s3')
response = s3.list_buckets()
for bucket in response['Buckets']:
    print(bucket['Name'])

# EC2 client
ec2 = boto3.client('ec2')
instances = ec2.describe_instances()
```

### GCP SDK

```python
# Install
# pip install google-cloud-storage

from google.cloud import storage

client = storage.Client()
buckets = client.list_buckets()
for bucket in buckets:
    print(bucket.name)
```

---

## Quick Reference

| Syntax | Description |
|--------|-------------|
| `print()` | Output to console |
| `input()` | Read user input |
| `len()` | Length of object |
| `range()` | Generate sequence |
| `type()` | Get type of object |
| `str()`, `int()`, `float()` | Type conversion |
| `list()`, `dict()`, `set()` | Create collections |
| `open()` | Open file |
| `import` | Import module |
| `def` | Define function |
| `class` | Define class |
| `if/elif/else` | Conditionals |
| `for/while` | Loops |
| `try/except` | Error handling |

---

## Resources

- [Python Documentation](https://docs.python.org/3/)
- [Real Python Tutorials](https://realpython.com/)
- [Python Package Index (PyPI)](https://pypi.org/)
- [Automate the Boring Stuff](https://automatetheboringstuff.com/)