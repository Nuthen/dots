-- libraries
class = require 'libs.middleclass'
vector = require 'libs.vector'
state = require 'libs.state'
tween = require 'libs.tween'
console = require 'libs.console'
require 'libs.generalmath'
require 'libs.util'

-- gamestates
require 'states.menu'
require 'states.game'

-- entities
require 'entities.dotSystem'
require 'entities.ship'
require 'entities.planet'

-- ui
require 'entities.ui.UI'
require 'entities.ui.changeButton'
require 'entities.ui.pane'
require 'entities.ui.slider'
require 'entities.ui.button'
require 'entities.ui.bar'

-- compatibility layer
local _setColor = love.graphics.setColor
love.graphics.setColor = function(r, g, b, a)
    if type(r) == "table" then
        r, g, b, a = unpack(r)
    end

    if a == nil then
        a = 255
    end

    _setColor(r/255, g/255, b/255, a/255)
end

local _getColor = love.graphics.getColor
love.graphics.getColor = function()
    local r, g, b, a = _getColor()
    return r*255, g*255, b*255, a*255
end


function love.load()
	love.window.setTitle(config.windowTitle)
    love.window.setIcon(love.image.newImageData(config.windowIcon))
	love.graphics.setDefaultFilter(config.filterModeMin, config.filterModeMax, config.anisotropy)
    love.graphics.setFont(font[16])
    console.load(love.graphics.newFont("fonts/Inconsolata.otf", 16))

    state.registerEvents()
    state.switch(menu)

    math.randomseed(os.time()/10)
end

function love.keypressed(key, code)
    if key == "escape" then
        love.event.quit()
    end
end

function love.mousepressed(x, y, mbutton)
    
end

function love.textinput(text)
    console.textInput(text)
end

function love.resize(w, h)
    console.resize(w, h)
end

function love.update(dt)
    if not config.debug then
        console.visible = false
    end

    tween.update(dt)
    console.update(dt)
end

function love.draw()
    console.draw()
end