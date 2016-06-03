import qualified FunnyPrint ( funnyPrint
                            , prompt
                            , prompt2 )

data ExampleData = ExampleData { int :: Int
                               , str :: String
                               , tup :: (Char, [Float])
                               } deriving Show

exampleData :: ExampleData
exampleData = ExampleData { int = 42
                          , str = "Hello, world!"
                          , tup = ('A', [pi, exp 1])
                          }

main :: IO ()
main = do
  putStrLn "Example data:"
  putStrLn $ FunnyPrint.prompt "λ " "Hello, world!" " >"
  putStrLn $ FunnyPrint.prompt2 "λ " "enjoy colors ;)" " |"
  FunnyPrint.funnyPrint exampleData
