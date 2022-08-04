[ (IceRepositoryCreator new
	location: (FileLocator imageDirectory parentUpTo: 'libshoco');
	createRepository) register ]
on: IceDuplicatedRepository
do: [ "nothing" ]
