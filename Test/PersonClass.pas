unit PersonClass;

interface
uses
  System.Classes, LN.Obj, System.SysUtils;

type
  TPerson = class
  private
    fName: string;
    fDOB: TDate;
  public
    property Name: string read fName write fName;
    property DOB: TDate read fDOB write fDOB;
    constructor Create(Name : string; DOB : TDate);
    class function getNames(lst: TArray<TPerson>): string;
    class function createPersonList : TArray<TPerson>;
  end;

implementation

{ TPerson }
constructor TPerson.Create(Name: string; DOB: TDate);
begin
  fName := Name;
  fDOB := DOB;
end;

class function TPerson.getNames(lst: TArray<TPerson>): string;
var
  person : TPerson;
begin
  result := '';
  for person in lst do
  begin
    if result = '' then
      result := person.Name
    else
      result := result + ', ' + person.Name;
  end;
end;

class function TPerson.createPersonList: TArray<TPerson>;
begin
  setLength(result, 5);

  result[0] := TPerson.Create('P1', StrToDate('1/1/2000'));
  result[1] := TPerson.Create('P2', StrToDate('2/2/2000'));
  result[2] := TPerson.Create('P3', StrToDate('3/3/2000'));
  result[3] := TPerson.Create('P4', StrToDate('4/4/2000'));
  result[4] := TPerson.Create('P5', StrToDate('5/5/2000'));
end;

end.
