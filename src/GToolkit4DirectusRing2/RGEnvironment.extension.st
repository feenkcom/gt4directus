Extension { #name : #RGEnvironment }

{ #category : #'*GToolkit4DirectusRing2' }
RGEnvironment >> gtBehaviorsFor: aView [
	<gtView>
	behaviors ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Behaviors';
		priority: 1;
		items: [ (behaviors asOrderedCollection reject: #isRGUnresolvedValue) 
			sort: [ :a :b | a isRingResolved and: [ a name < b name ] ] ];
		column: 'Name' item: [ :aBehavior | aBehavior name ];
		column: 'Superclass' item: [ :aBehavior | aBehavior superclass name ];
		column: 'Package' item: [ :aBehavior | aBehavior package name ]
]

{ #category : #'*GToolkit4DirectusRing2' }
RGEnvironment >> gtPackagesFor: aView [
	<gtView>
	packages ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Packages';
		priority: 2;
		items: [ (packages asOrderedCollection reject: #isRGUnresolvedValue)
			sort: [ :a :b | a isRingResolved and: [ a name < b name ] ] ];
		column: 'Name' item: [ :aPackage | aPackage name ];
		column: 'Behaviors' item: [ :aPackage | aPackage definedBehaviors size ];
		column: 'Extended Behaviors' item: [ :aPackage | aPackage extendedBehaviors size ]
]
