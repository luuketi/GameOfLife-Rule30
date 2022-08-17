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
	^world
	
]

{ #category : #creation }
GameOfLifeWorld >> addPattern: aPattern [
			
	(aPattern positions) do: [ :position | world at: position put: GameOfLifeAliveCell new. ].
	


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
	
	validPoints := points select: [ :p | (p > (0@0)) & (p < (width@height)). ].
	validPoints do: [ :p | (self isAlive: p) ifTrue: [count := count + 1] ].
	^ count
	
	
	

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
			
	| newWorld |
	newWorld := Dictionary new.
	world keysDo: [ :k | self updateCell: k in: newWorld ].
	world := newWorld.
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
