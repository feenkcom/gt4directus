Class {
	#name : #DiMonoliteDirectus,
	#superclass : #DiProtoDirectus,
	#category : 'GToolkit4Directus-Importer'
}

{ #category : #authentication }
DiMonoliteDirectus >> authenticate [
	self authenticateWithEmail: self email password: self password
]

{ #category : #authentication }
DiMonoliteDirectus >> authenticateWithEmail: anEmail password: aPassword [
	| aResponse aJsonObject |
	accessToken ifNil: [ 
		| aContent aJsonContent |
		aContent := Dictionary new
			at: 'email' put: anEmail;
			at: 'password' put: aPassword;
			yourself.
		aJsonContent := STONJSON toString: aContent.
		aResponse := ZnClient new
			url: projectURL;
			addPath: #(auth authenticate);
    		entity: (ZnEntity json: aJsonContent);
			post;
			response.
		aResponse isSuccess
   			ifTrue: [ 
				aJsonObject := STONJSON fromString: aResponse contents.
				accessToken := (aJsonObject at: 'data') at: 'token'.
		].
	].
]

{ #category : #accessing }
DiMonoliteDirectus >> email [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
DiMonoliteDirectus >> password [
	<return: #String>
	^ self subclassResponsibility
]
