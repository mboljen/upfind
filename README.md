# upfind

Find files and directories in parent directories

## Synopsis

```console
$ upfind [START] [OPTIONS]...
```

## Description

This script implements a wrapper to the **find** command in order to search files and directories in the parent directories. 

## Options

+ `-h`

  Show this help message


## Installation

Clone the remote repository and change into the local repository:

```console
$ git clone https://github.com/mboljen/upfind
$ cd upfind
```

Use the following command to install this software:

```console
$ make
$ make install
```

The default `PREFIX` is set to `/usr/local`.  In order to successfully complete the installation, you need to have write permissions for the installation location.

## Contribution

Pull requests are welcome.  For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
