-- | funnyPrint function to colorize GHCi output. See @FunnyPrint.funnyPrint@.
module FunnyPrint ( funnyPrint ) where

import IPPrint ( pshow )
import Language.Haskell.HsColour.Output ( TerminalType(..) )
import Language.Haskell.HsColour.Colourise ( Colour(..)
                                           , Highlight(..)
                                           , defaultColourPrefs
                                           )
import Language.Haskell.HsColour ( ColourPrefs(..)
                                 , Output(TTYg)
                                 , hscolour
                                 )

-- | Colorize GHCi. UTF8 support. Smart indentatntion. Use as @:set -interactive-print=funnyPrint@.
funnyPrint :: (Show a) => a -> IO ()
funnyPrint = putStrLn . colorize . con . pshow
  where
    con :: String -> String
    con [] = []
    con li@(x:xs) | x == '\"' = '\"':str ++ "\"" ++ (con rest)
                  | x == '\'' = '\'':chr:'\'':(con rest')
                  | otherwise = x:con xs
      where
        (str, rest):_  = reads li :: [(String, String)]
        (chr, rest'):_ = reads li :: [(Char,   String)]
    prefs = TTYg XTerm256Compatible
    colorize = hscolour prefs colours False False "" False
    colours = defaultColourPrefs { conid    = [ yellow , bold ]
                                 , conop    = [ yellow ]
                                 , string   = [ green ]
                                 , char     = [ cyan ]
                                 , number   = [ red , bold ]
                                 , layout   = [ black ]
                                 , keyglyph = [ black ]
                                 }
      where
        black   = Foreground Black
        red     = Foreground Red
        green   = Foreground Green
        yellow  = Foreground Yellow
        -- blue    = Foreground Blue
        magenta = Foreground Magenta
        cyan    = Foreground Cyan
        -- white   = Foreground White
        bold    = Bold
