This library implements attributes for locations, just like  the attributes for objects. It also implements several condacts, similar to those for object attributes:

- LCLEAR   -->  like OCLEAR
- LSET     -->  like OSET
- LNEG     -->  like ONEG
- LZERO    -->  like OZERO
- LNOTZERO -->  like oNOTZERO

Finally, as there is no way to define attributes in the game database, there is a condacta named LINIT:

LINIT locno low_attributes high_attributes

You can use it the old way (i.e. if locatyion has attributes 0 and 1 active):

LINIT 10 11000000000000000000000000000000 00000000000000000000000000000000

Or you can use txtpaws ATTR feature:

#define const laLargeRoom 0
#define const laDangerousPlace 1

LINIT 10 ATTR laLargeRoom laDangerousPlace

Also, you can use it "the hard way" using decimal numbers:

LINIT 10 3 0

Please notice that despite the condact being named LINIT (location initialize), it can be used as many times as you want in the same location, if that ever makes sense.


IMPORTANT NOTE:

Please notice that due to a limitation in ngPAWS compiler, that uses last bit of each parameter to mark if it has indirection, LINIT cannot use location attributes 31 and 63 cannot be used (must allways be set to 0).
Once initialized, they can be used normally (and can be set with LSET), but using them is not recommended unless all the other 62 attributes have been used.

