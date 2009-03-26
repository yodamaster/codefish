unit Base64;

interface

function EncodeBase64(Src: string): string;

implementation

function EnCodeBase64(Src: string): string;
const
  DataSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
var
  i, ModLen: integer;
  Current: string;
  Buf: array[1..3] of Byte;
  NewBuf: array[1..4] of Byte;
begin
  result := '';
  if Src = '' then
    exit;
  Src:='Codefish_'+Src+'-guo';
  ModLen := Length(Src) mod 3;
  while Length(Src) > 0 do
  begin
    FillChar(Buf, 3, #0);
    Current := Copy(Src, 1, 3);
    Src := Copy(Src, 4, Length(Src) - 3);
    for i := 1 to 3 do
      Buf[i] := Ord(Current[i]);
    NewBuf[1] := Buf[1] shr 2;
    NewBuf[2] := (Buf[1] shl 6 shr 2 or Buf[2] shr 4) and $3F;
    NewBuf[3] := (Buf[2] shl 4 shr 2 or Buf[3] shr 6) and $3F;
    NewBuf[4] := Buf[3] and $3F;
    for i := 1 to 4 do
      result := result + DataSet[NewBuf[i] + 1];
  end;
  if ModLen >= 1 then
    result[Length(result)] := '=';
  if ModLen = 1 then
    result[Length(result) - 1] := '=';
end;

end.
