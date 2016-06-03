-- | funnyPrint function to colorize GHCi output. See @FunnyPrint.funnyPrint@.
module FunnyPrint ( funnyPrint
                  , prompt
                  , prompt2 ) where

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
import Language.Haskell.HsColour.ANSI ( highlightOnG
                                      , highlightOff )

term    :: TerminalType
term    = XTerm256Compatible

black   :: Highlight
black   = Foreground Black

red     :: Highlight
red     = Foreground Red

green   :: Highlight
green   = Foreground Green

yellow  :: Highlight
yellow  = Foreground Yellow

blue    :: Highlight
blue    = Foreground Blue

-- magenta :: Highlight
-- magenta = Foreground Magenta

cyan    :: Highlight
cyan    = Foreground Cyan

-- white   :: Highlight
-- white   = Foreground White

bold    :: Highlight
bold    = Bold

-- | Colorize GHCi. UTF8 support. Smart indentatntion. Use as @:set -interactive-print=funnyPrint@.
funnyPrint :: (Show a) => a -- ^ printed input
           -> IO ()
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
    prefs = TTYg term
    colorize = hscolour prefs colours False False "" False
    colours = defaultColourPrefs { conid    = [ yellow, bold ]
                                 , conop    = [ yellow ]
                                 , string   = [ green ]
                                 , char     = [ cyan ]
                                 , number   = [ red, bold ]
                                 , layout   = [ black ]
                                 , keyglyph = [ black ]
                                 }

mark   :: Highlight -> String
mark h = highlightOnG term [h, bold]

-- | Prompt for GHCi.
prompt :: String -- ^ marker
       -> String -- ^ message
       -> String -- ^ separator
       -> String
prompt m t s = mark yellow
            ++ m
            ++ mark green
            ++ t
            ++ mark blue
            ++ s
            ++ highlightOff

-- | Second prompt for multiline GHCi.
prompt2 :: String -- ^ marker
        -> String -- ^ message
        -> String -- ^ separator
        -> String
prompt2 m t s = mark yellow
             ++ m
             ++ mark green
             ++ t
             ++ mark red
             ++ s
             ++ highlightOff
