program Integral_double;

uses
  Forms,
  Integral in 'Integral.pas' {Form1},
  mainfrm in 'mainfrm.pas' {FrmDataVis};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFrmDataVis, FrmDataVis);
  Application.Run;
end.
