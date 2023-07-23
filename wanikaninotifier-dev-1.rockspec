package = "WaniKaniNotifier"
version = "dev-1"
source = {
   url = "git+https://github.com/Nosliwnayr/WaniKaniNotifier.git"
}
description = {
   summary = "WaniKani API Notifier",
   homepage = "https://github.com/Nosliwnayr/WaniKaniNotifier",
   license = "MIT"
}
dependencies = {
   "http >= 0.4",
   "lua-cjson >= 2.1.0",
   "date >= 2.2",
   "base64 >= 1.5",
   "argparse >= 0.7.1"
}
build = {
   type = "builtin",
   modules = {
      WaniKaniNotifier = "src/notifier.lua"
   }
}
