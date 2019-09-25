Extension { #name : #RGEnvironment }

{ #category : #'*GToolkit4DirectusRing2' }
RGEnvironment >> gtBehaviorsFor: aView [
	<gtView>
	behaviors ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Behaviors';
		items: [ behaviors asOrderedCollection 
			sort: [ :a :b | a isRingResolved and: [ a name < b name ] ] ];
		column: 'Name' item: [ :aBehavior | aBehavior name ];
		column: 'Superclass' item: [ :aBehavior | aBehavior superclass name ];
		column: 'Package' item: [ :aBehavior | aBehavior package name ]
]
