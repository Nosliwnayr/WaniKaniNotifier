-- Module initialization
local argparse = require "argparse"
local date = require "date"
local cjson = require "cjson"
local cjson_safe = require "cjson.safe"
local http_request = require "http.request"
local base64 = require'base64'

-- argument parsing setup
local parser = argparse()
parser:argument "WaniKaniAPIToken"
parser:argument "GotifyURL"
parser:argument "GotifyApplicationToken"

local args = parser:parse()

-- request formatting
local summary_request = http_request.new_from_uri("https://api.wanikani.com/v2/summary")
summary_request.headers:append("Wanikani-Revision", "20170710")
summary_request.headers:append("Authorization", "Bearer "..args.WaniKaniAPIToken)

-- request processing
local headers, stream = assert(summary_request:go())
local body = assert(stream:get_body_as_string())
if headers:get ":status" ~= "200" then
    error(body)
    os.exit()
end

-- Json -> Lua
local summary = cjson.decode(body)
local reviews_due = date(summary.data.next_reviews_at) <= date(true)

if reviews_due then
    -- Post to gotify
    local post_request = http_request.new_from_uri(args.GotifyURL.."/message?token="..args.GotifyApplicationToken)
    post_request.headers:upsert(":method", "POST")
    post_request.headers:upsert("Content-Type", "application/x-www-form-urlencoded")
    post_request:set_body("message=Reviews%20Ready!&priority=10")
    local headers, stream = assert(post_request:go())
    local body = assert(stream:get_body_as_string())
    if headers:get ":status" ~= "200" then
        error(body)
        os.exit()
    end
end
