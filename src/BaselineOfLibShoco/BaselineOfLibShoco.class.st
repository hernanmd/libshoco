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
				package: 'LibShoco';
				package: 'LibShoco-Tests'	with: [ spec requires: #(LibShoco) ].
			spec 
				group: 'Core' 						with: #('LibShoco');
				group: 'Tests' 						with: #('LibShoco' 'LibShoco-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]
