"シンタックス定義

syntax keyword todoPriority 優先

syntax match todoTitle /++\S*/

syntax region todoComment start=+"+ end=+"+


"ハイライト定義

highlight link todoPriority Todo

highlight link todoTitle Define

highlight link todoComment Comment
let b:current_syntax = "kotlin"
