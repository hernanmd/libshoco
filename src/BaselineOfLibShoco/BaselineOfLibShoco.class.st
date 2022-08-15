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

	Metacello new
		baseline: 'MetacelloFileDownload';
		onWarningLog;
		repository: 'github://hernanmd/MetacelloFileDownload';
		load
]

{ #category : #accessing }
BaselineOfLibShoco >> platformFilesUrl [

	^ Array with: (String streamContents: [ : stream |		
		stream 			
			nextPutAll: 'https://github.com/hernanmd/resources/raw/main/';
			nextPutAll: (
				Smalltalk os isWin32 					
					ifTrue: [ 'libshoco_win.zip' ]
					ifFalse: [ 
						Smalltalk os isMacOS
							ifTrue: [ 'libshoco_macos.zip' ]
							ifFalse: [ 'libshoco_linux.zip' ] ]) ])
]

{ #category : #accessing }
BaselineOfLibShoco >> preLoad [

	self ensureMetacelloFileDownload.
	super preLoad.
	(#('libshoco.dylib' 'libshoco.dll' 'libshoco.so') 
		anySatisfy: [ : fileName | fileName asFileReference exists ])
			ifTrue: [ self traceCr: 'Library downloaded and uncompressed successfully' ]
			ifFalse: [ self traceCr: 'Warning: Library not found' ].

]
