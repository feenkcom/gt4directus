Extension { #name : #RGMethod }

{ #category : #'*GToolkit4DirectusRing2' }
RGMethod >> gtSourceFor: aView [
	<gtView>
	self hasSourceCode ifFalse: [ ^ aView empty ].
	^ aView textEditor
		title: 'SourceCode';
		look: BrGlamorousCodeEditorLook new;
		styler: (BrRBTextStyler new
			classOrMetaClass: self parent);
		text: [ self sourceCode asRopedText ]
]
