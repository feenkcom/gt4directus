Trait {
	#name : 'TDiJsonContent',
	#category : 'GToolkit4Directus-Commands'
}

{ #category : 'gt-extension' }
TDiJsonContent >> gtJsonContentFor: aView [
	<gtView>
	self jsonContent ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'JSON Request';
		priority: 40;
		styler: JSONParser gtStyler;
		text: [ STONJSON toStringPretty: (STONJSON fromString: self jsonContent) ];
		actionButtonIcon: BrGlamorousIcons tree asElement 
			action: [ :aButton | aButton phlow 
				spawnObject: (STONJSON fromString: self jsonContent) ]
]

{ #category : 'accessing' }
TDiJsonContent >> jsonContent [
	<return: #String>
	^ self explicitRequirement
]
