unit ObjectAsPropertyLeaked;


interface
uses
  System.Classes, Generics.Collections, System.SysUtils;

type
  TPerson = class
  private
    fName: string;
    fDOB: TDate;
  public
    property Name: string read fName write fName;
    property DOB: TDate read fDOB write fDOB;
    constructor Create(Name : string; DOB : TDate);
  end;

  TPersonArray = array of TPerson;

  THouse= class
  private
    fOwners : TPersonArray;
    fResidents: TPersonArray;
    fOwnObjects: boolean;
    fAddress: string;
  public
    property Address : string read fAddress write fAddress;
    property Owners : TPersonArray read fOwners;
    property Residents : TPersonArray read fResidents;

    function getAllPeople : TList<TPerson>;
    class function execute : boolean;

    constructor Create(const address: string; owners: TPersonArray; residents: TPersonArray; const OwnObjects: boolean);
    destructor Destroy; override;
  end;

implementation

{ THouse }

constructor THouse.Create(const address: string; owners: TPersonArray; residents: TPersonArray; const OwnObjects: boolean);
begin
  fAddress := address;
  fOwners := owners;
  fResidents := residents;
  fOwnObjects := OwnObjects;
end;

destructor THouse.Destroy;
var
  person : TPerson;
begin
  if fOwnObjects then
  begin
    for person in fOwners do
      person.Free;

    for person in fResidents do
      person.Free;
  end;

  inherited;
end;

class function THouse.execute: boolean;
var
  p1, p2, p3, p4, p5 : TPerson;
  House1, House2 : THouse;
begin
  p1 := TPerson.Create('P1', StrToDate('1/1/2000'));
  p2 := TPerson.Create('P2', StrToDate('2/2/2000'));
  p3 := TPerson.Create('P3', StrToDate('3/3/2000'));
  p4 := TPerson.Create('P4', StrToDate('4/4/2000'));
  p5 := TPerson.Create('P5', StrToDate('5/5/2000'));

  // p1 owns 2 house1 & house2.
  House1 := THouse.Create('address1', [p1], [p2, p3], true);
  House2 := THouse.Create('address2', [p1], [p1, p4, p5], true);

  // do some logic

  House1.Free;
  House2.Free;
  Result := True;
end;

// returns a list of distinct people from the lists of owners and renters
function THouse.getAllPeople: TList<TPerson>;
var
  person : TPerson;
begin
  result := TList<TPerson>.Create;

  for person in fOwners do
    if (result.IndexOf(person) < 0) then
      result.Add(person);

  for person in fResidents do
    if (result.IndexOf(person) < 0) then
      result.Add(person);
end;

{ TPerson }

constructor TPerson.Create(Name: string; DOB: TDate);
begin
  fName := Name;
  fDOB := DOB;
end;

end.
