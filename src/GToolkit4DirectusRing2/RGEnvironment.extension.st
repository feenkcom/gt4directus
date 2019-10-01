Extension { #name : #RGEnvironment }

{ #category : #'*GToolkit4DirectusRing2' }
RGEnvironment >> gtBehaviorsFor: aView [
	<gtView>
	behaviors ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Behaviors';
		priority: 1;
		items: [ (behaviors asOrderedCollection reject: #isRGUnresolvedValue) 
			sort: [ :a :b | self gtPutBehavior: a before: b ] ];
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

{ #category : #'*GToolkit4DirectusRing2' }
RGEnvironment >> gtPutBehavior: aFirst before: aSecond [
	(aFirst isRingResolved and: [ aSecond isRingResolved not ]) ifTrue: [ ^ true ].
	(aFirst isRingResolved not and: [ aSecond isRingResolved ]) ifTrue: [ ^ false ].
	
	(aFirst superclass isRingResolved and: [ aSecond superclass isRingResolved not ]) ifTrue: [ ^ true ].
	(aFirst superclass isRingResolved not and: [ aSecond superclass isRingResolved ]) ifTrue: [ ^ false ].
	
	(aFirst package isRingResolved and: [ aSecond package isRingResolved not ]) ifTrue: [ ^ true ].
	(aFirst package isRingResolved not and: [ aSecond package isRingResolved ]) ifTrue: [ ^ false ].
	
	^ aFirst name < aSecond name
]
