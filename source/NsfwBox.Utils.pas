﻿unit NsfwBox.Utils;

interface

uses
  Classes, SysUtils, System.Generics.Collections, System.IOUtils,
  NsfwBox.Logging, XSuperObject;

type
  PInterface = ^IInterface;

  TJsonHelper = Class
    public
      class function ReadIntArray(const ASource: ISuperObject; AKeyName: string): TArray<Int64>; static;
      class function ReadNativeIntArray(const ASource: ISuperObject; AKeyName: string): TArray<NativeInt>; static;
  end;

  TArrayHelper = Class
    public
      ///<summary>Returns new array with values by given indexes.</summary>
      class function PickValues<T>(const Ar: TArray<T>; AIndexes: TArray<integer>): TArray<T>; static;
  End;

  function GetFirstStr(Ar: TArray<string>): string;
  function StrIn(const Ar: TArray<string>; AStr: string; AIgnoreCase: boolean = True): boolean;
  function BytesCountToSizeStr(ABytesCount: int64): string;
  function GetPercents(AFull, APiece: Real): integer;
  function GetThumbByFileExt(const AFilename: string): string;

  ///<summary>FreeAndNil for interfaced objects without reference counting.</summary>
  procedure FreeInterfaced(const [ref] AObject: IInterface);

  

implementation
uses Unit1, NsfwBox.Styling;

procedure FreeInterfaced(const [ref] AObject: IInterface);
var
  LTmp: TObject;
begin
  try
    LTmp := AObject As TObject;
    FreeAndNil(LTmp);
    TObject(Pointer(@AObject)^) := nil;
  except
    On E: Exception do Log('Utils.FreeInterfaced', E);
  end;
end;

function BytesCountToSizeStr(ABytesCount: int64): string;
const
  UNITS: Tarray<string> = ['Kb', 'Mb', 'Gb'];
var
  I: integer;
  LValue: int64;
begin
  LValue := ABytesCount;
  for I := 0 to High(UNITS) do begin
    LValue := Round(LValue / 1024);
    if LValue < 1024 then
      Break;
  end;
  Result := LValue.ToString + ' ' + UNITS[I];
end;

function GetPercents(AFull, APiece: Real): integer;
var
  X: Real;
begin
  Result := 0;
  try
    if AFull > 0 then begin
      X := AFull / 100;
      Result := Round(APiece / X);
      if Result > 100 then Result := 100;
    end;
  except
    On E: Exception do begin
      Log('GetPercents', E);
    end;
  end;
end;

function GetFirstStr(Ar: TArray<string>): string;
begin
  if Length(Ar) > 0 then
    Result := Ar[0]
  else
    Result := '';
end;

function StrIn(const Ar: TArray<string>; AStr: string; AIgnoreCase: boolean): boolean;
var
  I: integer;
begin
  Result := False;
  for I := 0 to High(Ar) do begin
    if AIgnoreCase then
      Result := (UpperCase(Ar[I]) = UpperCase(AStr))
    else
      Result := (Ar[I] = AStr);

    if Result then Exit;
  end;
end;

function GetThumbByFileExt(const AFilename: string): string;
const
  VIDEO: TArray<string> = ['.m4v', '.mp4', '.webm'];
  AUDIO: TArray<string> = ['.mp3', '.m4a', '.ogg', '.wav'];
var
  LExt: string;
begin
  LExt := TPath.GetExtension(AFilename);
  if StrIn(VIDEO, LExt, True) then
    Result := Form1.AppStyle.GetImagePath(IMAGE_DUMMY_VIDEO)
  else if StrIn(AUDIO, LExt, True) then
    Result := Form1.AppStyle.GetImagePath(IMAGE_DUMMY_AUDIO)
  else
    Result := Form1.AppStyle.GetImagePath(IMAGE_LOADING);
end;

{ TJsonHelper }

class function TJsonHelper.ReadIntArray(const ASource: ISuperObject;
  AKeyName: string): TArray<Int64>;
var
  I: integer;
begin
  if ASource.Null[AKeyName] = jAssigned then
  begin
    var Ar: ISuperArray := ASource.A[AKeyName];
    SetLength(Result, Ar.Length);
    for I := 0 to High(Result) do
      Result[I] := Ar.I[I];
  end else
    Result := Nil;
end;

class function TJsonHelper.ReadNativeIntArray(const ASource: ISuperObject;
  AKeyName: string): TArray<NativeInt>;
var
  I: integer;
begin
  if ASource.Null[AKeyName] = jAssigned then
  begin
    var Ar: ISuperArray := ASource.A[AKeyName];
    SetLength(Result, Ar.Length);
    for I := 0 to High(Result) do
      Result[I] := Ar.I[I];
  end else
    Result := Nil;
end;

{ TArrayHelper }

class function TArrayHelper.PickValues<T>(const Ar: TArray<T>;
  AIndexes: TArray<integer>): TArray<T>;
var
  I, Len, Pos: integer;
begin
  Result := [];
  Len := Length(Ar);
  if Len = 0 then Exit;
  for I := Low(AIndexes) to High(AIndexes) do
  begin
    if (Len > AIndexes[I]) and (AIndexes[I] >= 0) then
    begin
      Pos := Length(Result);
      SetLength(Result, Pos + 1);
      Result[Pos] := Ar[AIndexes[I]];
    end;
  end;
end;

end.
