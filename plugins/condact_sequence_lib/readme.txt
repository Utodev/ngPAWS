This library allows you to execute some condact every time a given message is printed vía a new sequence tag. While it is no point in using it within a WRITE or WRITELN message, 
it can be useful when included into:

- System messages
- object names
- location descriptions

For instance you can make a flag being increased by one every time a system message is displayed (i.e. every time the "You take xxx." message is printed).

The sintax for the sequence tag is

{C:<condact>|<parameters>}

i.e.

{C:SET|100}
{C:CREATE|8}
{C:PLACE|40|23}

Take in mind:

- All condacts in a message are run before the message is printed, so their position doesn't matter, except that you add more than one in the same 
  message, in which case they will be run in order of appearance
- Only action condacts can be executed, not condition condacts (it doesn't even make sense).
- There is no syntax control, make sure you add the proper number of parameters for the condact you use
- You cannot use condacts that whose parameter is a string (like WRITE or TITLE)
- If you use condacts whose parameters are words (like SYNONYM) you should specify the words by word number, not by the word itself (i.e. {C:SYNONYM|78|32}
- You cannot use txtpaws identifiers within sequence tags (as usual)


Credits for this library goes to edlobez, whose ideas led me to think this library was a good thing to have.

License: Public Domain 