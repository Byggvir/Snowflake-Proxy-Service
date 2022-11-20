# Convert log connections log entries into cvs

s# #_#;
s# .*were #;#;
s# #;#;
s#conn.*↑ ##;
s# .* ↓ #;#;
s# .*##;
s#/#-#g;
s#_# #;
