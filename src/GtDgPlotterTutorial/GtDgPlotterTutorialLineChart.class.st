Class {
	#name : #GtDgPlotterTutorialLineChart,
	#superclass : #GtPlotterLineChart,
	#category : #'GtDgPlotterTutorial-Builder - Line Chart'
}

{ #category : #accessing }
GtDgPlotterTutorialLineChart >> create [
	<return: #BlElement>
	| aContainer |

	self initializeScales.

	aContainer := BrHorizontalGrid new
		cellSpacing: 0;
		columnCount: 2;
		matchParent;
		padding: (BlInsets all: 20).	

	self data size isZero 
		ifTrue: [ 
			aContainer 
				columnCount: 1;
				addChild: self newNoDataElement ]
		ifFalse: [
			projectionXValues ifNotNil: [ 
				aContainer
					addChildren: { 
						self newCornerElement.
						self newProjectionXLabelsElement.
					 }	
			].
			
			aContainer 
				addChildren: { 
					self newAxisYElement.
					self newContentElement.
					self newCornerElement.
					self newAxisXElement.
				 } ].
	
	self styleChartElement: aContainer.
	
	^ aContainer
]

{ #category : #accessing }
GtDgPlotterTutorialLineChart >> exampleBurndownLineChart [
	<gtExample>
	| aData lineChart rawData |
	rawData := {
	(Date year: 2023 month: 01 day: 01) -> 50.
	(Date year: 2023 month: 01 day: 02) -> 60.
	(Date year: 2023 month: 01 day: 03) -> 40.
	(Date year: 2023 month: 01 day: 04) -> 30.
	(Date year: 2023 month: 01 day: 05) -> 20.
	}.
	aData := GtPlotterDataGroup new values: rawData.
	
	lineChart := GtDgPlotterTutorialLineChart new.
	lineChart with: aData.
	lineChart valueX: #key.
	lineChart scaleX: GtPlotterTimeScale new.

	lineChart valueY: #value.
	lineChart scaleY: GtPlotterLinearScale new.

	^ lineChart
]

{ #category : #accessing }
GtDgPlotterTutorialLineChart >> newContentElement [
	| aContainer |
	aContainer := BrFrame new
			matchParent;
			addChildren: {self newAxisYLineElement.
					self newAxisXLineElement}.

	data
		groupsCollect: [ :aGroup | aContainer addChild: (self newContentLineElementFor: aGroup) ].

	aContainer
		addChild: (self
				newIdealizedContentLineElementFor: (GtPlotterDataGroup new
						values: {(Date
									year: 2023
									month: 01
									day: 01) -> 50.
								(Date
									year: 2023
									month: 01
									day: 02) -> 40.
								(Date
									year: 2023
									month: 01
									day: 03) -> 30.
								(Date
									year: 2023
									month: 01
									day: 04) -> 20.
								(Date
									year: 2023
									month: 01
									day: 05) -> 10})).
	projectionXValues
		ifNotNil: [ aContainer addChild: self newProjectionXLinesElement ].

	^ aContainer
]

{ #category : #accessing }
GtDgPlotterTutorialLineChart >> newIdealizedContentLineElementFor: aGroup [
	| border |
	border := BlBorder builder
			paint: Color orange;
			width: 1;
			dashed;
			build.
	^ BlElement new
		geometry: (BlNormalizedPolyline vertices: (self newContentLineVerticesFor: aGroup));
		border: border;
		outskirts: BlOutskirts centered;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]
