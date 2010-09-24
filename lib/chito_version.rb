# encoding: utf-8
module Chito
    module VERSION
        MAJOR = 1
        MINOR = 2
        TINY  = 1
        BUILD = ""

        STRING = [MAJOR, MINOR, TINY, BUILD].join('.')
    end
    LANGUAGES = [["简体中文 (Simplified Chinese)", "zh-CN"], ["English","en-US"]]
    STARTTIME = Time.now
end
