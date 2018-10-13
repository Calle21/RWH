module Nova.Parse.Chain (parseChain) where

import Nova.Parse.Util
import Nova.Types

parseChain :: (Setup, FilePath, [Indent]) -> (Setup, FilePath, [Indent])
parseChain (m:ms, _, y:ys) =
  let (ln,xs) = theLine y path
  in if xs `match` one isName >=> one isOpname >=> isEnd
     then let [name,op] = gets `map` xs
          in (m {chains = (name,op) : chains m} : ms,
              "chain",
              ys)
     else pError ln "chain" "Couldn't parse chain"

fixInfix :: Fixity -> Bool
fixInfix (Infixr _) = True
fixInfix (Infixl _) = True
fixInfix _          = False
