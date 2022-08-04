[ 
  (IceRepositoryCreator new
	   location: (FileLocator workingDirectory / 'libshoco');
	   createRepository) register 
]
on: IceDuplicatedRepository
do: [ "nothing" ]