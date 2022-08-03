Extension { #name : #FFIExternalArray }

{ #category : #'*LibShoco' }
FFIExternalArray >> asNullTerminatedString [
	"Answer a <String> copy of the receiver up to the first null character, without including it"

	^ (String streamContents: [ :stream | self flattenOn: stream]) 
		copyUpTo: Character null
]

{ #category : #'*LibShoco' }
FFIExternalArray >> copyFirst: n [ 
	"Answer a <String> copy of the receiver"

	^ (String streamContents: [ :stream | self flattenOn: stream]) first: n
]
