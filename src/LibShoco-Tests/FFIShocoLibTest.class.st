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
FFIShocoLibTest >> handleFileEx: ex [

	(ex isKindOf: FileExists) ifFalse: [ ^ self ].
	self traceCrTab: 'Deleting existing file ' , ex fullName.
	ex ensureDelete.
	self traceCrTab: 'Done deleting file ' , ex fullName.
	ex retry
]

{ #category : #running }
FFIShocoLibTest >> setUp [

	super setUp.
	shocoLib := FFIShocoLib uniqueInstance.
	largeString := 'This is a large string that won''t possibly fit into a small buffer'.
	nonAsciiString := 'Übergrößenträger'.
	LibShocoBridge useGitBridge: false.
	self writeLibraryInTempLocation.

]

{ #category : #running }
FFIShocoLibTest >> tearDown [ 

	[ LibShocoBridge root ensureDeleteAll ]
	on: FileDoesNotExistException
	do: [ : ex | ].		
	LibShocoBridge useGitBridge: true.
	super tearDown.
]

{ #category : #tests }
FFIShocoLibTest >> testShocoCompress [

	| outString |
	
	outString := shocoLib shocoCompress: largeString.
	self assert: outString size <= largeString size.
	
	outString := shocoLib shocoCompress: 'a'.
	self assert: outString size equals: 1.
]

{ #category : #tests }
FFIShocoLibTest >> testShocoCompressLengthOutputBufSize [

	| nBytes outString |
	
	outString := 'x   '.
	nBytes := shocoLib shocoCompress: 'test' length: 1 output: outString bufSize: 4.
	self 
		assert: nBytes 
		equals: 1.
	self
		assert: outString first
		equals: $x
]

{ #category : #tests }
FFIShocoLibTest >> testShocoCompressOutputBufSize [
	| nBytes outString |
	
	nBytes := shocoLib shocoCompress: largeString output: (String new: 2) bufSize: 2.
	self assert: nBytes equals: 3.
	
	outString := 'x '.
	nBytes := shocoLib shocoCompress: 'a' output: outString bufSize: 2.
	self assert: nBytes equals: 1.
	self assert: outString equals: 'x '.
	
	outString := '   '.
	nBytes := shocoLib shocoCompress: 'a' output: outString bufSize: 4.
	self assert: nBytes equals: 1.
	
	nBytes := shocoLib shocoCompress: 'test' output: outString  bufSize: 4.
	self assert: nBytes <= 4.
	
	outString := ' '.
	nBytes := shocoLib shocoCompress: 'ä' output: outString bufSize: 1.
	self assert: nBytes equals: 2.
]

{ #category : #tests }
FFIShocoLibTest >> testShocoDecompress [

	| inString compressedString uncompressedString |
	
	inString := 'The city shark is at the dark end of the alleyway'.
	compressedString := FFIShocoLib uniqueInstance shocoCompress: inString.
	uncompressedString := FFIShocoLib uniqueInstance shocoDecompress: compressedString.
	
	self assert: inString equals: uncompressedString

]

{ #category : #tests }
FFIShocoLibTest >> testShocoDecompressLengthOutputBufSize [
	| bufSize bufLarge nBytes compressedLarge compressedLength largeLength |
	
	bufSize := 2.
	bufLarge := (FFIExternalArray externalNewType: 'char' size: bufSize)	 autoRelease.
	largeLength := largeString size.
	compressedLarge := (FFIExternalArray externalNewType: #char size: bufSize)	 autoRelease.
	
	compressedLength := shocoLib 
		shocoCompress: largeString 
		output: compressedLarge getHandle
		bufSize: bufSize.

	nBytes := shocoLib 
		shocoDecompress: compressedLarge getHandle
		length: compressedLength 
		output: bufLarge getHandle
		bufSize: bufSize.

	"// nrBytesWritten = bufsize + 1, because buffer too small"
	self assert: nBytes equals: 3.

	nBytes := shocoLib 
		shocoDecompress: compressedLarge getHandle
		length: 5 
		output: bufLarge getHandle
		bufSize: bufSize.

	self assert: (nBytes < largeLength or: [ nBytes = 4097 ]).
]

{ #category : #tests }
FFIShocoLibTest >> testShocoDecompressNonAscii [

	| bufSize compressedNonAscii nBytes nonAsciiLength compLen bufLarge |
	
	bufSize := 256.
	compressedNonAscii := (FFIExternalArray externalNewType: #char size: 255) autoRelease.
	nonAsciiLength := nonAsciiString size.
	bufLarge := (FFIExternalArray externalNewType: #char size: 4096) autoRelease.
	
	compLen := shocoLib 
		shocoCompress: nonAsciiString 
		output: compressedNonAscii getHandle
		bufSize: bufSize.

	nBytes := shocoLib 
		shocoDecompress: compressedNonAscii getHandle
		length: compLen 
		output: bufLarge getHandle
		bufSize: 4096.

	self assert: nBytes equals: nonAsciiLength + 4. "strlen(nonAsciiiString) = 20"

]

{ #category : #tests }
FFIShocoLibTest >> testShocoDecompressOutputBufSize [

	| bufSize bufLarge nBytes compressedLarge compressedLength largeLength |
	
	bufSize := 4096.
	bufLarge := (FFIExternalArray externalNewType: 'char' size: bufSize)	 autoRelease.
	largeLength := largeString size.
	compressedLarge := (FFIExternalArray externalNewType: #char size: bufSize)	 autoRelease.
	
	compressedLength := shocoLib 
		shocoCompress: largeString 
		output: compressedLarge getHandle
		bufSize: bufSize.
	nBytes := shocoLib 
		shocoDecompress: compressedLarge getHandle
		length: compressedLength 
		output: bufLarge getHandle
		bufSize: bufSize.

	self assert: nBytes equals: largeLength.

	self assert: bufLarge asNullTerminatedString equals: largeString.
	"no null byte written"
	self deny: bufLarge asNullTerminatedString last equals: Character null.

]

{ #category : #running }
FFIShocoLibTest >> writeLibraryInTempLocation [

	| dest newFile |
	
	newFile := shocoLib ffiLibraryName.
	dest := LibShocoBridge root / newFile basename.
	[ newFile asFileReference copyTo: dest ]
	on: FileExists, FileDoesNotExistException
	do: [ : ex | self handleFileEx: ex ].
	dest exists
		ifFalse: [ self error: 'Library file could not be copied into project directory' ].
	newFile asFileReference ensureDelete.	

]
