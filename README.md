# DC2F 2.0 File Format

The `.dc` file format is designed for defining and executing scripts written in the DeanScript language. This document provides an overview of the structure and components of `.dc` files, including their purpose and usage.

**Note:** This project includes Dean's Console 3, which can code `.dc` files and view them in a text editor like Notepad.

## Overview

A `.dc` file contains a structured script that can be executed by the DC2F interpreter. It includes metadata, script blocks, comments, configuration options, and integrity checks. This format ensures that scripts are well-documented, maintainable, and executable with defined behavior.

## File Structure

Here's a breakdown of the `.dc` file format:

### Header

```
DC2F 2.0
Language: DeanScript
Timestamp: 2024-08-17
```

- **DC2F 2.0**: Indicates the file version and format.
- **Language**: Specifies the scripting language used, in this case, DeanScript.
- **Timestamp**: The date and time when the file was created or last modified.

### Metadata

```
[METADATA]
Author: Dean Dowell
Description: This script prints a greeting message.
Dependencies: utils.deanlib
```

- **Author**: The creator of the script.
- **Description**: A brief explanation of what the script does.
- **Dependencies**: External libraries or modules required by the script.

### Script Block

```
[BEGIN BLOCK: main]
func main() {
    print("Hello, World!");
}
[END BLOCK]
```

- **[BEGIN BLOCK: main]**: Marks the beginning of the script block.
- **func main() { ... }**: Defines the main function or entry point of the script.
- **[END BLOCK]**: Marks the end of the script block.

### Comments

```
[COMMENTS]
# This is a simple script for demonstration purposes.
```

- **[COMMENTS]**: Section for adding notes or explanations within the script.

### Configuration

```
[CONFIG]
execute_on_load = true
```

- **[CONFIG]**: Configuration settings that affect how the script is executed.
- **execute_on_load**: If set to `true`, the script will execute immediately upon loading.

### Checksum

```
Checksum: 89ABCDEF
```

- **Checksum**: A value used to verify the integrity of the file.

### End-of-File Marker

```
EOF-DC2
```

- **EOF-DC2**: Indicates the end of the `.dc` file.

## Example

Here’s an example of a complete `.dc` file:

```
DC2F 2.0
Language: DeanScript
Timestamp: 2024-08-17

[METADATA]
Author: Dean Dowell
Description: This script prints a greeting message.
Dependencies: utils.deanlib

[BEGIN BLOCK: main]
func main() {
    print("Hello, World!");
}
[END BLOCK]

[COMMENTS]
# This is a simple script for demonstration purposes.

[CONFIG]
execute_on_load = true

Checksum: 89ABCDEF
EOF-DC2
```

## Usage

To use a `.dc` file:

1. Ensure that you have Dean's Console 3 installed.
2. Load the `.dc` file into the interpreter.
3. The interpreter will read the file, execute the script as configured, and validate its integrity using the checksum.

## Contributing

Contributions to the `.dc` file format or the DC2F interpreter are welcome. Please follow the standard guidelines for submitting issues or improvements.

## Supported languages in the .dc Code.

The Supported coding languages .dc supports are html, css, js, lua, and .bat, the following is a code part from the Example.
`[html]
<!-- Your HTML content here -->
[css]
/* Your CSS content here */
[js]
// Your JavaScript content here
[bat]
:: Your Batch script here
[lua]
-- Your LUA script here`

## Contact

For any questions or further information, please reach out directly.
