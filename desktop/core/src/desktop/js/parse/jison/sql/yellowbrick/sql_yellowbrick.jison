
// EXTERNAL COMMON

WithClause
 : ParenthesizedWithOptionsList
 ;

ParenthesizedWithOptionsList
 : '(' WithOptionList ')'
 ;

WithOptionList
 : WithOption
 | WithOptionList ',' WithOption
 ;

WithOption
 : RegularIdentifier WithValue
 ;

WithValue
 : TRUE
 | FALSE
 | ON
 | OFF
 | SingleQuotedValue
 ;

WithClause_EDIT
 : ParenthesizedWithOptionsList_EDIT
 ;

ParenthesizedWithOptionsList_EDIT
 : 'CURSOR'
 {
   parser.suggestKeywords(["(name 'value')"]);
 }
 | '(' WithOption WithValue 'CURSOR' RightParenthesisOrError
 {
   parser.suggestKeywords([',']);
 }
 ;
