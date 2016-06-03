# [funnyprint][]

funnyPrint function to colorize GHCi output.

***

see `FunnyPrint.funnyPrint`.

Use it as `:set -interactive-print=funnyPrint`.

- XTerm colors
- UTF8 output
- Simple indentation

### Customize GHCi prompt in right way

see `FunnyPrint.prompt` and `FunnyPrint.prompt2`.

#### Usage example

You may use it like this:

```haskell
:set -package funnyprint

:def color (\_ -> return (":set -interactive-print=FunnyPrint.funnyPrint\n:set prompt \"" ++ FunnyPrint.prompt "λ " "%s" " ¬\\nλ > " ++ "\"" ++ "\n:set prompt2 \"" ++ FunnyPrint.prompt2 "λ" "" " | " ++ "\""))
:def nocolor (\_ -> return ":set -interactive-print=print\n:set prompt \"%s> \"\n:set prompt2 \"%s| \"")

:color
```

***

#### TODO:

- replace `ipprint` with `stylish-haskell`

[funnyprint]: https://github.com/Pitometsu/funnyprint
