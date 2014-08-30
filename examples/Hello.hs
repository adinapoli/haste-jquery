{-# LANGUAGE OverloadedStrings #-}
module Main where

import Haste
import Haste.Foreign
import Haste.JQuery

consoleLog :: JSString -> IO ()
consoleLog = ffi "(function (x) { console.log(x); })"

dump :: JQuery -> IO ()
dump = ffi "(function (x) { console.log(x); })"

main :: IO ()
main = ready $ do
  mainC <- elemById "mainContainer"
  newBox <- newElem "div"
  setAttr newBox "id" "myPreciousBox"
  setAttr newBox "style" "background-color: red"
  maybe (return ()) (addChild newBox) mainC
  -- Jquery
  myStuff <- select "#myPreciousBox"
  bod <- select "#mainContainer"
  dump myStuff
  dump bod
  select "#myBtn" >>= on "click" (const $ consoleLog "clicked!")
  select "#myText" >>= getText >>= consoleLog . toJSString
  _ <- select "#myText" >>= attr "style" "background-color: yellow"
  return ()
