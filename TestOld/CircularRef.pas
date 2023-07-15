unit CircularRef;

interface
uses
  LN.Obj, classes;

// Not being sexist .. just want to demonstrate the circular reference issue.

type
  TBPerson = class(TBObj)
  public
    Name : string;
    constructor Create(Name : string);
  end;

  TWoman = class;
  TMan = class(TBPerson)
  private
    FPartnerObj: IObj;
    FPartner : TWoman;

    function getPartner: TWoman;
    procedure setPartner(const Value: TWoman);
  public
    property Partner : TWoman read getPartner write setPartner;
  end;

  TWoman = class(TBPerson)
  private
    FPartnerObj: IObj;
    FPartner : TMan;

    function getPartner: TMan;
    procedure setPartner(const Value: TMan);
  public
    property Partner : TMan read getPartner write setPartner;
  end;

  TCouples = class
  private
    fPersonListObj : IObj;
    fPersonList : TList;

    procedure createPersonList;
    procedure populatePersonList;
  public
    constructor Create;
    procedure execute;
  end;



implementation


{ TMan }

function TMan.getPartner: TWoman;
begin
  result := FPartner;
end;

procedure TMan.setPartner(const Value: TWoman);
begin
  FPartner := Value;
  FPartnerObj := TObj.Create(FPartner);
end;

{ TWoman }

function TWoman.getPartner: TMan;
begin
  result := FPartner;
end;

procedure TWoman.setPartner(const Value: TMan);
begin
  FPartner := Value;
  FPartnerObj := TObj.Create(FPartner);
end;


{ TCouples }

constructor TCouples.Create;
begin
  createPersonList;
end;

procedure TCouples.createPersonList;
begin
  fPersonList := TList.Create;
  fPersonListObj := TObj.create(fPersonList);
end;

procedure TCouples.execute;
begin
  populatePersonList;
end;

procedure TCouples.populatePersonList;
var
  m1, m2, m3 : IObj;
  w1, w2, w3 : IObj;
begin
  fPersonList.clear;

  m1 := TObj.Create(TMan.Create('Man 1'));
  m2 := TObj.Create(TMan.Create('Man 1'));
  m3 := TObj.Create(TMan.Create('Man 1'));

  w1 := TObj.Create(TWoman.Create('Woman 1'));
  w2 := TObj.Create(TWoman.Create('Woman 2'));
  w3 := TObj.Create(TWoman.Create('Woman 3'));

  TMan(m1.Obj).Partner := TWoman(w1.Obj);
  TMan(m2.Obj).Partner := TWoman(w2.Obj);
  TMan(m3.Obj).Partner := TWoman(w3.Obj);

  TWoman(w1.Obj).Partner := TMan(m1.Obj);
  TWoman(w2.Obj).Partner := TMan(m2.Obj);
  TWoman(w3.Obj).Partner := TMan(m3.Obj);

  fPersonList.add(TObj.Create(TBPerson(m1.Obj)));
  fPersonList.add(TObj.Create(TBPerson(w1.Obj)));
  fPersonList.add(TObj.Create(TBPerson(m2.Obj)));
  fPersonList.add(TObj.Create(TBPerson(w2.Obj)));
  fPersonList.add(TObj.Create(TBPerson(m3.Obj)));
  fPersonList.add(TObj.Create(TBPerson(w3.Obj)));

end;

{ TBPerson }

constructor TBPerson.Create(Name: string);
begin
  self.Name := Name;
end;

end.
