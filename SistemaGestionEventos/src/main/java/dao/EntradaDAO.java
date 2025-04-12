package dao;
import java.sql.*;
import java.util.ArrayList;

import conector.Conexion;
import modelo.Entrada;

public class EntradaDAO {
	public boolean nueva(Entrada e) {
        Connection connection = null;
        PreparedStatement ps = null;
        Conexion cn = new Conexion();

        try {
            connection = cn.getConnection();
            String sql = "INSERT INTO entrada (id_evento,id_asistente, fecha_compra, metodo_pago) VALUES (?, ?, ?,?)";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, e.getIdEvento());
            ps.setInt(2, e.getIdAsistente());
            ps.setDate(3, new Date(e.getFechaCompra().getTime()));
            ps.setString(4, e.getMetodoPago());

            int filaInsertada = ps.executeUpdate();
            return filaInsertada > 0;
        } catch (SQLException ex) {
            System.out.println("Error al registrar entrada: " + ex.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            }
        }
        return false;
    }

    public ArrayList<Entrada> listar() {
        ArrayList<Entrada> lista = new ArrayList<>();
        Conexion cn = new Conexion();
        Connection connection = cn.getConnection();
        Statement statement = null;
        ResultSet rs = null;

        try {
            statement = connection.createStatement();
            String sql = "SELECT en.id_entrada, en.id_evento,en.id_asistente, en.fecha_compra, en.metodo_pago, " +
                         "ev.nombre AS evento, a.nombre AS asistente " +
                         "FROM entrada en " +
                         "INNER JOIN evento ev ON en.id_evento = ev.id_evento " +
                         "INNER JOIN asistente a ON en.id_asistente = a.id_asistente";

            rs = statement.executeQuery(sql);

            while (rs.next()) {
                Entrada entrada = new Entrada();
                entrada.setIdEntrada(rs.getInt("id_entrada"));
                entrada.setIdAsistente(rs.getInt("id_asistente"));
                entrada.setIdEvento(rs.getInt("id_evento"));
                entrada.setFechaCompra(rs.getDate("fecha_compra"));
                entrada.setMetodoPago(rs.getString("metodo_pago"));
                entrada.setNombreEvento(rs.getString("evento"));
                entrada.setNombreAsistente(rs.getString("asistente"));

                lista.add(entrada);
            }
        } catch (SQLException ex) {
            System.out.println("Error al listar entradas: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            }
        }
        return lista;
    }

    public Entrada buscarUno(int idEntrada) {
        Conexion cn = new Conexion();
        Connection connection = cn.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        Entrada entrada = null;

        try {
            String sql = "SELECT en.id_entrada, en.id_evento,en.id_asistente, en.fecha_compra, en.metodo_pago, " +
                         "ev.nombre AS evento, a.nombre AS asistente " +
                         "FROM entrada en " +
                         "INNER JOIN evento ev ON en.id_evento = ev.id_evento " +
                         "INNER JOIN asistente a ON en.id_asistente = a.id_asistente " +
                         "WHERE en.id_entrada = ?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, idEntrada);
            rs = ps.executeQuery();

            if (rs.next()) {
                entrada = new Entrada();
                entrada.setIdEntrada(rs.getInt("id_entrada"));
                entrada.setIdAsistente(rs.getInt("id_asistente"));
                entrada.setIdEvento(rs.getInt("id_evento"));
                entrada.setFechaCompra(rs.getDate("fecha_compra"));
                entrada.setMetodoPago(rs.getString("metodo_pago"));
                entrada.setNombreEvento(rs.getString("evento"));
                entrada.setNombreAsistente(rs.getString("asistente"));
            }
        } catch (SQLException ex) {
            System.out.println("Error al buscar entrada: " + ex.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (rs != null) rs.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            }
        }
        return entrada;
    }

    public boolean actualizar(Entrada entrada) {
        Connection connection = null;
        PreparedStatement ps = null;
        Conexion cn = new Conexion();

        try {
            connection = cn.getConnection();
            String sql = "UPDATE entrada SET id_evento=?,id_asistente=?, fecha_compra=?, metodo_pago=? WHERE id_entrada=?";
            ps = connection.prepareStatement(sql);

            ps.setInt(1, entrada.getIdEvento());
            ps.setInt(2, entrada.getIdAsistente());
            ps.setDate(3, new Date(entrada.getFechaCompra().getTime()));
            ps.setString(4, entrada.getMetodoPago());
            ps.setInt(5, entrada.getIdEntrada());

            int filasActualizadas = ps.executeUpdate();
            return filasActualizadas > 0;
        } catch (SQLException ex) {
            System.out.println("Error al actualizar entrada: " + ex.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                System.out.println("Error al cerrar conexión: " + ex.getMessage());
            }
        }
        return false;
    }

    public boolean eliminar(int idEntrada) {
        Connection connection = null;
        PreparedStatement ps = null;
        Conexion cn = new Conexion();

        try {
            connection = cn.getConnection();
            String sql = "DELETE FROM entrada WHERE id_entrada = ?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, idEntrada);

            int filaEliminada = ps.executeUpdate();
            return filaEliminada > 0;
        } catch (SQLException ex) {
            System.out.println("Error al eliminar entrada: " + ex.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            }
        }
        return false;
    }
}
