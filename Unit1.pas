unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Panel1: TPanel;
    Button21: TButton;
    Button22: TButton;
    Button24: TButton;
    Button23: TButton;
    Button31: TButton;
    Button32: TButton;
    Button33: TButton;
    Button34: TButton;
    Button41: TButton;
    Button42: TButton;
    Button43: TButton;
    Button44: TButton;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Swap(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateTable;
    procedure Restart;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure CheckTable;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

var
  table: array[1..4,1..4] of Integer;
  checkFlag: boolean;
  num: Integer;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Restart
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  CreateTable
end;

procedure TForm1.CheckTable;
var 
  i, j, n: Integer;
begin
  if num = 0 then Exit;
  n := 0;

  for i := 1 to 4 do
   for j := 1 to 4 do begin
     Inc(n);
     if table[i,j] <> n then Exit;
   end;

  if Dialogs.MessageDlg('Игра закончена за ' + IntToStr(num) + ' ходов. Начать заново?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes
  then Restart else num := 0;
end;

procedure TForm1.CreateTable;
var 
  i, j, n: Integer;
begin
  n := 0;
  num := 0;
  CheckFlag := true;

  for i := 1 to 4 do
   for j := 1 to 4 do begin
     Inc(n);
     table[i,j] := n;
     TButton(FindComponent('Button' + IntToStr(i) + IntToStr(j))).Caption := IntToStr(n);

     if n = 16 then TButton(FindComponent('Button' + IntToStr(i) + IntToStr(j))).Visible := false
     else TButton(FindComponent('Button' + IntToStr(i) + IntToStr(j))).Visible := true;
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BorderIcons:= BorderIcons - [bimaximize];
  CreateTable
end;

procedure TForm1.Restart;
var 
  i: Integer;
begin
  Randomize;
  num := 0;

  CheckFlag := false;

  for i := 1 to Random(1500)+1 do
    TButton(FindComponent('Button' + IntToStr(Random(4)+1) + IntToStr(Random(4)+1))).Click;

  CheckFlag := true;
end;

procedure TForm1.Swap(Sender: TObject);
var 
  i, j, id: Integer;
  stop: boolean;
begin
  stop := false;

  for i := 1 to 4 do begin
    if stop then break;

    for j := 1 to 4 do begin

      if Sender = TButton(FindComponent('Button' + IntToStr(i) + IntToStr(j))) then begin

        id := table[i,j];
        if id = 16 then Exit;

        if (table[i+1,j] = 16) or (table[i,j+1] = 16) or (table[i-1,j] = 16) or (table[i,j-1] = 16) then  begin

          if (table[i+1,j] = 16) then begin
            if i+1 = 5 then Exit;

            table[i+1,j] := id;
            TButton(FindComponent('Button' + IntToStr(i+1) + IntToStr(j))).Caption := IntToStr(id);
            TButton(FindComponent('Button' + IntToStr(i+1) + IntToStr(j))).Visible := true;
          end;

          if (table[i,j+1] = 16) then begin
            if j + 1 = 5 then Exit;

            table[i,j+1] := id;
            TButton(FindComponent('Button' + IntToStr(i) + IntToStr(j+1))).Caption := IntToStr(id);
            TButton(FindComponent('Button' + IntToStr(i) + IntToStr(j+1))).Visible := true;;
          end;

          if (table[i-1,j] = 16) then begin
            if i - 1 = 0 then Exit;

            table[i-1,j] := id;
            TButton(FindComponent('Button' + IntToStr(i-1) + IntToStr(j))).Caption := IntToStr(id);
            TButton(FindComponent('Button' + IntToStr(i-1) + IntToStr(j))).Visible := true;
          end;

          if (table[i,j-1] = 16) then begin
            if j - 1 = 0 then Exit;

            table[i,j-1] := id;
            TButton(FindComponent('Button' + IntToStr(i) + IntToStr(j-1))).Caption := IntToStr(id);
            TButton(FindComponent('Button' + IntToStr(i) + IntToStr(j-1))).Visible := true;
          end;

          table[i,j] := 16;
          TButton(FindComponent('Button' + IntToStr(i) + IntToStr(j))).Visible := false;

          Inc(num);
          if CheckFlag then CheckTable;

          stop := true;
          break;
        end;
      end;
    end;
  end;

end;
end.