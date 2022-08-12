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
			spec preLoadDoIt: #preLoad.
			spec 
				package: 'LibShoco';
				package: 'LibShoco-Tests'	with: [ spec requires: #(LibShoco) ].
			spec 
				group: 'Core' 						with: #('LibShoco');
				group: 'Tests' 						with: #('LibShoco' 'LibShoco-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]

{ #category : #accessing }
BaselineOfLibShoco >> ensureMetacelloFileDownload [

	EpMonitor disableDuring: [
		Metacello new
			baseline: 'MetacelloFileDownload';
			onWarningLog;
			repository: 'github://hernanmd/MetacelloFileDownload';
			load ]
]

{ #category : #accessing }
BaselineOfLibShoco >> platformFilesUrl [

	^ Array with: (String streamContents: [ : stream |		
		stream 			
			nextPutAll: 'https://github.com/hernanmd/libshoco/raw/master/src/';
			nextPutAll: (
				Smalltalk os isWin32 					
					ifTrue: [ 'libshoco.dll' ]
					ifFalse: [ 
						Smalltalk os isMacOS
							ifTrue: [ 'libshoco.dylib' ]
							ifFalse: [ 'libshoco.so' ] ]) ])
]

{ #category : #accessing }
BaselineOfLibShoco >> preLoad [
    self ensureMetacelloFileDownload.
    super preLoad.
]
