import cpp

from MacroInvocation m 
where m.getMacroName().regexpMatch("ntohs|ntohl|ntohll") 
select m.getExpr()
