Class {
	#name : #GameOfLifeWorld,
	#superclass : #Object,
	#instVars : [
		'height',
		'width',
		'world',
		'window'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #'instance creation' }
GameOfLifeWorld class >> withHeight: aHeight withWidth: aWidth [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
	| world |
	world := 	self new.	
	world setHeight: aHeight. 
	world setWidth: aWidth.
	world createWorld.
	world createWindow.
	^world
	
]

{ #category : #creation }
GameOfLifeWorld >> addPattern: aPattern [
			
	(aPattern positions) do: [ :position | (world at: position) awake. ].
	^ self.
	


]

{ #category : #creation }
GameOfLifeWorld >> addRandomPatterns [
			
	world valuesDo: [ :cell |
		 ((1 to: 10) atRandom even 
				ifTrue: [ cell kill ] ifFalse: [ cell awake ] ) ].
	^ self.
	


]

{ #category : #private }
GameOfLifeWorld >> createWindow [
			
	window := GameOfLifeWindow withHeight: height  withWidth: width.
	self populateWindow.
]

{ #category : #private }
GameOfLifeWorld >> createWorld [

	| neighbourPositions neighbours |	
		
	world := Dictionary new.
	1 to: width do: [ :w | 1 to: height do: [ :h | world at: w@h put: GameOfLifeCell new. ] ].
	
	world keysAndValuesDo: [ :position :cell | 
		neighbourPositions := self getNeighbourPositions: position.
		neighbours := (neighbourPositions collect: [ :p | world at: p ]).
		cell neighbours: neighbours.
	]	

]

{ #category : #private }
GameOfLifeWorld >> getNeighbourPositions: aPosition [

	| x y points |	
		
	x := aPosition x.
	y := aPosition y.
	
	points := { (x-1)@(y-1).	(x-1)@y.	(x-1)@(y+1).	 x@(y-1).	 x@(y+1). (x+1)@(y-1). (x+1)@y. (x+1)@(y+1). }.
	
	^ points select: [ :p | (p > (0@0)) & (p <= (width@height)). ].
	
]

{ #category : #accessing }
GameOfLifeWorld >> isAliveAt: aPoint [
		
		^ (world at: aPoint ifAbsent: [^ AssertionFailure  new signal: 'Invalid Point'] ) isAlive.
]

{ #category : #execution }
GameOfLifeWorld >> moveToNextGeneration [

	self updateNeighbours.
	world valuesDo: [ :cell | 
		((cell numberOfLiveNeighbours = 0) & (cell isAlive not)) ifFalse: [cell updateStatus] ].
	self showWindow.
]

{ #category : #creation }
GameOfLifeWorld >> play: aNumberOfSteps [

	[ 1 to: aNumberOfSteps 
		do: [ :a |
			self moveToNextGeneration. 
"			(Delay forMilliseconds: 100) wait."
			]
	] fork.

]

{ #category : #private }
GameOfLifeWorld >> populateWindow [ 

	| rowMorph |			
	
	1 to: height do: [ :row | 
		rowMorph := Morph new layoutPolicy: RowLayout new; vResizing: #shrinkWrap; color: Color transparent .
		width to: 1 by: -1 do: [ :col | rowMorph addMorph: (world at: (col@row)) ].
		window addRowMorph: rowMorph.
	].
	
]

{ #category : #private }
GameOfLifeWorld >> setHeight: aHeight [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	height := aHeight 
]

{ #category : #private }
GameOfLifeWorld >> setWidth: aWidth [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	width := aWidth 
]

{ #category : #execution }
GameOfLifeWorld >> showWindow [

	window show
]

{ #category : #private }
GameOfLifeWorld >> updateNeighbours [
	
	world valuesDo: [ :cell | cell updateLiveNeighboursCount ]
]
