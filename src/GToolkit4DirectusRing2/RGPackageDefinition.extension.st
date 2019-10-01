Extension { #name : #RGPackageDefinition }

{ #category : #'*GToolkit4DirectusRing2' }
RGPackageDefinition >> gtDefinedBehaviorsFor: aView [
	<gtView>
	definedBehaviors ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Behaviors';
		priority: 1;
		items: [ self definedBehaviors 
			sort: [ :a :b | a isRingResolved and: [ a name < b name ] ] ];
		column: 'Name' item: [ :aBehavior | aBehavior name ];
		column: 'Superclass' item: [ :aBehavior | aBehavior superclass name ];
		actionButtonLabel: 'Browse' action: [ :aBrTab | 
			self isRingResolved ifTrue: [ 
				(self name asPackageIfAbsent: [ nil ]) ifNotNil: [ :aPackage | aPackage browse ] ] ];
		actionButtonLabel: 'Install' action: [ :aBrTab | 
			self isRingResolved ifTrue: [ self asMCSnapshot install ] ]
]

{ #category : #'*GToolkit4DirectusRing2' }
RGPackageDefinition >> gtExtensionMethodsFor: aView [
	<gtView>
	extensionMethods ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Extension Methods';
		priority: 2;
		items: [ self extensionMethods ];
		column: 'Class' item: [ :aBehavior | aBehavior parent name ];
		column: 'Name' item: [ :aBehavior | aBehavior name ]
]

{ #category : #'*GToolkit4DirectusRing2' }
RGPackageDefinition >> gtTagsFor: aView [
	<gtView>
	tagsForClasses ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Tags';
		priority: 3;
		items: [ self tagsForClasses ];
		column: 'Name' item: [ :aBehavior | aBehavior ]
]
