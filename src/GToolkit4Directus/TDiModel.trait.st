Trait {
	#name : #TDiModel,
	#category : 'GToolkit4Directus-Commands'
}

{ #category : #'gt-extension' }
TDiModel >> gtModelFor: anAction [
	<gtAction>
	self model ifNil: [ ^ anAction noAction ].
	^ anAction button
		icon: BrGlamorousIcons inspect;
		label: 'Model';
		action: [ :aBrTab | aBrTab phlow spawnObject: self model ]
]

{ #category : #accessing }
TDiModel >> model [
	^ self explicitRequirement
]
