// This file is (C) Carlos Sanchez 2014, released under the MIT license


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////// GLOBAL VARIABLES AND CONSTANTS ///////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



// CONSTANTS 
var VOCABULARY_ID = 0;
var VOCABULARY_WORD = 1;
var VOCABULARY_TYPE = 2;

var WORDTYPE_VERB = 0;
var WORDTYPE_NOUN = 1
var WORDTYPE_ADJECT = 2;
var WORDTYPE_ADVERB = 3;
var WORDTYPE_PRONOUN = 4;
var WORDTYPE_CONJUNCTION = 5;
var WORDTYPE_PREPOSITION = 6;

var TIMER_MILLISECONDS  = 40;

var RESOURCE_TYPE_IMG = 1;
var RESOURCE_TYPE_SND = 2;

var PROCESS_RESPONSE = 0;
var PROCESS_DESCRIPTION = 1;
var PROCESS_TURN = 2;

var DIV_TEXT_SCROLL_STEP = 40;


// Aux
var SET_VALUE = 255; // Value assigned by SET condact
var EMPTY_WORD = 255; // Value for word types when no match is found (as for  sentences without adjective or name)
var MAX_WORD_LENGHT = 10;  // Number of characters considered per word
var FLAG_COUNT = 256;  // Number of flags
var NUM_CONNECTION_VERBS = 14; // Number of verbs used as connection, from 0 to N - 1
var NUM_CONVERTIBLE_NOUNS = 20;
var NUM_PROPER_NOUNS = 50; // Number of proper nouns, can't be used as pronoun reference
var EMPTY_OBJECT = 255; // To remark there is no object when the action requires a objno parameter
var NO_EXIT = 255;  // If an exit does not exist, its value is this value
var MAX_CHANNELS = 17; // Number of SFX channels
var RESOURCES_DIR='dat/';


//Attributes
var ATTR_LIGHT=0;			// Object produces light
var ATTR_WEARABLE=1;		// Object is wearable
var ATTR_CONTAINER=2;       // Object is a container
var ATTR_NPC=3;             // Object is actually an NPC
var ATTR_CONCEALED = 4; /// Present but not visible
var ATTR_EDIBLE = 5;   /// Can be eaten
var ATTR_DRINKABLE=6;
var ATTR_ENTERABLE = 7;
var ATTR_FEMALE = 8;
var ATTR_LOCKABLE = 9;
var ATTR_LOCKED = 10;
var ATTR_MALE = 11;
var ATTR_NEUTER=12;
var ATTR_OPENABLE =13;
var ATTR_OPEN=14;
var ATTR_PLURALNAME = 15;
var ATTR_TRANSPARENT=16;
var ATTR_SCENERY=17;
var ATTR_SUPPORTER = 18;
var ATTR_SWITCHABLE=19;
var ATTR_ON  =20;
var ATTR_STATIC  =21;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////// INTERNAL STRINGS ///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// General messages & strings
var STR_NEWLINE = '<br />';
var STR_PROMPT_START = '<span class="feedback">&gt; ';
var STR_PROMPT_END = '</span>';
var STR_RAMSAVE_FILENAME = 'RAMSAVE_SAVEGAME';



// Runtime error messages
var STR_WRONG_SYSMESS = 'WARNING: System message requested does not exist.'; 
var STR_WRONG_LOCATION = 'WARNING: Location requested does not exist.'; 
var STR_WRONG_MESSAGE = 'WARNING: Message requested does not exist.'; 
var STR_WRONG_PROCESS = 'WARNING: Process requested does not exist.' 
var STR_RAMLOAD_ERROR= 'WARNING: You can\'t restore game as it has not yet been saved.'; 
var STR_RUNTIME_VERSION  = 'ngPAWS runtime (C) 2014 Carlos Sanchez.  Released under {URL|http://www.opensource.org/licenses/MIT| MIT license}.\nBuzz sound libray (C) Jay Salvat. Released under the {URL|http://www.opensource.org/licenses/MIT| MIT license} \n jQuery (C) jQuery Foundation. Released under the {URL|https://jquery.org/license/| MIT license}.';
var STR_TRANSCRIPT = 'To copy the transcript to your clipboard, press Ctrl+C, then press Enter';

var STR_INVALID_TAG_SEQUENCE = 'Invalid tag sequence: ';
var STR_INVALID_TAG_SEQUENCE_EMPTY = 'Invalid tag sequence.';
var STR_INVALID_TAG_SEQUENCE_BADPARAMS = 'Invalid tag sequence: bad parameters.';
var STR_INVALID_TAG_SEQUENCE_BADTAG = 'Invalid tag sequence: unknown tag.';
var STR_BADIE = 'You are using a very old version of Internet Explorer. Some features of this product won\'t be avaliable, and other may not work properly. For a better experience please upgrade your browser or install some other one like Firefox, Chrome or Opera.\n\nIt\'s up to you to continue but be warned your experience may be affected.';
var STR_INVALID_OBJECT = 'WARNING: Trying to access object that does not exist'


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////     FLAGS     ///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


var FLAG_LIGHT = 0;
var FLAG_OBJECTS_CARRIED_COUNT = 1;
var FLAG_AUTODEC2 = 2; 
var FLAG_AUTODEC3 = 3;
var FLAG_AUTODEC4 = 4;
var FLAG_AUTODEC5 = 5;
var FLAG_AUTODEC6 = 6;
var FLAG_AUTODEC7 = 7;
var FLAG_AUTODEC8 = 8;
var FLAG_AUTODEC9 = 9;
var FLAG_AUTODEC10 = 10;
var FLAG_ESCAPE = 11;
var FLAG_PARSER_SETTINGS = 12;
var FLAG_PICTURE_SETTINGS = 29
var FLAG_SCORE = 30;
var FLAG_TURNS_LOW = 31;
var FLAG_TURNS_HIGH = 32;
var FLAG_VERB = 33;
var FLAG_NOUN1 =34;
var FLAG_ADJECT1 = 35;
var FLAG_ADVERB = 36;
var FLAG_MAXOBJECTS_CARRIED = 37;
var FLAG_LOCATION = 38;
var FLAG_TOPLINE = 39;   // deprecated
var FLAG_MODE = 40;  // deprecated
var FLAG_PROTECT = 41;   // deprecated
var FLAG_PROMPT = 42; 
var FLAG_PREP = 43;
var FLAG_NOUN2 = 44;
var FLAG_ADJECT2 = 45;
var FLAG_PRONOUN = 46;
var FLAG_PRONOUN_ADJECT = 47;
var FLAG_TIMEOUT_LENGTH = 48;
var FLAG_TIMEOUT_SETTINGS = 49; 
var FLAG_DOALL_LOC = 50;
var FLAG_REFERRED_OBJECT = 51;
var FLAG_MAXWEIGHT_CARRIED = 52;
var FLAG_OBJECT_LIST_FORMAT = 53;
var FLAG_REFERRED_OBJECT_LOCATION = 54;
var FLAG_REFERRED_OBJECT_WEIGHT = 55;
var FLAG_REFERRED_OBJECT_LOW_ATTRIBUTES = 56;
var FLAG_REFERRED_OBJECT_HIGH_ATTRIBUTES = 57;
var FLAG_EXPANSION1 = 58;
var FLAG_EXPANSION2 = 59;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////// SPECIAL LOCATIONS ///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var LOCATION_WORN = 253;
var LOCATION_CARRIED = 254;
var LOCATION_NONCREATED = 252;
var LOCATION_HERE = 255;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////  SYSTEM MESSAGES  ///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



var SYSMESS_ISDARK = 0;
var SYSMESS_YOUCANSEE = 1;
var SYSMESS_PROMPT0 = 2;
var SYSMESS_PROMPT1 = 3;
var SYSMESS_PROMPT2 = 4
var SYSMESS_PROMPT3= 5;
var SYSMESS_IDONTUNDERSTAND = 6;
var SYSMESS_WRONGDIRECTION = 7
var SYSMESS_CANTDOTHAT = 8;
var SYSMESS_YOUARECARRYING = 9;
var SYSMESS_WORN = 10;
var SYSMESS_CARRYING_NOTHING = 11;
var SYSMESS_AREYOUSURE = 12;
var SYSMESS_PLAYAGAIN = 13;
var SYSMESS_FAREWELL = 14;
var SYSMESS_OK = 15;
var SYSMESS_PRESSANYKEY = 16;
var SYSMESS_TURNS_START = 17;
var SYSMESS_TURNS_CONTINUE = 18;
var SYSMESS_TURNS_PLURAL = 19;
var SYSMESS_TURNS_END = 20;
var SYSMESS_SCORE_START= 21;
var SYSMESS_SCORE_END =22;
var SYSMESS_YOURENOTWEARINGTHAT = 23;
var SYSMESS_YOUAREALREADYWEARINGTHAT = 24;
var SYSMESS_YOUALREADYHAVEOBJECT = 25;
var SYSMESS_CANTSEETHAT = 26;
var SYSMESS_CANTCARRYANYMORE = 27;
var SYSMESS_YOUDONTHAVETHAT = 28;
var SYSMESS_YOUAREALREADYWAERINGOBJECT = 29;
var SYSMESS_YES = 30;
var SYSMESS_NO = 31;
var SYSMESS_MORE = 32;
var SYSMESS_CARET = 33;
var SYSMESS_TIMEOUT=35;
var SYSMESS_YOUTAKEOBJECT = 36;
var SYSMESS_YOUWEAROBJECT = 37;
var SYSMESS_YOUREMOVEOBJECT = 38;
var SYSMESS_YOUDROPOBJECT = 39;
var SYSMESS_YOUCANTWEAROBJECT = 40;
var SYSMESS_YOUCANTREMOVEOBJECT = 41;
var SYSMESS_CANTREMOVE_TOOMANYOBJECTS = 42;
var SYSMESS_WEIGHSTOOMUCH = 43;
var SYSMESS_YOUPUTOBJECTIN = 44;
var SYSMESS_YOUCANTTAKEOBJECTOUTOF = 45;
var SYSMESS_LISTSEPARATOR = 46;
var SYSMESS_LISTLASTSEPARATOR = 47;
var SYSMESS_LISTEND = 48;
var SYSMESS_YOUDONTHAVEOBJECT = 49;
var SYSMESS_YOUARENOTWEARINGOBJECT = 50;
var SYSMESS_PUTINTAKEOUTTERMINATION = 51;
var SYSMESS_THATISNOTIN = 52;
var SYSMESS_EMPTYOBJECTLIST = 53;
var SYSMESS_FILENOTFOUND = 54;
var SYSMESS_CORRUPTFILE = 55;
var SYSMESS_IOFAILURE = 56;
var SYSMESS_DIRECTORYFULL = 57;
var SYSMESS_LOADFILE = 58;
var SYSMESS_FILENOTFOUND = 59;
var SYSMESS_SAVEFILE = 60;
var SYSMESS_SORRY = 61;
var SYSMESS_NONSENSE_SENTENCE = 62;
var SYSMESS_NPCLISTSTART = 63;
var SYSMESS_NPCLISTCONTINUE = 64;
var SYSMESS_NPCLISTCONTINUE_PLURAL = 65;
var SYSMESS_INSIDE_YOUCANSEE = 66;
var SYSMESS_OVER_YOUCANSEE = 67;
var SYSMESS_YOUPUTOBJECTON = 68;
var SYSMESS_YOUCANTTAKEOBJECTFROM = 69;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////// GLOBAL VARS //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Parser vars
var last_player_orders = [];   // Store last player orders, to be able to restore it when pressing arrow up
var last_player_orders_pointer = 0;
var parser_word_found;
var player_order_buffer = '';
var player_order = ''; // Current player order
var previous_verb = EMPTY_WORD;
var previous_noun = EMPTY_WORD;
var previous_adject = EMPTY_WORD;
var pronoun_suffixes = [];


//Settings
var graphicsON = true; 
var soundsON = true; 
var interruptDisabled = false;
var showWarnings = true;

// waitkey commands callback function
var waitkey_callback_function = [];

//PAUSE
var inPause=false;
var pauseRemainingTime = 0;



// Transcript
var inTranscript = false;
var transcript = '';


// Block
var inBlock = false;
var unblock_process = null;


// END
var inEND = false;

//QUIT
var inQUIT = false;

//ANYKEY
var inAnykey = false;

//GETKEY
var inGetkey = false;
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
var current_process;


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

//Autocomplete array
var autocomplete = new Array();
var autocompleteStep = 0;
var autocompleteBaseWord = '';