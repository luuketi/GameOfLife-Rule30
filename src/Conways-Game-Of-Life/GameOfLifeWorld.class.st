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
	world createWindow.
	world createWorld.

	^world
	
]

{ #category : #'instance creation' }
GameOfLifeWorld class >> withHeight: aHeight withWidth: aWidth at: aPoint [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
	| world |
	world := 	self new.	
	world setHeight: aHeight. 
	world setWidth: aWidth.
	world createWindowAt: aPoint.
	world createWorld.

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

{ #category : #creation }
GameOfLifeWorld >> addRandomPatterns2 [
			
	world valuesDo: [ :cell |
		 ((1 to: 10) atRandom > 9 
				ifTrue: [ cell awake ] ifFalse: [ cell kill ] ) ].
	^ self.
	


]

{ #category : #private }
GameOfLifeWorld >> createCells [

	| newPosition newCell |
	world := Dictionary new.
	1 to: width do: [ :w | 
		1 to: height do: [ :h | 
			newPosition := w @ h.
			newCell := GameOfLifeCell at: newPosition window: window.
			world at: newPosition put: newCell ] ]
]

{ #category : #private }
GameOfLifeWorld >> createWindow [
			
	window := GameOfLifeWindow withHeight: height  withWidth: width.
	
]

{ #category : #private }
GameOfLifeWorld >> createWindowAt: aPoint [
			
	window := GameOfLifeWindow withHeight: height  withWidth: width at: aPoint.
	
]

{ #category : #private }
GameOfLifeWorld >> createWorld [

	self createCells.
	self linkNeighboursToCells.

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

{ #category : #private }
GameOfLifeWorld >> linkNeighboursToCells [

	| neighbourPositions neighbours |
	world keysAndValuesDo: [ :position :cell | 
		neighbourPositions := self getNeighbourPositions: position.
		neighbours := neighbourPositions collect: [ :p | world at: p ].
		cell neighbours: neighbours ]
]

{ #category : #execution }
GameOfLifeWorld >> moveToNextGeneration [

	
	self updateNeighbours.
	
	world keysAndValuesDo: [ :position :cell | 
		((cell numberOfLiveNeighbours = 0) & (cell isAlive not)) ifFalse: [cell updateStatus.] ].

	window draw.

]

{ #category : #execution }
GameOfLifeWorld >> play [

	self showWindow .
	self moveToNextGeneration.	
	
]

{ #category : #execution }
GameOfLifeWorld >> play: aNumberOfSteps [

	| time timeSpent timeToWait |
	self showWindow .
	[ 1 to: aNumberOfSteps do: 
		[ :step | 
     		('''' join: {'Running step: '. step} ) record	.
			time := DateAndTime now.
			self moveToNextGeneration.	
			timeSpent := (DateAndTime now - time) asMilliSeconds.
			timeSpent record.
			timeToWait := 100 - timeSpent.
			timeToWait > 0 ifTrue: [ (Delay forMilliseconds: timeToWait) wait. ]
		]
	] fork.
 
]

{ #category : #execution }
GameOfLifeWorld >> play: aNumberOfSteps timeToWait: millisecondsToWait [

	| time timeSpent timeToWait |
	self showWindow .
	[ 1 to: aNumberOfSteps do: 
		[ :step | 
     		('''' join: {'Running step: '. step} ) record	.
			time := DateAndTime now.
			self moveToNextGeneration.	
			timeSpent := (DateAndTime now - time) asMilliSeconds.
			timeSpent record.
			timeToWait := millisecondsToWait - timeSpent.
			timeToWait > 0 ifTrue: [ (Delay forMilliseconds: timeToWait) wait. ]
		]
	] fork.
 
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

{ #category : #private }
GameOfLifeWorld >> showWindow [

	window show
]

{ #category : #private }
GameOfLifeWorld >> updateNeighbours [
	
	world valuesDo: [ :cell | cell updateLiveNeighboursCount ]
]
