program IObjTestOld;

{$R 'ResourceFiles.res' 'ResourceFiles.rc'}

uses
  Vcl.Forms,
  IObjTestMain in 'IObjTestMain.pas' {frmIObjTestMain},
  LocalVars in 'LocalVars.pas',
  MyClassIObj in 'MyClassIObj.pas',
  MyClassLeaked in 'MyClassLeaked.pas',
  MyClassStandard in 'MyClassStandard.pas',
  ObjectAsPropertyIObj in 'ObjectAsPropertyIObj.pas',
  ObjectAsPropertyLeaked in 'ObjectAsPropertyLeaked.pas',
  ObjectAsPropertyStandard in 'ObjectAsPropertyStandard.pas',
  LN.Obj in '..\LN.Obj.pas',
  CircularRef in 'CircularRef.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmIObjTestMain, frmIObjTestMain);
  Application.Run;
end.
