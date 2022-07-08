Class {
	#name : #DiAssignDataExtension,
	#superclass : #DiDataRelationBuilderExtension,
	#category : 'GToolkit4Directus-Builder'
}

{ #category : #building }
DiAssignDataExtension >> build [
	self builder data items do: [ :eachCollectionModelItem | 
		eachCollectionModelItem do: [ :eachModelItem | 
			eachModelItem data: self builder data ] ]
]
