// This file is (C) Carlos Sanchez 2014, released under the MIT license


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////// GLOBAL VARIABLES AND CONSTANTS ///////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



// CONSTANTS 
VOCABULARY_ID = 0;
VOCABULARY_WORD = 1;
VOCABULARY_TYPE = 2;

WORDTYPE_VERB = 0;
WORDTYPE_NOUN = 1
WORDTYPE_ADJECT = 2;
WORDTYPE_ADVERB = 3;
WORDTYPE_PRONOUN = 4;
WORDTYPE_CONJUNCTION = 5;
WORDTYPE_PREPOSITION = 6;

TIMER_MILLISECONDS  = 40;

RESOURCE_TYPE_IMG = 1;
RESOURCE_TYPE_SND = 2;

PROCESS_RESPONSE = 0;
PROCESS_DESCRIPTION = 1;
PROCESS_TURN = 2;


// Aux
SET_VALUE = 255; // Value assigned by SET condact
EMPTY_WORD = 255; // Value for word types when no match is found (as for  sentences without adjective or name)
MAX_WORD_LENGHT = 10;  // Number of characters considered per word
FLAG_COUNT = 256;  // Number of flags
NUM_CONNECTION_VERBS = 14; // Number of verbs used as connection, from 0 to N - 1
NUM_CONVERTIBLE_NOUNS = 20;
NUM_PROPER_NOUNS = 50; // Number of proper nouns, can't be used as pronoun reference
EMPTY_OBJECT = 255; // To remark there is no object when the action requires a objno parameter
NO_EXIT = 0;  // If an exit does not exist, its value is this value
MAX_CHANNELS = 17; // Number of SFX channels
RESOURCES_DIR='dat/';


//Attributes
ATTR_LIGHT=0;			// Object produces light
ATTR_WEARABLE=1;		// Object is wearable
ATTR_CONTAINER=2;       // Object is a container
ATTR_NPC=3;             // Object is actually an NPC
ATTR_CONCEALED = 4; /// Present but not visible
ATTR_EDIBLE = 5;   /// Can be eaten
ATTR_DRINKABLE=6;
ATTR_ENTERABLE = 7;
ATTR_FEMALE = 8;
ATTR_LOCKABLE = 9;
ATTR_LOCKED = 10;
ATTR_MALE = 11;
ATTR_NEUTER=12;
ATTR_OPENABLE =13;
ATTR_OPEN=14;
ATTR_PLURALNAME = 15;
ATTR_TRANSPARENT=16;
ATTR_SCENERY=17;
ATTR_SUPPORTER = 18;
ATTR_SWITCHABLE=19;
ATTR_ON  =20;
ATTR_STATIC  =21;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////// INTERNAL STRINGS ///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// General messages & strings
STR_NEWLINE = '<br />';
STR_PROMPT = '> ';



// Runtime error messages
STR_WRONG_SYSMESS = 'WARNING: System message requested does not exist.'; 
STR_WRONG_LOCATION = 'WARNING: Location requested does not exist.'; 
STR_WRONG_MESSAGE = 'WARNING: Message requested does not exist.'; 
STR_WRONG_PROCESS = 'WARNING: Process requested does not exist.' 
STR_RAMLOAD_ERROR= 'WARNING: Can\'t do RAMLOAD without RAMSAVE'; 
STR_RUNTIME_VERSION  = 'ngPAWS runtime (C) 2014 Carlos Sanchez.  Released under {URL|http://www.opensource.org/licenses/MIT| MIT license}.\nBuzz sound libray (C) Jay Salvat. Released under the {URL|http://www.opensource.org/licenses/MIT| MIT license} \n jQuery (C) jQuery Foundation. Released under the {URL|https://jquery.org/license/| MIT license}.';
STR_TRANSCRIPT = 'To copy the transcript to your clipboard, press Ctrl+C, then press Enter';

STR_SAVE_LOCAL = 'Due to browser security restrictions, the game status can\'t be saved to your hard disk. Please copy the following long string as a code that will allow you to restore the game status.\n\nTo copy the string to your clipboard, press Ctrl+C, then press Enter:\n';
STR_SAVE_STORAGE = 'Please enter savegame name. The name you choose will be requested to you in order to restore the game status.'
STR_LOAD_STORAGE = 'Please enter savegame name you used when saving the game status.'
STR_LOAD_LOCAL = 'Please enter the code you received for loading the game.'

STR_INVALID_TAG_SEQUENCE = 'Invalid tag sequence: ';
STR_INVALID_TAG_SEQUENCE_EMPTY = 'Invalid tag sequence.';
STR_INVALID_TAG_SEQUENCE_BADPARAMS = 'Invalid tag sequence: bad parameters.';
STR_INVALID_TAG_SEQUENCE_BADTAG = 'Invalid tag sequence: unknown tag.';
STR_BADIE = 'You are using a very old version of Internet Explorer. Some features of this product won\'t be avaliable, and other may not work properly. For a better experience please upgrade your browser or install some other one like Firefox, Chrome or Opera.\n\nIt\'s up to you to continue but be warned your experience may be affected.';
STR_INVALID_OBJECT = 'WARNING: Trying to access object that does not exist'


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////     FLAGS     ///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


FLAG_LIGHT = 0;
FLAG_OBJECTS_CARRIED_COUNT = 1;
FLAG_AUTODEC2 = 2; 
FLAG_AUTODEC3 = 3;
FLAG_AUTODEC4 = 4;
FLAG_AUTODEC5 = 5;
FLAG_AUTODEC6 = 6;
FLAG_AUTODEC7 = 7;
FLAG_AUTODEC8 = 8;
FLAG_AUTODEC9 = 9;
FLAG_AUTODEC10 = 10;
FLAG_ESCAPE = 11;
FLAG_PARSER_SETTINGS = 12;
FLAG_PICTURE_SETTINGS = 29
FLAG_SCORE = 30;
FLAG_TURNS_LOW = 31;
FLAG_TURNS_HIGH = 32;
FLAG_VERB = 33;
FLAG_NOUN1 =34;
FLAG_ADJECT1 = 35;
FLAG_ADVERB = 36;
FLAG_MAXOBJECTS_CARRIED = 37;
FLAG_LOCATION = 38;
FLAG_TOPLINE = 39;   // deprecated
FLAG_MODE = 40;  // deprecated
FLAG_PROTECT = 41;   // deprecated
FLAG_PROMPT = 42;  // deprecated
FLAG_PREP = 43;
FLAG_NOUN2 = 44;
FLAG_ADJECT2 = 45;
FLAG_PRONOUN = 46;
FLAG_PRONOUN_ADJECT = 47;
FLAG_TIMEOUT_LENGTH = 48;
FLAG_TIMEOUT_SETTINGS = 49; 
FLAG_DOALL_LOC = 50;
FLAG_REFERRED_OBJECT = 51;
FLAG_MAXWEIGHT_CARRIED = 52;
FLAG_OBJECT_LIST_FORMAT = 53;
FLAG_REFERRED_OBJECT_LOCATION = 54;
FLAG_REFERRED_OBJECT_WEIGHT = 55;
FLAG_REFERRED_OBJECT_LOW_ATTRIBUTES = 56;
FLAG_REFERRED_OBJECT_HIGH_ATTRIBUTES = 57;
FLAG_EXPANSION1 = 58;
FLAG_EXPANSION2 = 59;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////// SPECIAL LOCATIONS ///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LOCATION_WORN = 253;
LOCATION_CARRIED = 254;
LOCATION_NONCREATED = 252;
LOCATION_HERE = 255;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////  SYSTEM MESSAGES  ///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



SYSMESS_ISDARK = 0;
SYSMESS_YOUCANSEE = 1;
SYSMESS_PROMPT0 = 2;
SYSMESS_PROMPT1 = 3;
SYSMESS_PROMPT2 = 4
SYSMESS_PROMPT3= 5;
SYSMESS_IDONTUNDERSTAND = 6;
SYSMESS_WRONGDIRECTION = 7
SYSMESS_CANTDOTHAT = 8;
SYSMESS_YOUARECARRYING = 9;
SYSMESS_WORN = 10;
SYSMESS_CARRYING_NOTHING = 11;
SYSMESS_AREYOUSURE = 12;
SYSMESS_PLAYAGAIN = 13;
SYSMESS_FAREWELL = 14;
SYSMESS_OK = 15;
SYSMESS_PRESSANYKEY = 16;
SYSMESS_TURNS_START = 17;
SYSMESS_TURNS_CONTINUE = 18;
SYSMESS_TURNS_PLURAL = 19;
SYSMESS_TURNS_END = 20;
SYSMESS_SCORE_START= 21;
SYSMESS_SCORE_END =22;
SYSMESS_YOURENOTWEARINGTHAT = 23;
SYSMESS_YOUAREALREADYWEARINGTHAT = 24;
SYSMESS_YOUALREADYHAVEOBJECT = 25;
SYSMESS_CANTSEETHAT = 26;
SYSMESS_CANTCARRYANYMORE = 27;
SYSMESS_YOUDONTHAVETHAT = 28;
SYSMESS_YOUAREALREADYWAERINGOBJECT = 29;
SYSMESS_YES = 30;
SYSMESS_NO = 31;
SYSMESS_MORE = 32;
SYSMESS_CARET = 33;
SYSMESS_TIMEOUT=35;
SYSMESS_YOUTAKEOBJECT = 36;
SYSMESS_YOUWEAROBJECT = 37;
SYSMESS_YOUREMOVEOBJECT = 38;
SYSMESS_YOUDROPOBJECT = 39;
SYSMESS_YOUCANTWEAROBJECT = 40;
SYSMESS_YOUCANTREMOVEOBJECT = 41;
SYSMESS_CANTREMOVE_TOOMANYOBJECTS = 42;
SYSMESS_WEIGHSTOOMUCH = 43;
SYSMESS_YOUPUTOBJECTIN = 44;
SYSMESS_YOUCANTTAKEOBJECTOUTOF = 45;
SYSMESS_LISTSEPARATOR = 46;
SYSMESS_LISTLASTSEPARATOR = 47;
SYSMESS_LISTEND = 48;
SYSMESS_YOUDONTHAVEOBJECT = 49;
SYSMESS_YOUARENOTWEARINGOBJECT = 50;
SYSMESS_PUTINTAKEOUTTERMINATION = 51;
SYSMESS_THATISNOTIN = 52;
SYSMESS_EMPTYOBJECTLIST = 53;
SYSMESS_FILENOTFOUND = 54;
SYSMESS_CORRUPTFILE = 55;
SYSMESS_IOFAILURE = 56;
SYSMESS_DIRECTORYFULL = 57;
SYSMESS_DISKFULL = 58;
SYSMESS_INVALIDFILENAME = 59;
SYSMESS_FILENAME = 60;
SYSMESS_SORRY = 61;
SYSMESS_NONSENSE_SENTENCE = 62;
SYSMESS_NPCLISTSTART = 63;
SYSMESS_NPCLISTCONTINUE = 64;
SYSMESS_NPCLISTCONTINUE_PLURAL = 65;
SYSMESS_INSIDE_YOUCANSEE = 66;
SYSMESS_OVER_YOUCANSEE = 67;
SYSMESS_YOUPUTOBJECTON = 68;
SYSMESS_YOUCANTTAKEOBJECTFROM = 69;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////// GLOBAL VARS //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Parser vars
var last_player_order = '';   // Store last player order, to be able to restore it when pressing arrow up
var parser_word_found;
var player_order_buffer = '';
var previous_verb = EMPTY_WORD;
var previous_noun = EMPTY_WORD;
var previous_adject = EMPTY_WORD;
var pronoun_suffixes = [];
var transcript = '';

//Settings
var graphicsON = true; 
var soundsON = true; 
var interruptDisabled = false;


// Block and anykey
var unblock_process = null;
var anykey_return_function = null;
var getkey_return_flag = null;

// Status flags
var done_flag;
var describe_location_flag;
var in_response;
var success;

// doall control
var doall_flag;
var process_in_doall;
var entry_for_doall	= '';


var timeout_progress = 0;
var ramsave_value = null;
var num_objects;


// The flags
var flags = new Array();


// The sound channels
var soundChannels = [];
var soundLoopCount = [];

//The last free object attribute
var nextFreeAttr = 22;

