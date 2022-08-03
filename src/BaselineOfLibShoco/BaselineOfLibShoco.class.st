Class {
	#name : #BaselineOfLibShoco,
	#superclass : #BaselineOf,
	#category : #BaselineOfLibShoco
}

{ #category : #baselines }
BaselineOfLibShoco >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			spec
				baseline: 'GitBridge'
				with: [ spec repository: 'github://jecisc/GitBridge/src' ].
			spec 
				package: 'LibShoco'			with: [ spec requires: #(GitBridge) ];
				package: 'LibShoco-Tests'	with: [ spec requires: #(LibShoco) ].
			spec 
				group: 'Core' 						with: #('LibShoco');
				group: 'Tests' 						with: #('LibShoco' 'LibShoco-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]
