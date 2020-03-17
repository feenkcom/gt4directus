Class {
	#name : #GtDirectusClientSnippet,
	#superclass : #GtSnippet,
	#instVars : [
		'url',
		'user',
		'token'
	],
	#category : #GToolkit4Directus
}

{ #category : #accessing }
GtDirectusClientSnippet class >> typeName [
	<return: #String>

	^ 'directus'
]

{ #category : #converting }
GtDirectusClientSnippet >> asElement [
	| snippetContainer formElement urlInputElement passwordInputElement toolbar playInspectButton userInputElement anExpanderElement |
	formElement := BlElement new.
	formElement constraintsDo: [ :c |  
		c vertical fitContent.
		c horizontal matchParent ].
	formElement layout: (BlGridLayout horizontal columnCount: 2; cellSpacing: 10).

	urlInputElement := self inputElementNamed: 'Project url' in: formElement.
	userInputElement := self inputElementNamed: 'User' in: formElement.
	passwordInputElement := self inputElementNamed: 'Password' in: formElement.
	
	toolbar := BrToolbar new
		look: BrToolbarLook new;
		layout: (BlGridLayout horizontal rowCount: 1; cellSpacing: 10);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	playInspectButton := BrButton new.
	playInspectButton 
		beSmall;
		look: BrGlamorousButtonWithIconLook;
		label: 'Inspect connection';
		icon: BrGlamorousIcons playinspect asElement;
		action: [ 
			"| directusClient metaModel |
			directusClient := SoEditorialServicesCollectionImporter new.
			directusClient projectURL: urlInputElement editor text asString asZnUrl.
			directusClient 
				authenticateWithEmail: (userInputElement editor text asString)
				password: passwordInputElement editor text asString. 
			directusClient authenticate.
			
			metaModel := directusClient getCollectionsWithRelations.
			metaModel collectionsDo: [ :aCollection |
				aCollection modelBuilder: directusClient ].
			metaModel collections modelBuilder: directusClient.
			playInspectButton phlow spawnObject: metaModel collections." ].
	toolbar addItem: playInspectButton.
	
	snippetContainer := BrVerticalPane new
		vFitContent;
		hMatchParent;
		addChildren: { formElement. toolbar }.
	
	anExpanderElement := BrExpander new
		vFitContent;
		hMatchParent;
		expand;
		look: GtCoderExpanderLook new recreateHeader;
		header: [ BrLabel new
			look: (BrGlamorousLabelLook new foreground: BrGlamorousColors disabledButtonTextColor);
			text: ('Directus: ', userInputElement editor text asString, '@',urlInputElement editor text asString) ];
		content: [ snippetContainer ].
	
	^ BrFrame new
		vFitContent;
		hMatchParent;
		look: (GtSnippetContainerLook new snippet: self);
		addChild: anExpanderElement
]

{ #category : #converting }
GtDirectusClientSnippet >> asStencilBuilder [
	^ self
]

{ #category : #'api - instantiation' }
GtDirectusClientSnippet >> bind: aSnippet to: aSnippetElement [
]

{ #category : #converting }
GtDirectusClientSnippet >> inputElementNamed: aString in: formElement [
	| labelElement inputElement text |
	labelElement := BrLabel new text: aString, ':'; look: BrGlamorousLabelLook.
	labelElement constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal fitContent.
		c grid vertical alignCenter ].
	inputElement := BrEditorElement new.
	inputElement look: BrGlamorousInputFieldSpacingLook.
	inputElement constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal matchParent.
		c grid vertical alignCenter ].
	text := '' asRopedText 
		weight: 400;
		fontName: 'Source Sans Pro';
		fontSize: 14.
	inputElement editor: (BrTextEditor new text: text).
	formElement addChild: labelElement.
	formElement addChild: inputElement.
	^ inputElement
]

{ #category : #accessing }
GtDirectusClientSnippet >> string [
	<return: #String>
	^ String streamContents: [ :aStream | 
		aStream nextPutAll: 'Directus:'.
		self url ifNotNil: [ aStream space; print: self url ].
		self user ifNotNil: [ aStream space; print: self user ]. ]
]

{ #category : #accessing }
GtDirectusClientSnippet >> text [
	<return: #BlRope>
	^ self string asRopedText
]

{ #category : #accessing }
GtDirectusClientSnippet >> token [
	^ token
]

{ #category : #accessing }
GtDirectusClientSnippet >> token: anObject [
	token := anObject
]

{ #category : #accessing }
GtDirectusClientSnippet >> url [
	^ url
]

{ #category : #accessing }
GtDirectusClientSnippet >> url: anObject [
	url := anObject
]

{ #category : #accessing }
GtDirectusClientSnippet >> user [
	^ user
]

{ #category : #accessing }
GtDirectusClientSnippet >> user: anObject [
	user := anObject
]
