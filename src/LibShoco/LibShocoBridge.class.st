Class {
	#name : #LibShocoBridge,
	#superclass : #GBBridge,
	#classInstVars : [
		'useGitBridge'
	],
	#category : #LibShoco
}

{ #category : #'class initialization' }
LibShocoBridge class >> initialize [

	SessionManager default registerSystemClassNamed: self name
]

{ #category : #assessing }
LibShocoBridge class >> root [

	^ self useGitBridge
		ifTrue: [ 
			([ super root ]
			on: GBError
			do: [ :ex | FileLocator workingDirectory ]) / 'src' ]
		ifFalse: [ 
			FileSystem memory root ]

]

{ #category : #accessing }
LibShocoBridge class >> useGitBridge [
	" Read comment in #root method "

	^ useGitBridge
		ifNil: [ useGitBridge := true ]
]

{ #category : #accessing }
LibShocoBridge class >> useGitBridge: anObject [

	useGitBridge := anObject
]
