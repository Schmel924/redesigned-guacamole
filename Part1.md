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
Открываем sheepolution и делаем все по инструкции. Т.Е. отключаем love2d, ставим LUA от sumneko, local lua debugger, переписываем настройки.джсон, создаем лаунчер.джсон, копировать - вставить, в майн.луа тоже вставляем, добавляем комментарии чтобы не забыть что это за лишний код

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

Откуда столько ворнингов?! Щщерт, ххорошо есть кнопка 