This extension allows author to use extra numeric attributes for objects in the game, for instance a "hit points" attribute can be assigned, or a density one.

New condacts:

ATTRLET "string" objno value --> sets value for attribute "string" for object objno to value
ATTRGET "string" objno flagno --> copies value of attribute "string" for object objno into flag flagno

Example:

ATTRLET "hitpoints" 10 100
ATTRGET "hitpoints" 10 fAux

NOTE: attribute names should be valid at javascript level, so basically they should contain only characters from a-z, A-Z, 0-9 and underscore, never starting with a number.

License: Public Domain 