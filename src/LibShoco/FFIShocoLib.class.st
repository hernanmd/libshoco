"
Shoco is a MIT-licensed C library which provides fast compressor for short strings optimized by default for English words, but customizable to other alphabet models based on your own data. Compression is performed using [entropy encoding](https://en.wikipedia.org/wiki/Entropy_encoding)

## Usage

You can check the compression size over an ASCII input:

```language=Pharo

'But the suburbs have no charms to soothe
The restless dreams of youth' size. ""69""

(FFIShocoLib uniqueInstance shocoCompress: 'But the suburbs have no charms to soothe
The restless dreams of youth') size. ""49""
```

Of course Shoco should decompress to the same input `String`:

```language=Pharo
FFIShocoLib uniqueInstance shocoDecompress: 
	(FFIShocoLib uniqueInstance shocoCompress: 'The city shark is at the dark end of the alleyway').
```

## Customization

You should follow two steps:

1. Check the [project documentation](https://ed-von-schleck.github.io/shoco/#generating-compression-models) to generate a new compression model for your input.
2. Visit this project [home page](https://github.com/hernanmd/libshoco) to  generate a new library and include it in your path.

"
Class {
	#name : #FFIShocoLib,
	#superclass : #FFILibrary,
	#category : #LibShoco
}

{ #category : #'accessing - platform' }
FFIShocoLib >> macLibraryFileName [

	^ 'libshoco.dylib'

]

{ #category : #'accessing - platform' }
FFIShocoLib >> macLibraryName [
	"Private - See superclass comment"

	^ FFIMacLibraryFinder new 
		userPaths: { FileLocator workingDirectory };
		findAnyLibrary: { self macLibraryFileName }

]

{ #category : #accessing }
FFIShocoLib >> shocoCompress: inputString [
	"Answer the <Number> of bytes written"
	| cArray nBytes |

	cArray := (FFIArray externalNewType: 'char' size: inputString size) autoRelease.
	nBytes := self 
		shocoCompress: inputString 
		length: 0
		output: cArray getHandle
		bufSize: inputString size.
	^ cArray copyFirst: nBytes
]

{ #category : #accessing }
FFIShocoLib >> shocoCompress: inputString length: lenInteger output: outString bufSize: bufSize [
	"Answer the <Number> of bytes written"

	^ self ffiCall: #(size_t shoco_compress(const char * inputString, size_t lenInteger, char * outString, size_t bufSize))
]

{ #category : #accessing }
FFIShocoLib >> shocoCompress: inputString output: outString bufSize: bufSize [

	^ self shocoCompress: inputString length: 0 output: outString bufSize: bufSize
]

{ #category : #accessing }
FFIShocoLib >> shocoDecompress: inputString [
	"Decompress the compressed inputString. Answer a <String>"
	| outString nBytes bufSize in |
	
	bufSize := inputString size * 4.
	outString := FFIExternalArray externalNewType: 'char' size: bufSize.
	in := inputString asShocoFFIExternalArrayOfType: 'char'.
	nBytes := self 
		shocoDecompress: in getHandle
		length: inputString size
		output: outString getHandle
		bufSize: bufSize.
	^ outString asNullTerminatedString
]

{ #category : #accessing }
FFIShocoLib >> shocoDecompress: inputString length: lenInteger output: outString bufSize: bufSize [
	"Answer the <Number> of bytes written"

	^ self ffiCall: #(size_t shoco_decompress(const char * inputString, size_t lenInteger, char * outString, size_t bufSize))
]

{ #category : #'accessing - platform' }
FFIShocoLib >> unixLibraryFileName [

	^ 'libshoco.so'
]

{ #category : #'accessing - platform' }
FFIShocoLib >> unixLibraryName [
	"Private - See superclass comment"

	^ FFIUnixLibraryFinder new 
		userPaths: { FileLocator workingDirectory };
		findAnyLibrary: { self unixLibraryFileName }.

]

{ #category : #'accessing - platform' }
FFIShocoLib >> win32LibraryFileName [

	^ 'libshoco.dll'
]

{ #category : #'accessing - platform' }
FFIShocoLib >> win32LibraryName [
	"Private - See superclass comment"

	^ FFIWindowsLibraryFinder new 
		userPaths: { FileLocator workingDirectory };
		findAnyLibrary: { self win32LibraryFileName }
]
