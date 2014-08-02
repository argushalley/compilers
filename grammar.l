/*=========================================================
  Compile:	flex <filename.l>
  		gcc lex.yy.c -lfl -o filename
  Use:
		./filename < test_file.c
=========================================================*/
%{
/*=========================================================
	C-libraries and token definitions
=========================================================*/
#include <stdio.h>
%}
/*=========================================================
		TOKEN Definitions
=========================================================*/
DELIM		[ \t\n]
WHITESPACE	{DELIM}+
DIGIT		[0-9]
NUMBER		{DIGIT}+
LETTER		[A-Za-z]
IDENTIFIER	{LETTER}({LETTER}|{DIGIT}|_)*
%%
"="				{ printf("ASSGNOP\n"); }
	/*================================================
        		Relational operators
	=================================================*/
"!="				{ printf("NEQOP\n"); }
"<"				{ printf("LTOP\n"); }
"<="                            { printf("LEOP\n"); }
">"                             { printf("GTOP\n"); }
">="                            { printf("GEOP\n"); }
        /*================================================
                        Aithmetic operators
        =================================================*/
"+"                            	{ printf("ADDOP\n"); }
"-"                             { printf("SUBOP\n"); }
"*"                             { printf("MULTOP\n"); }
"/"                             { printf("DIVOP\n"); }
"%"                             { printf("MODOP\n"); }
        /*================================================
                        Logical operators
        =================================================*/
"||"                            { printf("OROP\n"); }
"&&"                            { printf("ANDOP\n"); }
"!"                             { printf("NOTOP\n"); }
"{"                             { printf("LBRACE\n"); }
"}"                             { printf("RBRACE\n"); }
"["                             { printf("LBRACKET\n"); }
"]"                             { printf("RBRACKET\n"); }
"("                             { printf("LPARENTH\n"); }
")"                             { printf("RPARENTH\n"); }
"."                             { printf("PERIOD\n"); }
","                             { printf("COMMA\n"); }
";"                             { printf("SEMICOLON\n"); }
        /*================================================
                        Numbers
        =================================================*/
{NUMBER}			{ printf("NUMBER\n"); }
{NUMBER}\.{NUMBER}		{ printf("REAL NUMBER\n"); }
        /*================================================
                        Types
        =================================================*/
int				{ printf("INTEGER\n"); }
float				{ printf("FLOAT\n"); }
        /*================================================
                        Selection
        =================================================*/
if				{ printf("IF\n"); }
else				{ printf("ELSE\n"); }
        /*================================================
                        Repetition
        =================================================*/
while				{ printf("WHILE\n"); }
for				{ printf("FOR\n"); }
        /*================================================
                        Jumps
        =================================================*/
return				{ printf("RETURN\n"); }
{IDENTIFIER}			{ printf("IDENTIFIER\n"); }
{WHITESPACE}			{ ; }
%%
int main(int argc, char **argv) {
	/*FILE *file_in = fopen(argv[1], "r");

	if (file_in) {
		printf("Cannot open %s file!\n", argv[1]);
		return -1;
	}*/

	yylex();

	//fclose(file_in);
	return 0;
}
