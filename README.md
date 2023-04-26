# Delphi-IObj
This library simplifies the way you write Delphi code that can avoid memory leaks

    // declare and instantiate variable of type TMyObject
    var myObj := TObj.CreateInstance(TMyObject.Create);

    // myObj.Obj refers to the created TMyObject
    myObj.Obj

    // You don't need try finally block to free myObj
    // You don't need to free myObj in your class destructor.
