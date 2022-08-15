[![license-badge](https://img.shields.io/badge/license-MIT-blue.svg)](https://img.shields.io/badge/license-MIT-blue.svg)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![GitHub Workflow Status](https://github.com/hernanmd/libshoco/actions/workflows/CI.yml/badge.svg)](https://github.com/hernanmd/libshoco/actions/workflows/CI.yml)
[![Coverage Status](https://coveralls.io/repos/github/hernanmd/libshoco/badge.svg?branch=master)](https://coveralls.io/github/hernanmd/libshoco?branch=master)

# Table of Contents

- [Description](#description)
- [Installation](#installation)
  - [How to compile the library](#how-to-compile-the-library)
  - [Baseline String](#baseline-string)
- [Usage](#usage)
- [Contribute](#contribute)
  - [Version management](#version-management)
- [License](#license)

# Description

Shoco is a MIT-licensed C library which provides fast compressor for short strings optimized by default for English words, but customizable to other alphabet models based on your own data. Compression is performed using [entropy encoding](https://en.wikipedia.org/wiki/Entropy_encoding). Shoco exposes two functions, one to compress an input String and another one to decompress. Please read the [library documentation](https://ed-von-schleck.github.io/shoco/) for use cases and technical notes.

# Installation

```smalltalk
EpMonitor disableDuring: [ 
	Metacello new	
		baseline: 'LibShoco';	
		repository: 'github://hernanmd/libshoco/src';	
		load ].
```

The library should be already detected automatically for your platform. If it is not the case, please open an [issue](https://github.com/hernanmd/libshoco/issues).

## How to compile the library

Instead of using the library provided in this repository, you can compile your own version in your box. In that case first make sure you have clang installed and clone the shoco repository:

### macOS

```bash
git clone https://github.com/Ed-von-Schleck/shoco.git
cd shoco
clang -shared -undefined dynamic_lookup -o libshoco.dylib shoco.c
```
### Windows

```bash
git clone https://github.com/yogo1212/shoco.git
cd shoco/; git checkout python3
clang -shared -o libshoco.dll shoco.c 
```

### Linux

TBD

You should end with a library file (.dylib in macOS, .dll in Windows or .so in Linux) which you should have to copy to your Pharo.image path. If your image is already running, you need to reload the library or re-launch Pharo.

## Baseline String 

If you want to add the LibShoco to your Metacello Baselines or Configurations, copy and paste the following expression:

```smalltalk
	" ... "
	spec
		baseline: 'LibShoco' 
		with: [ spec repository: 'github://hernanmd/libshoco/src' ];
	" ... "
```

# Usage

You can verify its working by sending decompress over a compressed String:

```smalltalk
FFIShocoLib uniqueInstance shocoDecompress: 
  (FFIShocoLib uniqueInstance shocoCompress: 'The city shark is at the dark end of the alleyway').
```

# Contribute

**Working on your first Pull Request?** You can learn how from this *free* series [How to Contribute to an Open Source Project on GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github)

If you have discovered a bug or have a feature suggestion, feel free to create an issue on Github.
If you have any suggestions for how this package could be improved, please get in touch or suggest an improvement using the GitHub issues page.
If you'd like to make some changes yourself, see the following:    

  - Fork this repository to your own GitHub account and then clone it to your local device
  - Do some modifications
  - Test.
  - Add <your GitHub username> to add yourself as author below.
  - Finally, submit a pull request with your changes!
  - This project follows the [all-contributors specification](https://github.com/kentcdodds/all-contributors). Contributions of any kind are welcome!

## Version management 

This project use semantic versioning to define the releases. This means that each stable release of the project will be assigned a version number of the form `vX.Y.Z`. 

- **X** defines the major version number
- **Y** defines the minor version number 
- **Z** defines the patch version number

When a release contains only bug fixes, the patch number increases. When the release contains new features that are backward compatible, the minor version increases. When the release contains breaking changes, the major version increases. 

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.

# License
	
This software is licensed under the MIT License.

Copyright Hernán Morales Durand, 2022.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Authors

Hernán Morales Durand
