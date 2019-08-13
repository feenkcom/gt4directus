Class {
	#name : #BaselineOfDirectus,
	#superclass : #BaselineOf,
	#category : #BaselineOfDirectus
}

{ #category : #baselines }
BaselineOfDirectus >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec 
			baseline: 'Directus' with: [
				spec repository: 'github://feenkcom/gt4directus/src' ];
			package: 'Directus' with: [
				spec requires: #('Directus' ) ]
	]

]
