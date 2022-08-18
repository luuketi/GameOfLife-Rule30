Class {
	#name : #GameOfLifeWorld,
	#superclass : #Object,
	#instVars : [
		'height',
		'width',
		'world',
		'window',
		'neighbours'
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
			
	world keysDo: [ :k |
		 ((1 to: 10) atRandom even 
				ifTrue: [(world at: k ) kill] ifFalse: [(world at: k ) awake] ) ].
	^ self.
	


]

{ #category : #private }
GameOfLifeWorld >> assertValidPoint: aPoint [

	| x y |
	x := aPoint x.
	y := aPoint y.
	
	(y > height) | (x > width) | (y <= 0) | (x <= 0)
		ifTrue: [ ^ AssertionFailure  new signal: 'Invalid Point' ]
]

{ #category : #private }
GameOfLifeWorld >> countLiveNeighbours: aCell [

	| count x y points validPoints |
	
	count := 0.
	x := aCell x.
	y := aCell y.
	
	points := { (x-1)@(y-1).	(x-1)@y.	(x-1)@(y+1).	 x@(y-1).	 x@(y+1). (x+1)@(y-1). (x+1)@y. (x+1)@(y+1). }.
	
	validPoints := points select: [ :p | (p > (0@0)) & (p <= (width@height)). ].
	validPoints do: [ :p | (self isAlive: p) ifTrue: [count := count + 1] ].
	^ count
	
	
	

]

{ #category : #private }
GameOfLifeWorld >> createWindow [
			
	window := GameOfLifeWindow withHeight: height  withWidth: width.
	self populateWindow.
]

{ #category : #private }
GameOfLifeWorld >> createWorld [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
	
	neighbours := Dictionary new.
	world := Dictionary new.
	1 to: width do:
		[ :w | 1 to: height do:
			[ :h | world at: w@h put: GameOfLifeCell new. ] ]
]

{ #category : #accessing }
GameOfLifeWorld >> isAlive: aPoint [
		
		self assertValidPoint: aPoint.
		^ (world at: aPoint) isAlive.
]

{ #category : #execution }
GameOfLifeWorld >> moveToNextGeneration [

	self updateNeighbours.
	world keysDo: [ :k | ((neighbours at: k) = 0 & ((world at: k) isAlive not)) ifFalse: [self updateCell: k] ].
	self showWindow
]

{ #category : #creation }
GameOfLifeWorld >> play: aNumberOfSteps [

	[ 1 to: aNumberOfSteps 
		do: [ :a |
			self moveToNextGeneration. 
			(Delay forMilliseconds: 250) wait.
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
GameOfLifeWorld >> updateCell: aCell [

	(self isAlive: aCell)
		ifTrue: [ self updateLiveCell: aCell ]
		ifFalse: [ self updateDeadCell: aCell ]
]

{ #category : #private }
GameOfLifeWorld >> updateDeadCell: aCell [ 

	| liveNeighbours |
	
	liveNeighbours := neighbours at: aCell.
	(liveNeighbours = 3)
		ifTrue: [ (world at: aCell) awake. ]
]

{ #category : #private }
GameOfLifeWorld >> updateLiveCell: aCell [ 

	| liveNeighbours |
	
	liveNeighbours := neighbours at: aCell.
	(liveNeighbours < 2 | (liveNeighbours > 3))
		ifTrue: [ (world at: aCell) kill. ]
]

{ #category : #private }
GameOfLifeWorld >> updateNeighbours [

	| liveNeighbours |
	
	world keysDo: [ :k | 
		liveNeighbours := self countLiveNeighbours: k.
		neighbours at: k put: liveNeighbours ]
]
