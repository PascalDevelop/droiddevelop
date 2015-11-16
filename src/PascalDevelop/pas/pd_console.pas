{*********************************************************************
 * PascalDevelop activater                                           *
 * Written by Jonathan A. Foster <jon@jfpossibilities.com>           *
 * Started October 26th, 2015                                        *
 * Copyright JF Possibilities, Inc. Released under the As Soft       *
 * license.                                                          *
 *                                                                   *
 * This activates the console window in PascalDevelop by sending the *
 * string 'console', immediately upon startup. It also forces buffer *
 * flushing with every write so that results are sent immediately.   *
 *********************************************************************}
{$mode objfpc}
unit pd_console;
interface
implementation
uses SysUtils; // defines TTextRec
type
    TIOfunc = function(var Text: TTextRec): Integer;



var
    OldIO, OldFlush: TIOfunc;



function NewIO(var Text: TTextRec): Integer;
begin
    result:=OldIO(Text);
    if assigned(OldFlush) then OldFlush(Text);
end;



function NewFlush(var Text: TTextRec): Integer;
begin
    result:=OldIO(Text);
    if assigned(OldFlush) then result:=OldFlush(Text);
end;



initialization
     OldIO:=TIOfunc(TTextRec(Output).InOutFunc);
  OldFlush:=TIOfunc(TTextRec(Output).FlushFunc);
  TTextRec(Output).InOutFunc:=@NewIO;
  TTextRec(Output).FlushFunc:=@NewFlush;
  write('console'); // activate the PascalDevelop console window.
end.
