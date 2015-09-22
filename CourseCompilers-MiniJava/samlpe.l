%option noyywrap
%{
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()
%}

digit         [0-9]
letter        [a-zA-Z]

%%
{letter}+({letter}|{digit}|\_)*		{ cout << yytext << " IDENTOFIERn\n"; }
{digit}+	{ cout << yytext << " INTEGER_LITERAL\n"; }
\&\&|<|\+|-|\*	{ cout << yytext << " BINARY_OPERATOR\n"; }
(\/\/.*\n)|(\/\*.*\*\/)	{ cout << yytext << " COMMENT\n"; }
%%