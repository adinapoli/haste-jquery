{-# LANGUAGE OverloadedStrings #-}
module Haste.JQuery where

import Haste.Foreign
import Haste hiding (Event)


--------------------------------------------------------------------------------
-- | The JQuery datatype is just a type synonym with Haste's builtin
-- "Elem" time, to be backward compatible with "Haste.DOM"
type JQuery = Elem


--------------------------------------------------------------------------------
type EventType = String


--------------------------------------------------------------------------------
ready :: IO () -> IO ()
ready = ffi "(function (f) { jQuery(document).ready(f); })"


--------------------------------------------------------------------------------
select :: ElemID -> IO JQuery
select el = let elJs = toJSString el in doFFI elJs
  where
    doFFI :: JSString -> IO JQuery
    doFFI = ffi "(function (elId) { return jQuery(elId); })"


--------------------------------------------------------------------------------
on :: EventType -> (JSAny -> IO ()) -> JQuery -> IO ()
on et fn jQ = let etJs = toJSString et in doFFI etJs fn jQ
  where
    doFFI :: JSString -> (JSAny -> IO ()) -> JQuery -> IO ()
    doFFI = ffi "(function (et, fn, domEl) { return domEl.on(et, fn); })"


--------------------------------------------------------------------------------
getText :: JQuery -> IO String
getText = ffi "(function (domEl) { return domEl.text(); })"


--------------------------------------------------------------------------------
attr :: PropID -> String -> JQuery -> IO JQuery
attr k v jQ = let kJs = toJSString k; vJs = toJSString v in doFFI kJs vJs jQ
  where
    doFFI :: JSString -> JSString -> JQuery -> IO JQuery
    doFFI = ffi "(function (k,v, domEl) { return domEl.attr(k,v); })"
