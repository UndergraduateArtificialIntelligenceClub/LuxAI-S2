grammar Lux;

/*
 * Parser
 */

program: bid place+ (day night)+ EOF;
line: expression | assignment | ifBlock | forBlock ;

bid: line* expression;
place: line* expression expression;
day: ;
night: ;

assignment: IDENTIFIER '=' expression;

block: '{' line* '}';
ifBlock: 'if ' expression block ('else' elseIfBlock);
elseIfBlock: block | ifBlock;
forBlock: 'for ' IDENTIFIER ' in ' expression block;
function: TYPE IDENTIFIER '(' (expression (',' expression))? ')';

expression
    : INTEGER                           #integerExpression
    | IDENTIFIER                        #identifierExpression
    | function                          #functionExpression
    | '(' expression ')'                #parenthesizedExpression
    | '!' expression                    #notExpression
    | expression multOp expression      #multiplicativeExpression
    | expression addOp expression       #additiveExpression
    | expression compareOp expression   #compareExpression
    ;

WS: [ \t\r\n]+ -> skip;

multOp: '*' | '/';
addOp: '+' | '-';
compareOp: '>' | '>=' | '<' | '<=';

/*
 * LEXER
 */

IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
INTEGER: [0-9]+;
TYPE: 'float' | 'integer';

/*
program        : stmt_list

stmt_list      : stmt
               | stmt_list stmt

stmt           : build_stmt
               | move_stmt
               | mine_stmt
               | farm_stmt
               | research_stmt
               | attack_stmt
               | defend_stmt
               | wait_stmt

build_stmt     : "build" building_type
building_type  : "farm" | "mine" | "barracks"

move_stmt      : "move" direction
direction      : "north" | "south" | "east" | "west"

mine_stmt      : "mine" resource_type
resource_type  : "wood" | "coal" | "uranium"

farm_stmt      : "farm" resource_type
resource_type  : "crop"

research_stmt  : "research" technology_name
technology_name: "iron_tools" | "steel_tools" | "radar"

attack_stmt    : "attack" target_type
target_type    : "unit" | "city"

defend_stmt    : "defend"

wait_stmt      : "wait" */