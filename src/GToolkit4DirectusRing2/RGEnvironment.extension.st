Extension { #name : #RGEnvironment }

{ #category : #'*GToolkit4DirectusRing2' }
RGEnvironment >> gtBehaviorNamed: aString ifAbsent: aBlockClosure [ 
	<return: #RGBehaviorFactory>
	^ self ask behaviorNamed: aString ifAbsent: aBlockClosure
]

{ #category : #'*GToolkit4DirectusRing2' }
RGEnvironment >> gtBehaviorsFor: aView [
	<gtView>
	behaviors ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Behaviors';
		priority: 1;
		items: [ (behaviors asOrderedCollection 
			reject: [ :aBehavior | 
				aBehavior isRGUnresolvedValue or: [ 
					aBehavior isRingResolved not ]]) 
			sort: [ :a :b | self gtPutBehavior: a before: b ] ];
		column: 'Name' item: [ :aBehavior | aBehavior ];
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
		items: [ (packages asOrderedCollection 
			reject: [ :aBehavior |  
				aBehavior isRGUnresolvedValue or: [ 
					aBehavior isRingResolved not ] ] )
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

{ #category : #'*GToolkit4DirectusRing2' }
RGEnvironment >> gtTreeBehaviorsFor: aView [
	<gtView>
	behaviors ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Tree Behaviors';
		priority: 3;
		items: [ (behaviors asOrderedCollection 
			select: [ :aBehavior | 
				aBehavior isRGUnresolvedValue not and: [ 
					aBehavior isRingResolved and: [
						aBehavior superclass isRingResolved not ]]]) 
			sort: [ :a :b | self gtPutBehavior: a before: b ] ];
		children: [ :aBehavior | aBehavior subclasses ];
		column: 'Name' item: [ :aBehavior | aBehavior ];
		column: 'Package' item: [ :aBehavior | aBehavior package name ]
]
