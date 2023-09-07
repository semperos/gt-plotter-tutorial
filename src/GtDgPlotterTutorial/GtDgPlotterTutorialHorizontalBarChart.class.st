"
I am a horizontal bar chart that has been extended to support more than my superclass.
"
Class {
	#name : #GtDgPlotterTutorialHorizontalBarChart,
	#superclass : #GtPlotterHorizontalBarChart,
	#instVars : [
		'titleX',
		'titleY',
		'titleChart'
	],
	#category : #GtDgPlotterTutorial
}

{ #category : #accessing }
GtDgPlotterTutorialHorizontalBarChart >> create [
	<return: #Object>
	| topContainer midContainer theBars chartContainer yTitle |
	topContainer := BlElement new
			layout: BlLinearLayout vertical;
			clipChildren: false;
			padding: (BlInsets right: 20);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].

	topContainer addChild: self newChartTitleElement.

	midContainer := BlElement new
			layout: BlLinearLayout horizontal;
			clipChildren: false;
			padding: (BlInsets right: 20);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].

	chartContainer := BlElement new
			layout: BlLinearLayout vertical;
			clipChildren: false;
			padding: (BlInsets right: 20);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].

	chartContainer addChild: self newAxisXTitleElement.

	chartContainer
		addChild: (GtPlotterHorizontalTickLabelsElement new
				clipChildren: false;
				scale: barWidthScale;
				padding: (BlInsets left: self barLabelWidth + self gridlineOffset);
				constraintsDo: [ :c | c vertical fitContent ];
				labelFormat: self tickLabelFormat;
				labelElement: [ :aGtPlotterScaleContext | 
					BrLabel new
						aptitude: (self tickLabelLook create foreground: self tickLabelColor);
						text: (aGtPlotterScaleContext scale
								formattedTick: aGtPlotterScaleContext originalValue) ];
				labels: self amountOfTicks).

	theBars := GtPlotterSingleScaleScrollElement new.
	theBars
		stencil: [ :eachGroup | self createBarRowFor: eachGroup grouping: data isLogicalGroup ].
	theBars values: data.

	chartContainer addChild: theBars.

	yTitle := self newAxisYTitleElement.
	yTitle transform
		rotateBy: 270;
		apply.
	midContainer addChild: yTitle.
	midContainer addChild: chartContainer.

	topContainer addChild: midContainer.

	^ topContainer
]

{ #category : #accessing }
GtDgPlotterTutorialHorizontalBarChart >> newAxisXTitleElement [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
				glamorousCodeFont;
				foreground: Color darkGray;
				fontSize: 16);
		text: (titleX ifNil: '<No X-axis Title>') asRopedText;
		constraintsDo: [ :c | c linear horizontal alignCenter ]
]

{ #category : #accessing }
GtDgPlotterTutorialHorizontalBarChart >> newAxisYTitleElement [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
				glamorousCodeFont;
				foreground: Color darkGray;
				fontSize: 16);
		text: (titleY ifNil: '<No Y-axis Title>') asRopedText;
		constraintsDo: [ :c | c linear vertical alignCenter ]
]

{ #category : #accessing }
GtDgPlotterTutorialHorizontalBarChart >> newChartTitleElement [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
				glamorousCodeFont;
				foreground: Color darkGray;
				fontSize: 16);
		text: (titleChart ifNil: '<No Title>') asRopedText;
		constraintsDo: [ :c | c linear horizontal alignCenter ];
		margin: (BlInsets bottom: 10)
]

{ #category : #accessing }
GtDgPlotterTutorialHorizontalBarChart >> titleChart: aString [ 
	titleChart := aString
]

{ #category : #accessing }
GtDgPlotterTutorialHorizontalBarChart >> titleX: aString [
	titleX := aString
]

{ #category : #accessing }
GtDgPlotterTutorialHorizontalBarChart >> titleY: aString [ 
	titleY := aString
]
