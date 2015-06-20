This library implements attributes for locations, just like  the attributes for objects. It also implements several condacts, similar to those for object attributes:

- LCLEAR   -->  like OCLEAR
- LSET     -->  like OSET
- LNEG     -->  like ONEG
- LZERO    -->  like OZERO
- LNOTZERO -->  like oNOTZERO

Finally, as there is no way to define attributes in the game database, there is a condacta named LINIT:

LINIT locno low_attributes high_attributes

You can use it the old way (to activate attributes 0 and 1):

LINIT 10 11000000000000000000000000000000 00000000000000000000000000000000

Or you can use txtpaws ATTR feature:

#define const laLargeRoom 0
#define const laDangerousPlace 1

LINIT 10 ATTR laLargeRoom laDangerousPlace


IMPORTANT NOTE:

Please notice that due to a limitation in ngPAWS compiler, that uses last bit of each parameter to mark if it hgas indirection, location attributes 31 and 63 cannot be used (must allways be set to 0).