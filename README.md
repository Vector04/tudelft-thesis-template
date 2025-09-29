

This repository provides a Typst template to write a thesis in the TU Delft style. 

## Installation (For local use)
1. Make sure you have typst installed.

2. **Clone the repository:**
    ```
    git clone git@gitlab.com:Vector04/typst-template-document.git
    ```

3. Install this repository as a local package

    Windows: 
    ```
    mklink /d typst-template-document C:\Users\Victor\AppData\Local\typst\packages\local\victor-thesis\0.1.0
    ```
    Linux:
    ```
    ln -s typst-template-document ~/.local/share/typst/packages/local/victor-thesis/0.1.0
    ```

## Usage
To start writing your document, use 
```
typst init @local/victor-thesis:0.1.0
```


## License

This project is licensed under the MIT License.