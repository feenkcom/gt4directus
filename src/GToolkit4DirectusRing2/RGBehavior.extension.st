Extension { #name : #RGBehavior }

{ #category : #'*GToolkit4DirectusRing2' }
RGBehavior >> gtClassCommentFor: aView [
	<gtView>
	self hasComment ifFalse: [ ^ aView empty ].
	^ (self comment gtContentFor: aView)
		title: 'Comment';
		priority: 3
]

{ #category : #'*GToolkit4DirectusRing2' }
RGBehavior >> gtDefinitionFor: aView [
	<gtView>
	| aLabel | 
	aLabel := self instanceSide == self 
		ifTrue: [ 'Class side' ]
		ifFalse: [ 'Instance side' ].
	^ aView textEditor
			title: 'Definition';
			priority: 1;
			aptitude: BrGlamorousCodeEditorAptitude;
			styler: (BrRBTextStyler new environment: self environment);
			text: [ self definition asRopedText  ];
			actionButtonIcon: BrGlamorousIcons browse action: [ :aBrTab | 
				Smalltalk at: self name asSymbol ifPresent: #browse ];
			actionButtonLabel: aLabel action: [ :aBrTab |
				self instanceSide == self
					ifTrue: [ aBrTab phlow spawnObject: self classSide ]
					ifFalse: [ aBrTab phlow spawnObject: self instanceSide ] ]
]

{ #category : #'*GToolkit4DirectusRing2' }
RGBehavior >> gtLocalMethodFor: aView [
	<gtView>
	localMethods ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Local Methods';
		priority: 2;
		items: [ self localMethods 
			sort: [ :a :b | a isRingResolved and: [ a name < b name ] ] ];
		column: 'Name' item: [ :aMethod | aMethod name ];
		column: 'Protocol' item: [ :aMethod | aMethod protocol ]
]
