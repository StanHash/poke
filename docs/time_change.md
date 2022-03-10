# changes to time

TODO: implement

RTC is not taken into account. Time is now purely "in game time".

Minutes and Hours are the only saved time parameters. Seconds are gone, instead, minutes are a word wide Q8 field, incremented by 0x.01 each frame.

So, for an in game minute to pass, it takes 256 in game frames (at 59.7 FPS, that's \~4.29s). A day passes thus in 6,177.6s (that's 102.96min/\~1h43min).

Ways for the player to manipulate igt should be provided (such as the ability yo sleep in beds to jump to specific times).
