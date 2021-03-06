Text segment 'code' ;(30)
; обработчик прерывания от таймера
; оформлен как процедура
; используются макрокоманды из файла mac.mac
assume CS:text,DS:data;(31)

include mac.mac ;(2)

main proc ;(4))Главная процедура

mov AX,data ;(5))Сделаем наши данные

mov DS,AX ;(6))адресуемыми

mov AX,351ch ;(7)Функция 35h, вектор 1C

int 21h ;(8)Вызов DOS

mov word ptr old_lch,BX ;(9))Сохраним смещение сегментного обработчик

mov word ptr old_lch+2,ES ;(10))Сохраним сегмент системного обработчик

;Заполним вектор 1Ch

mov AX,251Ch ;(11))Функция 25h, вектор 1C

mov DX,offset new_1ch ;(12)Смещение нашего обработчика

push DS ;(13)Сохраним наш DS

push CS ;(14)Настроим DS на сегмент обработчика

pop DS ;(15)(т.е. на сегмент команд

int 21h ;(16))Вызов DOS

pop DS ;(17))Восстановим адресуемость данны

;Организуем контрольный вывод на экран строк текста в цикле с задержкой

mov cx,20 ;(18))Число повторений вывода строк

wri: write_string ;(19)Макрокоманда вывода на экран

delay_50 ;(20))Макрокоманда задержк

loop wri ;(21)

;Перед завершением программы восстановим содержимое вектора 1Ch

lea DX,old_lch ;(22))Отправим в DS:DX сохраненный вектор 1C

mov AX,251Ch ;(23))Функция 25h, вектор 1C

int 21h ;(24)Вызов DOS ;Завершим программу обычным образом

outprog ;(25)Завершение программы

main endp ;(26)Конец главной процедуры

new_1ch proc ;(27)Процедура нашего обработчика

;Наш обработчик от таймера. Его функция - вывод на экран мигающего символа,

;свидетельствующего об активности программы!

push AX ;(28))Сохраним используемые в

push ES ;(29))нем регистры

mov AX,0b800h ;(30))Настроим ES

mov ES,AX ;(31)на видеобуфер

mov AX,CS:syml ;(32)Получим символ с атрибутом из ячейки syml

mov ES:3998,AX ;(33))Выведем в последнюю позицию экрана

xchg AX,CS:sym2 ;(34)Обменяем содержимое

mov CS:syml,AX ;(35)ячеек syml и sym2

pop ES ;(36)Восстановим

pop AX ;(37)сохраненные регистр

iret ;(38)Вывод из прерывания

;Поля данных обработчика в сегменте команд

syml dw 421Eh ;(39)Символы с атрибутами

sym2 dw 241Eh ;(40))для вывода на экра

new_1ch endp ;(41))Конец процедуры обработчик

data segment ;(43)

old_lch dd 0 ;(44))Двухсловная ячейка для хранения

; исходного вектора

string db '************0123456789**********',10,13,'$' ;(45)

data ends;(46) ;(97)

Text ends;(42)

end main ;(47)

stk segment stack 'stack';(98)

dw 128 dup (0) ;(99)

stk ends ;(100)

end main ;(101)

mac.mac

outprog macro ;(1)Завершение программы

mov AX,4C00h ;(2)

int 21h ;(3)

endm ;(4)

delay_50 macro ;(5)Задержка

push CX ;(6)

mov CX,100 ;(7)Счетчик внешнего цикла

outer: push CX ;(8)Сохраним его в стеке

mov CX,65535 ;(9)Счетчик внутреннего цикла

inner: loop inner ;(10)Повторим команду loop 65535 раз

pop CX ;(11)Восстановим внешний счетчик

loop outer ;(12)Повторим все это 100 раз

pop CX ;(13)Восстановим счетчик демо-цикла

endm ;(14)

write_string macro ;(15)

mov AH,09h ;(16) AH=09h номер функции вывода на экран

mov DX,offset string ; (17) В DX заносится адрес выводимого сообщения

int 21h ; (18) Вызов прерывания MS-DOS

endm ;(19)