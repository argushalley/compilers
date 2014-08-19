/*=========================================================
  Compile:	flex <filename.l>
  		gcc lex.yy.c -lfl -o <filename>
  Use:
		./filename < <filename.c>
=========================================================*/
%{
/*=========================================================
	C-libraries and token definitions
=========================================================*/
#include <stdio.h>

// Prints a specified error message
void yyerror(const char *);

// Count number of lines in a source file
void countLines();

// Line's number
int lineNum = 1;

int yylval;

/*=========================================================
                TOKEN Definitions
=========================================================*/
#define		REL_OP 		130
#define		LT_OP 		131
#define 	LE_OP 		132
#define 	GT_OP 		133
#define 	GE_OP 		134
#define 	EQ_OP 		135
#define 	NE_OP 		136
#define 	ASSIGN 		137
#define 	TYPEDEF 	138
#define 	STRUCT 		139
#define 	LOG_OP 		140
#define 	AND_OP 		141
#define 	OR_OP 		142
#define 	NOT_OP 		143
#define 	CHAR 		144
#define 	INT 		145
#define 	FLOAT 		146
#define 	DOUBLE 		147
#define 	STRING 		148
#define 	REF 		149
#define 	ART_OP 		150
#define 	ADD_OP 		151
#define 	SUB_OP 		152
#define 	MUL_OP 		153
#define 	DIV_OP 		154
#define 	MOD_OP 		155
#define 	EXP_OP 		156
#define 	CASE 		157
#define 	DEFAULT 	158
#define 	IF 		159
#define 	ELSE 		160
#define 	SWITCH 		161
#define 	WHILE 		162
#define 	DO 		163
#define 	FOR 		164
#define 	CONTINUE 	165
#define 	BREAK 		166
#define 	RETURN 		167
#define 	BEGIN_		168
#define 	END_ 		169
#define		PRINT		170
#define		SCAN		171
#define 	PROCEDURE 	172
#define 	NUMBER 		173
#define 	CHARACTER 	174
#define 	TEXT 		175
#define 	CONSTANT 	176
#define 	IDENTIFIER 	177
%}
/*=========================================================
		Regular Expressions
=========================================================*/
delim		[ \t\n]
ws		{delim}+
digit		[0-9]
number		{digit}+(\.{digit}+)?(E[+-]?{digit}+)?
letter		[A-Za-z]
identifier	{letter}({letter}|{digit}|_)*
char_literal	\'(\\.|[^\\'])\'
string_literal	\"(\\.|[^\\"])*\"
comments	"/*"([^*]|\*+[^*/])*\*+"/"
%%
{ws}				{ countLines(); }
	/*================================================
                        Assignment
        =================================================*/
"="				{ return(ASSIGN); }
	/*================================================
        		Relational operators
	=================================================*/
"=="				{ yylval = EQ_OP; return(REL_OP); }
"!="				{ yylval = NE_OP; return(REL_OP); }
"<"				{ yylval = LT_OP; return(REL_OP); }
"<="                            { yylval = LE_OP; return(REL_OP); }
">"                             { yylval = GT_OP; return(REL_OP); }
">="                            { yylval = GE_OP; return(REL_OP); }
        /*================================================
        		Arithmetic operators
        =================================================*/
"+"                            	{ yylval = ADD_OP; return(ART_OP); }
"-"                             { yylval = SUB_OP; return(ART_OP); }
"*"                             { yylval = MUL_OP; return(ART_OP); }
"/"                             { yylval = DIV_OP; return(ART_OP); }
"%"                             { yylval = MOD_OP; return(ART_OP); }
"**"				{ yylval = EXP_OP; return(ART_OP); }
        /*================================================
        		Logical operators
        =================================================*/
"||"                            { yylval = OR_OP; return(LOG_OP); }
"&&"                            { yylval = AND_OP; return(LOG_OP); }
"!"                             { yylval = NOT_OP; return(LOG_OP); }
	/*================================================
        		Symbols
        =================================================*/
"{"                             { return('{'); }
"}"                             { return('}'); }
"["                             { return('['); }
"]"                             { return(']'); }
"("                             { return('('); }
")"                             { return(')'); }
"."                             { return('.'); }
";"                             { return(';'); }
        /*================================================
        		Types
        =================================================*/
"const"				{ return(CONSTANT); }
"int"				{ return(INT); }
"float"				{ return(FLOAT); }
"double"			{ return(DOUBLE); }
"char"				{ return(CHAR); }
"string"			{ return(STRING); }
        /*================================================
        		Selection
        =================================================*/
"if"				{ return(IF); }
"else"				{ return(ELSE); }
"switch"			{ return(SWITCH); }
"case"				{ return(CASE); }
"default"			{ return(DEFAULT); }
        /*================================================
        		Repetition
        =================================================*/
"do"				{ return(DO); }
"while"				{ return(WHILE); }
"for"				{ return(FOR); }
        /*================================================
        		Jump
        =================================================*/
"continue"			{ return(CONTINUE); }
"break"				{ return(BREAK); }
"return"			{ return(RETURN); }
	/*================================================
        		IO
        =================================================*/
"print"				{ return(PRINT); }
"scan"				{ return(SCAN); }
	/*================================================
                        Others
        =================================================*/
"BEGIN"				{ return(BEGIN_); }
"END"				{ return(END_); }
"struct"			{ return(STRUCT); }
"typedef"			{ return(TYPEDEF); }
"procedure"			{ return(PROCEDURE); }
"ref"				{ return(REF); }
	/*================================================
        		Literals/Comments              
        =================================================*/
{char_literal}                  { return(CHARACTER); }
{string_literal}		{ return(TEXT); }
{comments}			{ countLines(); }
{number}			{ return(NUMBER); }
{identifier}			{ return(IDENTIFIER); }
.				{ printf("Syntax error in line %d: ", lineNum); yyerror("Unknown symbol!\n"); }
%%

// Count number of lines in a source file
void countLines() {
	int i;
	for (i = 0; yytext[i] != '\0'; i++) {
		if (yytext[i] == '\n') {
			lineNum++;
		}
	}
}

// Print a specified error message
void yyerror(const char *error) {
	fprintf(stdout, "%s", error);
}

// Main function
int main(int argc, char **argv) {
	int ret;
	while( (ret = yylex()) != 0 ) {
		printf("%d\n", ret);
	}
	printf("Number of lines: %d\n", lineNum - 1);
	return 0;
}
