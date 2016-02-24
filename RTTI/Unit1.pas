unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TESTE = class of TTeste;

  TTeste = class(TPersistent)
    strict private
      palavra: string;
    public
      procedure Mensagem;
      constructor Create(APalavra: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function CriaForm(const NomeForm: string): TForm;
var
  TClasse : TPersistentClass;
begin
  Result := nil;
  TClasse := GetClass(NomeForm);
  if (TClasse <> nil) then //and TClasse.InheritsFrom(TForm) then
  //para qualquer item criado � necessario ter uma referencia (ex: TFormClass) para criar o objeto, se n�o, estoura exce��o.
    Result := TFormClass(TClasse).Create(nil);
end;

function CriaTeste(const NomeForm: string): TTeste;
var
  TClasse : TPersistentClass;
begin
  Result := nil;
  TClasse := GetClass(NomeForm);
  if (TClasse <> nil) then //and TClasse.InheritsFrom(TForm) then
  begin
////    Result := TClasse.NewInstance as TTeste; // N�o precisa da definicao class of (TESTE = class of TTeste;) mas n�o funciona com construtor com parametros
    Result := TESTE(TClasse).Create('oi');
  end;
end;

procedure TForm1.btn1Click(Sender: TObject);
//var
//  control : TClass;           //classe base para cria��o
//  f: TForm;
//begin
//  RegisterClasses([TForm]);
//  control := GetClass(TForm.ClassName);
//  if Assigned(control) then
//  begin
////          if control.InheritsFrom(TfrmRede) then
//    begin
//      f := TForm(control).Create(nil); //Esta estourando exce��o aqui!!! Verificar o porque!!!
//      if Assigned(f) then
//      begin
//        f.Show;
//        FreeAndNil(f);
//      end;
//    end;
//  end;
var
Form : TForm;
begin
  Form := CriaForm('TForm');
  if not Assigned(Form) then
    MessageDlg('Form n�o registrado!', mtError, [mbOK], 0)
  else
  begin
    Form.ShowModal;
    Form.Free;
  end;
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  Form : TTeste;
begin
  Form := CriaTeste('TTeste');
  if not Assigned(Form) then
    MessageDlg('Form n�o registrado!', mtError, [mbOK], 0)
  else
  begin
    Form.Mensagem;
    Form.Free;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  RegisterClasses([TForm, TTeste]);
//    RegisterClass(TForm); // Espero que seu form n�o chame Form2
end;

{ TTeste }

constructor TTeste.Create(APalavra: string);
begin
  palavra := APalavra;
  palavra := palavra + palavra;
end;

procedure TTeste.Mensagem;
begin
  ShowMessage('TESTE ' +  palavra);
end;

end.
