# haxe-clink-externs

[![Build Status](https://github.com/vegardit/haxe-clink-externs/workflows/Build/badge.svg "GitHub Actions")](https://github.com/vegardit/haxe-clink-externs/actions?query=workflow%3A%22Build%22)
[![Release](https://img.shields.io/github/release/vegardit/haxe-clink-externs.svg)](http://lib.haxe.org/p/clink-externs)
[![License](https://img.shields.io/github/license/vegardit/haxe-clink-externs.svg?label=license)](#license)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)

1. [What is it?](#what-is-it)
1. [Installation](#installation)
1. [Using the latest code](#latest)
1. [License](#license)


## <a name="what-is-it"></a>What is it?

A [haxelib](http://lib.haxe.org/documentation/using-haxelib/) with Lua externs for the [Clink API](https://chrisant996.github.io/clink/clink.html#extending-clink-with-lua)
to develop custom command line completions for [Clink](https://github.com/chrisant996/clink).

### Requirements/Limitations

- **Haxe Version:** 4.2.5 or higher
- **Supported Targets:** Lua 5.2 vanilla mode, i.e. `-D lua_vanilla -D lua_ver=5.2`)
- **Supported Operating Systems:** Windows


## <a name="installation"></a>Installation

1. install the library via haxelib using the command:
    ```
    haxelib install clink-externs
    ```

2. use in your Haxe project by adding `-lib clink-externs`  to `your *.hxml` file or as command line option when running the [Haxe compiler](http://haxe.org/manual/compiler-usage.html)


## <a name="latest"></a>Using the latest code


### Using `haxelib git`

```
haxelib git clink-externs https://github.com/vegardit/haxe-clink-externs main D:\haxe-projects\haxe-clink-externs
```

###  Using Git

1. check-out the main branch
    ```
    git clone https://github.com/vegardit/haxe-clink-externs --branch main --single-branch D:\haxe-projects\haxe-clink-externs
    ```

2. register the development release with haxe
    ```
    haxelib dev clink-externs D:\haxe-projects\haxe-clink-externs
    ```


## <a name="license"></a>License

All files are released under the [MIT License](LICENSE.txt).

Individual files contain the following tag instead of the full license text:
```
SPDX-License-Identifier: MIT
```

This enables machine processing of license information based on the SPDX License Identifiers that are available here: https://spdx.org/licenses/.
