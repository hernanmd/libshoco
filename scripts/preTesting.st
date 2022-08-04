[ 
  (IceRepositoryCreator new
	   location: (FileLocator workingDirectory / 'libshoco') / 'src';
	   createRepository) register 
]
on: IceDuplicatedRepository
do: [ "nothing" ]