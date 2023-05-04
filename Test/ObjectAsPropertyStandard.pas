unit ObjectAsPropertyStandard;

interface
uses
  PersonClass, System.Classes, Generics.Collections, System.SysUtils;

type
  THouse= class
  private
    fOwners : TArray<TPerson>;
    fResidents: TArray<TPerson>;
    fAddress: string;

    function getOwners: TArray<TPerson>;
    function getResidents: TArray<TPerson>;
  public
    property Address : string read fAddress write fAddress;
    property Owners : TArray<TPerson> read getOwners;
    property Residents : TArray<TPerson> read getResidents;

    function getAllPeople : TList<TPerson>;
    class procedure execute(callback : TProc<THouse>);

    constructor Create(const address: string; owners, residents: TArray<TPerson>);
    destructor Destroy; override;
  end;

implementation

{ THouse }

constructor THouse.Create(const address: string; owners, residents: TArray<TPerson>);
begin
  fAddress := address;
  fOwners := owners;
  fResidents := residents;
end;

destructor THouse.Destroy;
var
  person : TPerson;
  listAll : TList<TPerson>;
begin
  listAll := getAllPeople;
  for person in listAll do
    person.Free;

  listAll.Free;

  inherited;
end;

class procedure THouse.execute(callback : TProc<THouse>);
var
  pArray : TArray<TPerson>;
  house1, house2 : THouse;
begin
  pArray := TPerson.createPersonList;

  // p1 owns 2 house1 & house2.
  house1 := THouse.Create('address1', [pArray[0]], [pArray[1], pArray[2]]);
  house2 := THouse.Create('address2', [pArray[0]], [pArray[0], pArray[3], pArray[4]]);

  // do some logic
  if assigned(callback) then
  begin
    callback(house1);
    callback(house2);
  end;

  house1.Free;
  house2.Free;
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

function THouse.getOwners: TArray<TPerson>;
begin
  result := fOwners;
end;

function THouse.getResidents: TArray<TPerson>;
begin
  result := fResidents;
end;

end.
