/* Данный пример скорее всего даже не является рабочим, нужен для того, чтобы была возможность найти и загуглить то, что нужно гуглить */

/* Секция с кодом, который попадет в парсер.*/
%{
#include <iostream>
extern "C" int yylex();
void yyerror( int*, const char* );
%}

/* Этот код будет помещен до определения Union
Обычно используется для описания классов, реализующих синтаксическое дерево. */
/* Параметры функции парсера. */
%parse-param { int* hasError }

/* Определение возможных типов выражения. */
%union{
	int ival;
	char sval[255];
}

/* Определение лево-ассоцитивности. Аналогично есть %right.
Порядок объявление важен - чем позже объявлен оператор, тем больше его приоритет.
В данном случае оба оператора лево-ассоциативные, но - имеет более высокий приоритет, чем & и |. */
%left '<'
%left '-' '+'
%left '*'
%left UMINUS
%left '&'
%left '[' ']' '.'

/* Определение токенов. Можно задать ассоциируемый с токеном тип из Union. */
%token<ival> INTEGER_LITERAL
%token CLASS
%token BINARY_OPERATOR
%token COMMENT
%token<sval> ID
%token PUBLIC
%token STATIC
%token VOID
%token MAIN
%token STRING
%token EXTENDS
%token BOOLEAN
%token IF
%token ELSE
%token WHILE
%token PRINTLN
%token LENGTH
%token TRUE
%token FALSE
%token THIS
%token NEW 
%token RETURN
%token INT
/* Связываем тип из union и символ парсера. */

/* Секция с описанием правил парсера. */
%%
Program:
	MainClass {}
	| MainClass ClassDecls {}
	;

ClassDecls:
	ClassDecl {}
	| ClassDecls ClassDecl {}
	;

MainClass:
	CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '['']' ID  '{' Statement '}' '}' {}
	;
ClassDecl:
	CLASS ID '{'VarDecl MethodDecl'}' {}
	| CLASS ID '{'VarDecl'}' {}
	| CLASS ID '{'MethodDecl'}' {}
	| CLASS ID '{''}' {}
	| CLASS ID EXTENDS ID '{'VarDecl MethodDecl'}' {}
	| CLASS ID EXTENDS ID '{'VarDecl'}' {}
	| CLASS ID EXTENDS ID '{'MethodDecl'}' {}
	| CLASS ID EXTENDS ID '{''}' {}
	;
VarDecl:
	Type ID {}
	| VarDecl VarDecl {}
	;
MethodDecl:
	PUBLIC Type ID '(' FormalList  ')' '{'VarDecl Statement RETURN Exp ';''}' {}
	| PUBLIC Type ID '(' FormalList  ')' '{'VarDecl RETURN Exp ';''}' {}
	| PUBLIC Type ID '(' FormalList  ')' '{' Statement RETURN Exp ';''}' {}
	| PUBLIC Type ID '(' FormalList  ')' '{' RETURN Exp ';''}' {}
	| MethodDecl MethodDecl {}
	;
FormalList:
	Type ID FormalRest {}
	| Type ID {}
	;
FormalRest:
	',' Type ID {}
	| FormalRest FormalRest {}
	;
Type:
	INT '['']' {}
	| BOOLEAN {}
	| INT {}
	| ID {}
	;
Statement:
	Statement Statement {}
	| '{'Statement'}' {}
	| IF '(' Exp ')' Statement ELSE Statement {}
	| WHILE '(' Exp ')' Statement {}
	| PRINTLN '(' Exp ')'';' {}
	| ID '=' Exp ';'
	| ID '['Exp']' '=' Exp ';'
	;
Exp:
	Exp '+' Exp {}
	| Exp '-' Exp {}
	| Exp '*' Exp {}
	| '-' Exp %prec UMINUS {}
	| Exp '&' '&' Exp {}
	| Exp '<' Exp {}
	| Exp '[' Exp ']' {}
	| Exp'.' LENGTH {}
	| Exp '.' ID '(' ExpList ')' {}
	| INTEGER_LITERAL {}
	| TRUE {}
	| FALSE {}
	| ID {}
	| THIS {}
	| NEW INT '['Exp']' {}
	| NEW ID '('')' {}
	| '!' Exp {}
	| '('Exp')' {}
	;
ExpList:
	Exp ExpRest {}
	| Exp {}
	;
ExpRest:
	',' Exp {}
	| ExpRest ExpRest {}
	;
%%
/* Функция обработки ошибки. */
void yyerror( int*, const char* str )
{
	std::cout << str << std::endl;
}