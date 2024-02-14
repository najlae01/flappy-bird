--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local GOLD_MEDAL_IMAGE = love.graphics.newImage('gold.png')
local SILVER_MEDAL_IMAGE = love.graphics.newImage('silver.png')
local BRONZE_MEDAL_IMAGE = love.graphics.newImage('bronze.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 35, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 70, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 210, VIRTUAL_WIDTH, 'center')

    if self.score >= 0 and self.score < 2 then
        love.graphics.draw(BRONZE_MEDAL_IMAGE, VIRTUAL_WIDTH / 2 - BRONZE_MEDAL_IMAGE:getWidth() / 2, VIRTUAL_HEIGHT / 2 - BRONZE_MEDAL_IMAGE:getHeight() / 2)
    elseif self.score >= 2 and self.score < 5 then
        love.graphics.draw(SILVER_MEDAL_IMAGE, VIRTUAL_WIDTH / 2 - SILVER_MEDAL_IMAGE:getWidth() / 2, VIRTUAL_HEIGHT / 2 - SILVER_MEDAL_IMAGE:getHeight() / 2)
    elseif self.score >= 5 then
        love.graphics.draw(GOLD_MEDAL_IMAGE, VIRTUAL_WIDTH / 2 - GOLD_MEDAL_IMAGE:getWidth() / 2, VIRTUAL_HEIGHT / 2 - GOLD_MEDAL_IMAGE:getHeight() / 2)
    end
end