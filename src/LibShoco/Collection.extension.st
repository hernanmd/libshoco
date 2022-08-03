Extension { #name : #Collection }

{ #category : #'*LibShoco' }
Collection >> asFFIExternalArrayOfType: aType [
	"Converts collection to FFIExternalArray using the receiver's size
	Example:
	#(1 2 3) asFFIExternalArrayOfType: 'int'"
	
	| array |
	array := FFIExternalArray newType: aType size: self size.
	self withIndexDo: [ :each :index | array at: index put: each ].
	^ array
]

{ #category : #'*LibShoco' }
Collection >> asShocoFFIExternalArrayOfType: aType [
	"Converts collection to FFIExternalArray using the receiver's size
	Example: #(1 2 3) asFFIExternalArrayOfType: 'int'
	
	This is originally provided in Lapack borrowed here with different selector to avoid dependency and overriding method"
	
	| array |
	array := FFIExternalArray newType: aType size: self size.
	self withIndexDo: [ :each :index | array at: index put: each ].
	^ array
]
