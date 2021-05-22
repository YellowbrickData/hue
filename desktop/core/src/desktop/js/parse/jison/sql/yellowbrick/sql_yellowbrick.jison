
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
 | '(' WithOptionList_EDIT
 | '(' WithOptionList_EDIT RightParenthesisOrError
 ;

WithOptionList_EDIT
 : WithOption_EDIT
 {
   parser.suggestKeywords([',']);
 }
 | WithOptionList ',' WithOption_EDIT
 | WithOptionList ',' WithOption 'CURSOR' RightParenthesisOrError
 {
   parser.suggestKeywords([',', ')']);
 }
 ;

WithOption_EDIT
 : 'CURSOR' RightParenthesisOrError
 {
   parser.suggestKeywords(["name 'value'"]);
 }
 | RegularIdentifier 'CURSOR' RightParenthesisOrError
 {
   parser.suggestKeywords(["''"]);
 }
 ;
