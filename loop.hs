loop :: Integer-> IO ()
loop i = do
    print (i)
    loop(i + 1)

main :: IO ()
main =  do
    loop 0