Extension { #name : #FFIExternalArray }

{ #category : #'*LibShoco' }
FFIExternalArray >> asNullTerminatedString [
	"Answer a <String> copy of the receiver"

	^ (String streamContents: [ :stream | self flattenOn: stream]) 
		copyUpTo: Character null
]
