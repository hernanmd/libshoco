Class {
	#name : #LibShocoBridge,
	#superclass : #GBBridge,
	#category : #LibShoco
}

{ #category : #'class initialization' }
LibShocoBridge class >> initialize [

	SessionManager default registerSystemClassNamed: self name
]

{ #category : #assessing }
LibShocoBridge class >> root [
	"Answer a <FileReference> which contains the library file"

	^ ([ super root ]
		on: GBError
		do: [ :ex | (FileLocator workingDirectory / 'libshoco') ]) / 'src'

]
