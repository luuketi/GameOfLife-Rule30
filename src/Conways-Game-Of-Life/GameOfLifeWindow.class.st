Class {
	#name : #GameOfLifeWindow,
	#superclass : #Object,
	#instVars : [
		'container',
		'height',
		'width'
	],
	#classInstVars : [
		'container'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #'instance creation' }
GameOfLifeWindow class >> withHeight: aHeight withWidth: aWidth [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
	| world |
	world := 	self new.	
	world setHeight: aHeight. 
	world setWidth: aWidth.
	world initializes.
	^world
]

{ #category : #public }
GameOfLifeWindow >> addRowMorph: aRowMorph [


	container addMorph: aRowMorph

]

{ #category : #private }
GameOfLifeWindow >> initializes [

	container := Morph new layoutPolicy: TableLayout new; color: Color transparent.
]

{ #category : #private }
GameOfLifeWindow >> setHeight: aHeight [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	height := aHeight 
]

{ #category : #private }
GameOfLifeWindow >> setWidth: aWidth [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	width := aWidth 
]

{ #category : #public }
GameOfLifeWindow >> show [

	container position: (-550@30).
	container openInWorld.
	
]
