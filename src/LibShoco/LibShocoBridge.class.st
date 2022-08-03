Class {
	#name : #LibShocoBridge,
	#superclass : #GBBridge,
	#classInstVars : [
		'useGitBridge'
	],
	#category : #LibShoco
}

{ #category : #accessing }
LibShocoBridge class >> assetsPath [
	"Return the assets path"

	^ self useGitBridge
		ifTrue: [ self assetsPathForIceberg ]
		ifFalse: [ self assetsPathForCI ]

]

{ #category : #accessing }
LibShocoBridge class >> assetsPathForIceberg [

	^ [ self root ]
		on: GBError
		do: [ :ex | FileLocator workingDirectory ]
]

{ #category : #'class initialization' }
LibShocoBridge class >> initialize [

	SessionManager default registerSystemClassNamed: self name
]

{ #category : #assessing }
LibShocoBridge class >> root [

	^ super root / 'src'
]

{ #category : #accessing }
LibShocoBridge class >> useGitBridge [
	" Read comment in #root method "

	^ useGitBridge
		ifNil: [ useGitBridge := true ]
]
