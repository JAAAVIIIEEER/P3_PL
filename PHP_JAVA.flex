package PL;

%%
%class PHP_JAVA
%standalone
%states PHP
%states JAVA
%states JAVA_STRING
%states PHP_STRING

%{

// Empty at this moment

%}

%eof{

// Empty at this moment

%eof}
%%

// DETECT JAVA OR PHP BLOCKS

<YYINITIAL> {
"_BeginJava_" { System.out.println("JAVA_INI"); yybegin(JAVA);}
"<?php" { System.out.println("PHP_INI"); yybegin(PHP);}
\n {}
}

// JAVA BLOCK

<JAVA> {
"_EndJava_" { System.out.println("JAVA_FIN"); yybegin(YYINITIAL);}
[a-zA-Z_]+ { System.out.println("JAVA_ID(" + yytext() + ")"); yybegin(JAVA);}
"." { System.out.println("JAVA_PUNTO"); yybegin(JAVA);}
"(" { System.out.println("JAVA_ABREPAR"); yybegin(JAVA);}
")" { System.out.println("JAVA_CIERRAPAR"); yybegin(JAVA);}
"=" { System.out.println("JAVA_ASIGN"); yybegin(JAVA);}
";" { System.out.println("JAVA_FIN_INS"); yybegin(JAVA);}
"\"" { System.out.println("JAVA_CAD_INI"); yybegin(JAVA_STRING);}
\n {}
}

// Detect strings

<JAVA_STRING> {
\" { System.out.println("JAVA_CAD_FIN"); yybegin(JAVA);}
\n {System.out.println("Error en linea " + (yyline + 1) + " cadena sin terminar"); yybegin(JAVA);}
. {}
}

// Detect variable declarations
// Detect if statement
// Detect else statement
// Detect print statement

// PHP BLOCK

<PHP> {
"?>" { System.out.println("PHP_FIN"); yybegin(YYINITIAL);}
"$" {}
[a-zA-Z_]+ { System.out.println("PHP_ID(" + yytext() + ")"); yybegin(PHP);}
"=" { System.out.println("PHP_ASIGN"); yybegin(PHP);}
"." { System.out.println("PHP_PUNTO"); yybegin(PHP);}
"(" { System.out.println("PHP_ABREPAR"); yybegin(PHP);}
")" { System.out.println("PHP_CIERRAPAR"); yybegin(PHP);}
";" { System.out.println("PHP_FIN_INS"); yybegin(PHP);}
"\"" { System.out.println("PHP_CAD_INI"); yybegin(PHP_STRING);}
\n {}
" " {}
}

// Detect strings

<PHP_STRING> {
\" { System.out.println("PHP_CAD_FIN"); yybegin(PHP);}
\n {System.out.println("Error en linea " + (yyline + 1) + " cadena sin terminar"); yybegin(PHP);}
. {}
}

