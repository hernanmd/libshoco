"
A FFIShocoLibTest is a test class for testing the behavior of FFIShocoLib
"
Class {
	#name : #FFIShocoLibTest,
	#superclass : #TestCase,
	#instVars : [
		'shocoLib',
		'largeString',
		'nonAsciiString'
	],
	#category : #'LibShoco-Tests'
}

{ #category : #running }
FFIShocoLibTest >> setUp [

	super setUp.
	shocoLib := FFIShocoLib uniqueInstance.
	largeString := 'This is a large string that won''t possibly fit into a small buffer'.
	nonAsciiString := 'Übergrößenträger'.

]

{ #category : #tests }
FFIShocoLibTest >> testShocoCompress [

	| nrBytesWritten |
	
	nrBytesWritten := shocoLib shocoCompress: largeString.
	self assert: nrBytesWritten <= largeString size.
	
	nrBytesWritten := shocoLib shocoCompress: 'a'.
	self assert: nrBytesWritten equals: 1.
	
	
]

{ #category : #tests }
FFIShocoLibTest >> testShocoCompressLengthOutputBufSize [

	| nrBytesWritten outString |
	
	outString := 'x   '.
	nrBytesWritten := shocoLib shocoCompress: 'test' length: 1 output: outString bufSize: 4.
	self 
		assert: nrBytesWritten 
		equals: 1.
	self
		assert: outString first
		equals: $x
]

{ #category : #tests }
FFIShocoLibTest >> testShocoCompressOutputBufSize [

	| nrBytesWritten outString |
	
	nrBytesWritten := shocoLib shocoCompress: largeString output: (String new: 2) bufSize: 2.
	self assert: nrBytesWritten equals: 3.
	
	outString := 'x '.
	nrBytesWritten := shocoLib shocoCompress: 'a' output: outString bufSize: 2.
	self assert: nrBytesWritten equals: 1.
	self assert: outString equals: 'x '.
	
	outString := '   '.
	nrBytesWritten := shocoLib shocoCompress: 'a' output: outString bufSize: 4.
	self assert: nrBytesWritten equals: 1.
	
	nrBytesWritten := shocoLib shocoCompress: 'test' output: outString  bufSize: 4.
	self assert: nrBytesWritten <= 4.
	
	outString := ' '.
	nrBytesWritten := shocoLib shocoCompress: 'ä' output: outString bufSize: 1.
	self assert: nrBytesWritten equals: 2.
]

{ #category : #tests }
FFIShocoLibTest >> testShocoDecompressLengthOutputBufSize [

	| bufSize bufLarge nrBytesWritten compressedLarge compressedLength largeLength |
	
	bufSize := 2.
	bufLarge := (FFIExternalArray externalNewType: 'char' size: bufSize)	 autoRelease.
	largeLength := largeString size.
	compressedLarge := (FFIExternalArray externalNewType: #char size: bufSize)	 autoRelease.
	
	compressedLength := shocoLib 
		shocoCompress: largeString 
		output: compressedLarge getHandle
		bufSize: bufSize.
	nrBytesWritten := shocoLib 
		shocoDecompress: compressedLarge getHandle
		length: compressedLength 
		output: bufLarge getHandle
		bufSize: bufSize.

	"// nrBytesWritten = bufsize + 1, because buffer too small"
	self assert: nrBytesWritten equals: 3.

	nrBytesWritten := shocoLib 
		shocoDecompress: compressedLarge getHandle
		length: 5 
		output: bufLarge getHandle
		bufSize: bufSize.
		
	self assert: (nrBytesWritten < largeLength or: [ nrBytesWritten = 4097 ]).
]

{ #category : #tests }
FFIShocoLibTest >> testShocoDecompressNonAscii [

	| bufSize compressedNonAscii nrBytesWritten compressedLength nonAsciiLength bufLarge |
	
	bufSize := 256.
	compressedNonAscii := (FFIExternalArray externalNewType: 'char' size: bufSize) autoRelease.
	nonAsciiLength := nonAsciiString size.
	bufLarge := (FFIExternalArray externalNewType: #char size: bufSize)	 autoRelease.
	
	compressedLength := shocoLib 
		shocoCompress: nonAsciiString 
		output: compressedNonAscii getHandle
		bufSize: bufSize.
	bufLarge at: nonAsciiLength put: $x.
	nrBytesWritten := shocoLib 
		shocoDecompress: compressedNonAscii getHandle
		length: compressedLength 
		output: bufLarge getHandle
		bufSize: 4096.

	self assert: nrBytesWritten equals: compressedNonAscii asNullTerminatedString size.

	
]

{ #category : #tests }
FFIShocoLibTest >> testShocoDecompressOutputBufSize [

	| bufSize bufLarge nrBytesWritten compressedLarge compressedLength largeLength |
	
	bufSize := 4096.
	bufLarge := (FFIExternalArray externalNewType: 'char' size: bufSize)	 autoRelease.
	largeLength := largeString size.
	compressedLarge := (FFIExternalArray externalNewType: #char size: bufSize)	 autoRelease.
	
	compressedLength := shocoLib 
		shocoCompress: largeString 
		output: compressedLarge getHandle
		bufSize: bufSize.
	nrBytesWritten := shocoLib 
		shocoDecompress: compressedLarge getHandle
		length: compressedLength 
		output: bufLarge getHandle
		bufSize: bufSize.

	self assert: nrBytesWritten equals: largeLength.
	self assert: bufLarge asNullTerminatedString equals: largeString.
	"no null byte written"
	self deny: bufLarge asNullTerminatedString last equals: Character null.

]
