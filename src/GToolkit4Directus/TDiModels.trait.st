Trait {
	#name : 'TDiModels',
	#category : 'GToolkit4Directus-Commands'
}

{ #category : 'gt-extension' }
TDiModels >> gtModelsFor: aView [
	<gtView>
	self models ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Models';
		items: [ self models ]
]

{ #category : 'accessing' }
TDiModels >> models [
	<return: #Collection>
	^ self explicitRequirement
]
