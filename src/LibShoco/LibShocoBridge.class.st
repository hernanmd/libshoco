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

	^ [ super root / 'src' ]
		on: GBError
		do: [ :ex | (FileLocator imageDirectory parentUpTo: 'libshoco') / 'src' ]
]
