using System.Data;
using Microsoft.Data.SqlClient;

namespace AsignarSaldos
{
    public static class Connection
    {
        public static string ExecuteSP(string NameSP)
        {
            try
            {
                using (SqlConnection connection = new(Credentials.StringConnection))
                {
                    connection.Open();
                    Console.WriteLine("Conexión a la base de datos establecida.");

                    Console.WriteLine("Ejecutando SP...");
                    using SqlCommand command = new(NameSP, connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.ExecuteNonQuery();
                    return "Saldos asignados correctamente.";
                }
            }
            catch (SqlException ex)
            {
                return "Se produjo un error de SQL: " + ex.Message;
            }
            catch (Exception ex)
            {
                return "Se produjo un error: " + ex.Message;
            }
        }

    }
}