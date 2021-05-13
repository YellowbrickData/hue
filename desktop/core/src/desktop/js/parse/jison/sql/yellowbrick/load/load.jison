
// Yellowbrick LOAD grammar starts here.

DataDefinition
: LoadTableStatement
;

LoadTableStatement
: 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier 'FROM' LoadFromSpec 'EXTERNAL' 'LOCATION' SchemaQualifiedIdentifier
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier 'FROM' LoadFromSpec 'EXTERNAL' 'LOCATION' SchemaQualifiedIdentifier 'EXTERNAL' 'FORMAT' SchemaQualifiedIdentifier
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier 'SOURCE' 'FIELDS' LoadSourceFieldsSpec 'FROM' LoadFromSpec 'EXTERNAL' 'LOCATION' SchemaQualifiedIdentifier
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier 'SOURCE' 'FIELDS' LoadSourceFieldsSpec 'FROM' LoadFromSpec 'EXTERNAL' 'LOCATION' SchemaQualifiedIdentifier 'EXTERNAL' 'FORMAT' SchemaQualifiedIdentifier
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
    parser.suggestDatabases({ appendDot: true });
  }
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier 'CURSOR'
  {
    parser.suggestKeywords(['FROM', 'SOURCE FIELDS']);
  }
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier LoadFromSpec_EDIT
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier LoadFromSpec 'CURSOR'
  {
    parser.suggestKeywords(['EXTERNAL LOCATION']);
  }
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier LoadFromSpec 'EXTERNAL' 'LOCATION' 'CURSOR'
  {
    parser.suggestExternalLocations();
  }
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier LoadFromSpec 'EXTERNAL' 'LOCATION' SchemaQualifiedIdentifier 'CURSOR'
  {
    parser.suggestKeywords(['EXTERNAL FORMAT']);
  }
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier LoadFromSpec 'EXTERNAL' 'LOCATION' SchemaQualifiedIdentifier 'EXTERNAL' 'FORMAT' 'CURSOR'
  {
    parser.suggestExternalFormats();
  }
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier LoadSourceFieldsSpec_EDIT
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier LoadSourceFieldsSpec 'CURSOR'
  {
    parser.suggestKeywords(['FROM']);
  }
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier LoadSourceFieldsSpec LoadFromSpec_EDIT
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier LoadSourceFieldsSpec LoadFromSpec 'CURSOR'
  {
    parser.suggestKeywords(['EXTERNAL LOCATION']);
  }
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier LoadSourceFieldsSpec LoadFromSpec 'EXTERNAL' 'LOCATION' 'CURSOR'
  {
    parser.suggestExternalLocations();
  }
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier LoadSourceFieldsSpec LoadFromSpec 'EXTERNAL' 'LOCATION' SchemaQualifiedIdentifier 'CURSOR'
  {
    parser.suggestKeywords(['EXTERNAL FORMAT']);
  }
| 'LOAD' 'TABLE' SchemaQualifiedTableIdentifier LoadSourceFieldsSpec LoadFromSpec 'EXTERNAL' 'LOCATION' SchemaQualifiedIdentifier 'EXTERNAL' 'FORMAT' 'CURSOR'
  {
    parser.suggestExternalFormats();
  }
;

LoadSourceFieldsSpec
: 'SOURCE' 'FIELDS' ParenthesizedColumnSpecificationList
;
LoadSourceFieldsSpec_EDIT
: 'SOURCE' 'FIELDS' ParenthesizedColumnSpecificationList_EDIT
;

LoadFromSpec
: 'FROM' '(' LoadFromSpecList ')'
;
LoadFromSpec_EDIT
: 'FROM' 'CURSOR'
  {
    parser.suggestKeywords(['(']);
  }
| 'FROM' '(' LoadFromSpecList_EDIT RightParenthesisOrError
;
LoadFromSpecList
: SingleQuotedValue
| LoadFromSpecList ',' SingleQuotedValue
;
LoadFromSpecList_EDIT
: SingleQuotedValue_EDIT
| LoadFromSpecList ',' SingleQuotedValue_EDIT
| SingleQuotedValue_EDIT ',' LoadFromSpecList
| LoadFromSpecList ',' SingleQuotedValue_EDIT ',' LoadFromSpecList
;
