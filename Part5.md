# А смысл?
### Сначала нарисуем пару прямоугольников
Справочная страница love2d мне подсказала, что есть только два способа рисовать прямоугольники, через высоту\ширину, и полигональник по координатам, возьмем сразу второй.

Объявим наборы координат 
```
LeftGate = {x1=0, y1=RinkY/3, x2=50, y2=RinkY/3, x3=50, y3=RinkY*2/3, x4=0, y4=RinkY*2/3}
RightGate = {x1=RinkX-50, y1=RinkY/3,x2=RinkX, y2=RinkY/3, x3=RinkX,y3=RinkY*2/3, x4=RinkX-50, y4=RinkY*2/3}
```
Немножко магии, и, главное не перепутать порядок вершин. Я пошел с левого верхнего угла и по часовйо.
Внутрь love.draw() соответственно
```
    love.graphics.setColor (0,1,0)
    love.graphics.polygon("fill", LeftGate) 
    love.graphics.setColor (0,0,1)
    love.graphics.polygon("fill", RightGate)
```
Иии, результат, как обычно: ничего не работает.

#### Как работают таблицы
В корне я не разобрался, но если убрать х1= и y1=  из каждого элемента, таблитса начинает работать правильно. Прямоугольники на месте

### Movin goalposts
Но, вспоминая референс видео с канала матчтв, я решил что надо бы подвигать ворота от кромки. Результат 
```
LeftGate = {50, RinkY/3, 200, RinkY/3, 200, RinkY*2/3, 50, RinkY*2/3}
RightGate = {RinkX-200, RinkY/3,RinkX-50, RinkY/3, RinkX-50,RinkY*2/3, RinkX-200, RinkY*2/3}
```
### Это было просто, теперь пусть
Голы забиваются!

Если эти однострочники вам кажутся слишком длинными, купите монитор побольше
``` 
function PuckInGoal ()
if Puck.x > LeftGate[1] and Puck.x < LeftGate[3] and Puck.y > LeftGate[2] and Puck.y < LeftGate[6]  then Score("Left") end
if Puck.x > RightGate[1] and Puck.x < RightGate[3] and Puck.y > RightGate[2] and Puck.y < RightGate[6]  then Score("Right") end
end    
function Score(s)
if s == "Left" then LeftScore = LeftScore +1 ResetPuck () end
if s == "Right" then RightScore = RightScore +1 ResetPuck () end
end
```
`LeftScore ` = это секретный ингридиент который нам пригодится позже!
Пока пусть просто инициализируется нулем чтобы ошибок не происходило. 
Запускаем иии, опять нихуя не изменилось. 
#### ну почему я такой тупой?
Выясняем, дебажим. Хмм, почему функция `PuckInGoal` ни разу не вызывается?
Потому что, не вызывается! 

Вставляем ее вызов в `UpdatePuck`! Между проверкой на стенку и апдейтом движения. Пусть успевает "влететь" в ворота. Кстати, заодно изменим размер шайба, чего такая большая.

### И в матче побеждает...!
Выведем наконец счет на экран
```
love.graphics.print ("L"..LeftScore.."-R"..RightScore, (RinkX/2)-60, 10,0,4,4)
```
Масштаб слишком большой, да? Шрифт как нибудь в следующий раз подберу. Пока пусть такой будет.