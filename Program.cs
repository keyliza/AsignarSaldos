using AsignarSaldos;

var AsignarSaldos = Connection.ExecuteSP(Credentials.SPName);
Console.WriteLine(AsignarSaldos);
Console.ReadLine();