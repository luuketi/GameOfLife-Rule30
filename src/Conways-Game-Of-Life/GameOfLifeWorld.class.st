Class {
	#name : #GameOfLifeWorld,
	#superclass : #Object,
	#instVars : [
		'height',
		'width',
		'world'
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

{ #category : #private }
GameOfLifeWorld >> assertValidPoint: aPoint [

	| x y |
	x := aPoint x.
	y := aPoint y.
	
	(y > height) | (x > width) | (y <= 0) | (x <= 0)
		ifTrue: [ ^ AssertionFailure  new signal: 'Invalid Point' ]
]

{ #category : #private }
GameOfLifeWorld >> createWorld [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	world := Dictionary new.
]

{ #category : #accessing }
GameOfLifeWorld >> isAlive: aPoint [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
		
		self assertValidPoint: aPoint.
		^ world at: aPoint ifAbsent: [ false ].
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
