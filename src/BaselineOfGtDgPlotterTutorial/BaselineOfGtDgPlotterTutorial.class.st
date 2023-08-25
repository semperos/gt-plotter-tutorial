Class {
	#name : #BaselineOfGtDgPlotterTutorial,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtDgPlotterTutorial
}

{ #category : #loading }
BaselineOfGtDgPlotterTutorial class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'gt-plotter-tutorial' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfGtDgPlotterTutorial >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GtDgPlotterTutorial'
		]
]
