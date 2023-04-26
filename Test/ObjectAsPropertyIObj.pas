unit ObjectAsPropertyIObj;
{ Note:
  - THouse's destructor is no longer required
  - Change all TPerson references to IPerson, ie IObj<TPerson>
  - Change TList<TPerson> to IObj<TList<IPerson>
  - No need to call House1.free, House2.free
  - THouse's OwnObjects is now redundant
}

interface
uses
  LN.IObj, System.Classes, Generics.Collections, System.SysUtils;

type
  TPerson = class(TComponent)
  private
    fName: string;
    fDOB: TDate;
  public
    property Name: string read fName write fName;
    property DOB: TDate read fDOB write fDOB;
    constructor Create(Name : string; DOB : TDate); reintroduce;
  end;
  IPerson = IObj<TPerson>;

  TPersonArray = array of IPerson;
  IListPerson = IObj<TList<IPerson>>;

  THouse= class(TComponent)
  private
    fOwners : TPersonArray;
    fResidents: TPersonArray;
    fOwnObjects: boolean;
    fAddress: string;
  public
    property Address : string read fAddress write fAddress;
    property Owners : TPersonArray read fOwners;
    property Residents : TPersonArray read fResidents;

    function getAllPeople : IListPerson;
    class function execute : boolean;

    constructor Create(const address: string; owners: TPersonArray; residents: TPersonArray; const OwnObjects: boolean); reintroduce;
  end;

implementation

{ THouse }

constructor THouse.Create(const address: string; owners: TPersonArray; residents: TPersonArray; const OwnObjects: boolean);
begin
  inherited Create(nil);

  fAddress := address;
  fOwners := owners;
  fResidents := residents;
  fOwnObjects := OwnObjects;
end;

class function THouse.execute: boolean;
begin
  var p1 := TObj.CreateInstance(TPerson.Create('P1', StrToDate('1/1/2000')));
  var p2 := TObj.CreateInstance(TPerson.Create('P2', StrToDate('2/2/2000')));
  var p3 := TObj.CreateInstance(TPerson.Create('P3', StrToDate('3/3/2000')));
  var p4 := TObj.CreateInstance(TPerson.Create('P4', StrToDate('4/4/2000')));
  var p5 := TObj.CreateInstance(TPerson.Create('P5', StrToDate('5/5/2000')));

  // p1 owns 2 house1 & house2.
  var House1 := TObj.CreateInstance(THouse.Create('address1', [p1], [p2, p3], true));
  var House2 := TObj.CreateInstance(THouse.Create('address2', [p1], [p1, p4, p5], true));

  // do some logic
  Result := True;
end;

// returns a list of distinct people from the lists of owners and renters
function THouse.getAllPeople: IListPerson;
begin
  result := TObj.CreateInstance(TList<IPerson>.Create);

  for var person in fOwners do
    if (result.Obj.IndexOf(person) < 0) then
      result.Obj.Add(person);

  for var person in fResidents do
    if (result.Obj.IndexOf(person) < 0) then
      result.Obj.Add(person);
end;

{ TPerson }

constructor TPerson.Create(Name: string; DOB: TDate);
begin
  inherited Create(nil);
  fName := Name;
  fDOB := DOB;
end;

end.
