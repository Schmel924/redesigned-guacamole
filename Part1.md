# Как написать хеллоу ворлд за неделю

## Обстановка
Я хочу чтобы все было красиво, у меня есть пека и доступ в интернет.

## Шаги
1. Выбор ИДЕ. 
    - Я думал и решил попробовать VSCODE. НУ а чо?
2. Выбор движка.
    - Ну тут точно Love2d, давно по нему сохну
3. Установка.

### Установка

Love2d скачать с офф сайта, запустить волшебника, далее, далее, готово. Проверить появилась ли оно в PATH. Ну, на всякий

VSCode скачать с офф сайта, запустить волшебника, далее, далее, готово.
Запустить, поговорить с настройщиком, забить на все, открыть гугл, вбить 
> love2d vscode

~~profit~~

Начать ставить экстеншены через command palette (кто его придумал кстати? Неужто Атом? Или они скопировали у ВИМа?).

Обнаружить гуи для установки экстеншенов. 

Love2d Support должен работать

## Наконец прогаем

```
function love.draw()
    love.graphics.print("Hello World", 400, 300)
```
Почему такие сложные хоткеи для запуска?

### Установка 2
Открываем sheepolution и делаем все по инструкции. Т.Е. отключаем love2d support, ставим LUA от sumneko, local lua debugger, переписываем настройки.джсон, создаем лаунчер.джсон, копировать - вставить, в майн.луа тоже вставляем, добавляем комментарии чтобы не забыть что это за лишний код

## ну может быть теперь?

```
--sheepolution preface
local launch_type = arg[2]
if launch_type == "test" or launch_type == "debug" then
    require "lldebugger"
    if launch_type == "debug" then
        lldebugger.start()
    end
end


--Actual code

function love.load()

end

function love.update(dt)

end

function love.draw()
    -- love.graphics.print("Hello World", 400, 300)
end



--sheepolution footer
local love_errorhandler = love.errhand
function love.errorhandler(msg)
    if lldebugger then
        lldebugger.start() -- Add this
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
--
```

Откуда столько ворнингов?! Щщерт, ххорошо есть кнопка quick-fix, используем её трижды

###### final hello-world
```
--sheepolution preface
local launch_type = arg[2]
if launch_type == "test" or launch_type == "debug" then
    require "lldebugger"
    if launch_type == "debug" then
---@diagnostic disable-next-line: undefined-global
        lldebugger.start()
    end
end


--Actual code

function love.load()

end

function love.update(dt)

end

function love.draw()
    -- love.graphics.print("Hello World", 400, 300)
end



--sheepolution footer
---@diagnostic disable-next-line: undefined-field
local love_errorhandler = love.errhand
function love.errorhandler(msg)
---@diagnostic disable-next-line: undefined-global
    if lldebugger then
---@diagnostic disable-next-line: undefined-global
        lldebugger.start() -- Add this
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
```

Некрасиво, но зато Иде не ругается.

## Ну когда уже....

Неет, сначала настроим гит. Одной кнопкой. Хмм, а как добавить на гитхаб? Ладно об этом потом, мне уже скоро пора. Лучше покодим.

## Отныне только Actual Code

Скачаем подходящую картинку из сети и покажем её. Как там love.draw.image? Нет? НУ лаадно, полезли на вики.

```
function love.load()
 Rink = love.graphics.newImage("Backstage.png", nil)
end

function love.update(dt)
end

function love.draw()
    love.graphics.draw (Rink, 0,0,0,0.75)
end
```
Ужали картинку чтобы влезала на экран. Или лучше наоборот? Подогнать экран подкартинку!

```
function love.load()
 Rink = love.graphics.newImage("Backstage.png", nil)
 RinkX, RinkY = Rink:getDimensions()
 love.window.setMode(RinkX,RinkY,{resizable=true, vsync=false})
end

function love.update(dt)
end

function love.draw()
    love.graphics.draw (Rink)
end
```

Впендюрим поверх картинки квадрат малевича, потому что.

```
function love.draw()
    love.graphics.setColor (1,1,1)
    love.graphics.draw (Rink)
    love.graphics.setColor (0,0,0)
    love.graphics.rectangle( "fill", 50, 50, 50, 50 )
end
```
Ой, не туда!
```
love.graphics.rectangle( "fill", RinkX/2, RinkY/2, 50, 50)
```

Ну вот, теперь ухожу в отгул на неделю. Когда вернусь - напишу об этом [блогпост и залью на хаб](./Part2.md).
