
// Yellowbrick LOAD grammar starts here.

DataDefinition
: LoadTableStatement
;

LoadTableStatement
: 'LOAD' LoadTableTarget RegularOrBacktickedIdentifier
;

LoadTableTarget
: 'TABLE'
;

DataDefinition_EDIT
: LoadTableStatement_EDIT
;

LoadTableStatement_EDIT
: 'LOAD' 'CURSOR'
  {
    parser.suggestKeywords(['TABLE']);
  }
| 'LOAD' 'TABLE' 'CURSOR'
  {
    parser.suggestTables();
  }
;
