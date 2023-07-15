unit ObjectAsPropertyIObj;

interface
uses
  PersonClass, LN.Obj, LN.ObjList, System.Classes, Generics.Collections, System.SysUtils;

type
  THouse= class(TComponent)
  private
    fOwners : TObjArray<TPerson>;
    fResidents: TObjArray<TPerson>;
    fAddress: string;

    function getOwners: TArray<TPerson>;
    function getResidents: TArray<TPerson>;
  public
    property Address : string read fAddress write fAddress;
    property Owners : TArray<TPerson> read getOwners;
    property Residents : TArray<TPerson> read getResidents;

    function getAllPeople : IObj<TObjList<TPerson>>;
    class procedure execute(callback : TProc<THouse>);

    constructor Create(const address: string; owners, residents: TObjArray<TPerson>); reintroduce;
  end;

implementation

{ THouse }

constructor THouse.Create(const address: string; owners, residents: TObjArray<TPerson>);
begin
  fAddress := address;
  fOwners := owners;
  fResidents := residents;
end;

class procedure THouse.execute(callback : TProc<THouse>);
var
  pArray : TObjArray<TPerson>;
  house1, house2 : IObj<THouse>;
begin
  pArray := TObjList.ToObjArray<TPerson>(TPerson.createPersonList);

  // p1 owns 2 house1 & house2.
  house1 := TObj.Create(THouse.Create('address1', [pArray[0]], [pArray[1], pArray[2]]));
  house2 := TObj.Create(THouse.Create('address2', [pArray[0]], [pArray[0], pArray[3], pArray[4]]));

  // do some logic
  if assigned(callback) then
  begin
    callback(house1.Obj);
    callback(house2.Obj);
  end;
end;

function THouse.getOwners: TArray<TPerson>;
begin
  result := TObjList.ToArray<TPerson>(fOwners);
end;

function THouse.getResidents: TArray<TPerson>;
begin
  result := TObjList.ToArray<TPerson>(fResidents);
end;

// returns a list of distinct people from the lists of owners and renters
function THouse.getAllPeople: IObj<TObjList<TPerson>>;
var
  person : IObj<TPerson>;
begin
  result := TObj.Create(TObjList<TPerson>.Create);

  for person in fOwners do
    if (result.Obj.IndexOf(person) < 0) then
      result.Obj.Add(person);

  for person in fResidents do
    if (result.Obj.IndexOf(person) < 0) then
      result.Obj.Add(person);
end;

end.
