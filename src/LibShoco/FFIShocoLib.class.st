Class {
	#name : #FFIShocoLib,
	#superclass : #FFILibrary,
	#category : #LibShoco
}

{ #category : #'accessing - platform' }
FFIShocoLib >> macLibraryName [
	
	^ 'libshoco.dylib'

]

{ #category : #accessing }
FFIShocoLib >> shocoCompress: inputString [
	"Answer the <Number> of bytes written"
	| outString |

	outString := String new: inputString size.
	^ self shocoCompress: inputString length: 0 output: outString bufSize: outString size
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
FFIShocoLib >> shocoDecompress: inputString length: lenInteger output: outString bufSize: bufSize [

	^ self ffiCall: #(size_t shoco_decompress(const char * inputString, size_t lenInteger, char * outString, size_t bufSize))
]

{ #category : #accessing }
FFIShocoLib >> shocoDecompress: inputString output: outString bufSize: bufSize [

	^ self shocoDecompress: inputString length: 0 output: outString bufSize: bufSize
]

{ #category : #'accessing - platform' }
FFIShocoLib >> unixLibraryName [
	
	^ 'libshoco.so'

]

{ #category : #'accessing - platform' }
FFIShocoLib >> win32LibraryName [
	
	^ 'libshoco.dll'

]
