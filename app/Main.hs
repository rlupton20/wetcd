{-# LANGUAGE OverloadedStrings #-}
module Main where

import Config

import Network.Wai
import Network.HTTP.Types
import Network.Wai.Handler.Warp

main :: IO ()
main = do
       conf <- loadConfigFromFile "testConf.yaml"
       putStrLn $ show conf
       run 8000 testApp
       

testApp :: Application
testApp req respond = respond $ responseLBS status200 [] "Testing!"
