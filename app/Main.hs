module Main where

import Config

main :: IO ()
main = do
       conf <- loadConfigFromFile "testConf.yaml"
       putStrLn $ show conf
