/* ������ ������ ������ ����� ���� �� �������� �������, ����� ��� ����, ����� ���� ����������� ����� � ��������� ��, ��� ����� ������� */

/* ������ � �����, ������� ������� � ������.*/
%{
#include <iostream>
extern "C" int yylex();
void yyerror( int*, const char* );
%}

/* ���� ��� ����� ������� �� ����������� Union
������ ������������ ��� �������� �������, ����������� �������������� ������. */
/* ��������� ������� �������. */
%parse-param { int* hasError }

/* ����������� ��������� ����� ���������. */
%union{
	int ival;
	char sval[255];
	CProgram* program;
}

/* ����������� ����-��������������. ���������� ���� %right.
������� ���������� ����� - ��� ����� �������� ��������, ��� ������ ��� ���������.
� ������ ������ ��� ��������� ����-�������������, �� - ����� ����� ������� ���������, ��� & � |. */
%left '+' '-'
%left '*'
%left UMINUS
%left '[' ']'
%left '(' ')'
%left '.'
%left '!' '&' '<'

/* ����������� �������. ����� ������ ������������� � ������� ��� �� Union. */
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
%type<CProgram> Program
/* ��������� ��� �� union � ������ �������. */

/* ������ � ��������� ������ �������. */
%%
Program:
	MainClass {}
	| MainClass ClassDecls {$$ = new CProgram( $1, $2 ); }
	;
ClassDecls:
	ClassDecl { $$ = new CClassDecls($1); }
	| ClassDecls ClassDecl { $1->addNext($2); }
	;
MainClass:
	CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' Statement '}' '}' {}
	;
ClassDecl:
	CLASS ID '{'VarDecls MethodDecls'}' {}
	| CLASS ID '{'VarDecls'}' {}
	| CLASS ID '{'MethodDecls'}' {}
	| CLASS ID '{''}' {}
	| CLASS ID EXTENDS ID '{'VarDecls MethodDecls'}' {}
	| CLASS ID EXTENDS ID '{'VarDecls'}' {}
	| CLASS ID EXTENDS ID '{'MethodDecls'}' {}
	| CLASS ID EXTENDS ID '{''}' {}
	;
VarDecls:
	VarDecl {}
	| VarDecls VarDecl {}
	;
MethodDecls:
    MethodDecl {} 
	| MethodDecls MethodDecl {}
	;
VarDecl:
	Type ID ';' {}
	;
MethodDecl:
	PUBLIC Type ID '(' FormalList  ')' '{' VarDecls Statements RETURN Exp ';' '}' {}
	| PUBLIC Type ID '(' FormalList  ')' '{' VarDecls RETURN Exp ';' '}' {}
	| PUBLIC Type ID '(' FormalList  ')' '{' Statements RETURN Exp ';' '}' {}
	| PUBLIC Type ID '(' FormalList  ')' '{' RETURN Exp ';' '}' {}
	;
Statements:
	Statement {}
	| Statements Statement {}
	;
FormalList:
	Type ID FormalRests {}
	| Type ID {}
	;
FormalRests:
	FormalRest {}
	| FormalRests FormalRest {}
	;
FormalRest:
	',' Type ID {}
	;
Type:
	INT '['']' {}
	| BOOLEAN {}
	| INT {}
	| ID {}
	;
Statement:
	'{'Statement'}' {}
	| IF '(' Exp ')' Statement ELSE Statement {}
	| WHILE '(' Exp ')' Statement {}
	| PRINTLN '(' Exp ')'';' {}
	| ID '=' Exp ';' {}
	| ID '['Exp']' '=' Exp ';' {}
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
	| NEW INT '[' Exp ']' {}
	| NEW ID '(' ')' {}
	| '!' Exp {}
	| '(' Exp ')' {}
	;
ExpList:
	Exp ExpRests {}
	| Exp {}
	;
ExpRests:
	ExpRest {}
	| ExpRests ExpRest {} 
ExpRest:
	',' Exp {}
	;
%%
/* ������� ��������� ������. */
void yyerror( int*, const char* str )
{
	std::cout << str << std::endl;
}