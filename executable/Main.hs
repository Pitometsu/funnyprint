import qualified FunnyPrint ( funnyPrint )

data TestData = TestData { int :: Int
                         , str :: String
                         , tup :: (Char, [Float])
                         } deriving Show

testData :: TestData
testData = TestData { int = 42
                    , str = "Hello, world!"
                    , tup = ('A', [pi, exp 1])
                    }

main :: IO ()
main = FunnyPrint.funnyPrint testData
