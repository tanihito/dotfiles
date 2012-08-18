;;
;; WindowsでEmacs風キーバインド
;; http://usi3.com/index.php?title=Windows%E3%81%A7Emacs%E9%A2%A8%E3%82%AD%E3%83%BC%E3%83%90%E3%82%A4%E3%83%B3%E3%83%89
;;
#InstallKeybdHook
#UseHook
 
; C-x が押されると1になる
is_pre_x = 0
; C-Space が押されると1になる
is_pre_spc = 0
 
; Emacs風キーバインドを無効にしたいウィンドウ一覧
; 必要の無い部分はコメントアウトして下さい
is_target()
{
	IfWinActive,ahk_class PuTTY ;PuTTY
		Return 1
	IfWinActive,ahk_class ConsoleWindowClass ;Cygwin
		Return 1 
	IfWinActive,ahk_class MEADOW ;Meadow
		Return 1 
	IfWinActive,ahk_class cygwin/x X rl-xterm-XTerm-0
		Return 1
;	IfWinActive,ahk_class Vim ;Windows上のGVIM
;		Return 1
;	IfWinActive,ahk_class Xming X
;		Return 1
;	IfWinActive,ahk_class SunAwtFrame
;		Return 1
;	IfWinActive,ahk_class Emacs ;NTEmacs
;		Return 1  
;	IfWinActive,ahk_class XEmacs ;Cygwin上のXEmacs
;		Return 1
	Return 0
}

delete_char()
{
	Send {Del}
	global is_pre_spc = 0
	Return
}
delete_backward_char()
{
	Send {BS}
	global is_pre_spc = 0
	Return
}
kill_line()
{
	Send {ShiftDown}{END}{SHIFTUP}
	Sleep 10 ;[ms]
	Send ^x
	global is_pre_spc = 0
	Return
}
open_line()
{
	Send {END}{Enter}{Up}
	global is_pre_spc = 0
	Return
}
quit()
{
	Send {ESC}
	global is_pre_spc = 0
	Return
}
newline()
{
	Send {Enter}
	global is_pre_spc = 0
	Return
}
indent_for_tab_command()
{
	Send {Tab}
	global is_pre_spc = 0
	Return
}
newline_and_indent()
{
	Send {Enter}{Tab}
	global is_pre_spc = 0
	Return
}
isearch_forward()
{
	Send ^f
	global is_pre_spc = 0
	Return
}
isearch_backward()
{
	Send ^f
	global is_pre_spc = 0
	Return
}
kill_region()
{
	Send ^x
	global is_pre_spc = 0
	Return
}
kill_ring_save()
{
	Send ^c
	global is_pre_spc = 0
	Return
}
yank()
{
	Send ^v
	global is_pre_spc = 0
	Return
}
undo()
{
	Send ^z
	global is_pre_spc = 0
	Return
}
find_file()
{
	Send ^o
	global is_pre_x = 0
	Return
}
save_buffer()
{
	Send, ^s
	global is_pre_x = 0
	Return
}
kill_emacs()
{
	Send !{F4}
	global is_pre_x = 0
	Return
}
 
move_beginning_of_line()
{
	global
	if is_pre_spc
		Send +{HOME}
	Else
		Send {HOME}
	Return
}
move_end_of_line()
{
	global
	if is_pre_spc
		Send +{END}
	Else
		Send {END}
	Return
}
previous_line()
{
	global
	if is_pre_spc
		Send +{Up}
	Else
		Send {Up}
	Return
}
next_line()
{
	global
	if is_pre_spc
		Send +{Down}
	Else
		Send {Down}
	Return
}
forward_char()
{
	global
	if is_pre_spc
		Send +{Right}
	Else
		Send {Right}
	Return
}
backward_char()
{
	global
	if is_pre_spc
		Send +{Left} 
	Else
		Send {Left}
	Return
}
scroll_up()
{
	global
	if is_pre_spc
		Send +{PgUp}
	Else
		Send {PgUp}
	Return
}
scroll_down()
{
	global
	if is_pre_spc
		Send +{PgDn}
	Else
		Send {PgDn}
	Return
}
 
 
vk1Dsc07B & x::
	If is_target()
		Send ^x
	Else
		is_pre_x = 1
	Return 
vk1Dsc07B & f::
	If is_target()
		Send ^f
	Else
	{
		If is_pre_x
		find_file()
		Else
		forward_char()
	}
	Return  
vk1Dsc07B & c::
	If is_target()
		Send ^c
	Else
	{
		If is_pre_x
		kill_emacs()
	}
	Return  
vk1Dsc07B & d::
	If is_target()
		Send ^d
	Else
		delete_char()
	Return
vk1Dsc07B & h::
	If is_target()
		Send ^h
	Else
		delete_backward_char()
	Return
vk1Dsc07B & k::
	If is_target()
		Send ^k
	Else
		kill_line()
	Return
vk1Dsc07B & o::
	If is_target()
		Send ^o
	Else
		open_line()
	Return
vk1Dsc07B & g::
	If is_target()
		Send ^g
	Else
		quit()
	Return
vk1Dsc07B & j::
	If is_target()
		Send ^j
	Else
		newline()
	Return
vk1Dsc07B & m::
	If is_target()
		Send ^m
	Else
		newline()
	Return
vk1Dsc07B & i::
	If is_target()
		Send ^i
	Else
		indent_for_tab_command()
	Return
vk1Dsc07B & s::
	If is_target()
		Send ^s
	Else
	{
		If is_pre_x
			save_buffer()
		Else
			isearch_forward()
	}
	Return
vk1Dsc07B & r::
	If is_target()
		Send ^r
	Else
		isearch_backward()
	Return
vk1Dsc07B & w::
	If is_target()
		Send ^w
	Else
		kill_region()
	Return
!w::
	If is_target()
		Send %A_ThisHotkey%
	Else
		kill_ring_save()
	Return
vk1Dsc07B & y::
	If is_target()
		Send ^y
	Else
		yank()
	Return
vk1Dsc07B & /::
	If is_target()
		Send ^/
	Else
		undo()
	Return
 
;$^{Space}::
vk1Dsc07B & vk20sc039::
	If is_target()
		Send {CtrlDown}{Space}{CtrlUp}
	Else
	{
		If is_pre_spc
			is_pre_spc = 0
		Else
			is_pre_spc = 1
	}
	Return
vk1Dsc07B & @::
	If is_target()
		Send ^@
	Else
	{
		If is_pre_spc
			is_pre_spc = 0
		Else
			is_pre_spc = 1
	}
	Return
vk1Dsc07B & a::
	If is_target()
		Send ^a
	Else
		move_beginning_of_line()
	Return
vk1Dsc07B & e::
	If is_target()
		Send ^e
	Else
		move_end_of_line()
	Return
vk1Dsc07B & p::
	If is_target()
		Send ^p
	Else
		previous_line()
	Return
vk1Dsc07B & n::
	If is_target()
		Send ^n
	Else
		next_line()
	Return
vk1Dsc07B & b::
	If is_target()
		Send ^b
	Else
		backward_char()
	Return
vk1Dsc07B & v::
	If is_target()
		Send ^v
	Else
		scroll_down()
	Return
vk1Dsc07B & l::
	If is_target()
		Send ^l
	Return
!v::
	If is_target()
		Send %A_ThisHotkey%
	Else
		scroll_up()
	Return