/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author oditr
 */
    

public class koneksi {
    private static Connection koneksi;
    
    public static Connection getConnection()
    {
        if (koneksi == null)
        {
            try
            {
                String url = "jdbc:mysql://localhost:3306/ojek_online";
                String user = "root";
                String password = "";
                
                DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                koneksi = DriverManager.getConnection(url, user, password);
                System.out.println("Berhasil");
            }
            catch (Exception e)
            {
                System.out.println("Koneksi ke Database Gagal : " + e.getMessage());
            }
        }
        return koneksi;
    }
}
