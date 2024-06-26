namespace AsignarSaldos
{
    public static class Credentials
    {
        public static string SPName { get; set; } = "AsignarSaldos";
        public static string DBName { get; set; } = "AsignacionesGestores";
        public static string StringConnection { get; set; } = $"Server=.;Database={DBName}; Trusted_Connection=SSPI; Trust Server Certificate=true;";

    }
}