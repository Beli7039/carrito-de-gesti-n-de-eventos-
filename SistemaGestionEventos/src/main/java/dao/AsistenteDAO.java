package dao;

import java.sql.*;
import java.util.ArrayList;

import conector.Conexion;
import modelo.Asistente;

public class AsistenteDAO {
	public boolean nuevo(Asistente a) {
        PreparedStatement ps = null;
        Connection connection = null;
        Conexion cn = new Conexion();
        try {
            connection = cn.getConnection();
            String sql = "INSERT INTO asistente (nombre, apellidoP, apellidoM, correo, telefono,contrasenia) VALUES (?, ?, ?, ?, ?,?)";
            ps = connection.prepareStatement(sql);

            ps.setString(1, a.getNombre());
            ps.setString(2, a.getApellidoP());
            ps.setString(3, a.getApellidoM());
            ps.setString(4, a.getCorreo());
            ps.setString(5, a.getTelefono());
            ps.setString(6, a.getContrasenia());

            int filaInsertada = ps.executeUpdate();
            return filaInsertada > 0;
        } catch (SQLException ex) {
            System.out.println("Error al insertar asistente: " + ex.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
            }
        }
        return false;
    }
	
	public Asistente validarInicioSesion(String correo, String contrasenia) {
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    Connection connection = null;
	    Conexion cn = new Conexion();
	    Asistente asistente = null;
	    try {
	        connection = cn.getConnection();
	        String sql = "SELECT id_asistente, nombre, apellidoP, apellidoM, correo, telefono, contrasenia "
	                     + "FROM asistente WHERE correo = ? AND contrasenia = ?";
	        ps = connection.prepareStatement(sql);

	        ps.setString(1, correo);
	        ps.setString(2, contrasenia);

	        rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            asistente = new Asistente();
	            asistente.setIdAsistente(rs.getInt("id_asistente"));
	            asistente.setNombre(rs.getString("nombre"));
	            asistente.setApellidoP(rs.getString("apellidoP"));
	            asistente.setApellidoM(rs.getString("apellidoM"));
	            asistente.setCorreo(rs.getString("correo"));
	            asistente.setTelefono(rs.getString("telefono"));
	            asistente.setContrasenia(rs.getString("contrasenia"));
	        }
	    } catch (SQLException ex) {
	        System.out.println("Error al validar inicio de sesión: " + ex.getMessage());
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (connection != null) connection.close();
	        } catch (SQLException ex) {
	            System.out.println("Error al cerrar los recursos: " + ex.getMessage());
	        }
	    }

	    return asistente;
	}


    public ArrayList<Asistente> listar() {
        ArrayList<Asistente> lista = new ArrayList<>();
        Conexion cn = new Conexion();
        Connection connection = cn.getConnection();
        Asistente asistente;
        Statement statement = null;
        ResultSet rs = null;
        try {
            statement = connection.createStatement();
            String sql = "SELECT id_asistente, nombre, apellidoP, apellidoM, correo, telefono FROM asistente";
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                asistente = new Asistente();
                asistente.setIdAsistente(rs.getInt("id_asistente"));
                asistente.setNombre(rs.getString("nombre"));
                asistente.setApellidoP(rs.getString("apellidoP"));
                asistente.setApellidoM(rs.getString("apellidoM"));
                asistente.setCorreo(rs.getString("correo"));
                asistente.setTelefono(rs.getString("telefono"));

                lista.add(asistente);
            }
        } catch (SQLException ex) {
            System.out.println("Error al obtener la lista de asistentes: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
            }
        }
        return lista;
    }

    public boolean actualizar(Asistente a) {
        PreparedStatement ps = null;
        Conexion cn = new Conexion();
        Connection connection = null;
        try {
            connection = cn.getConnection();
            String sql = "UPDATE asistente SET nombre=?, apellidoP=?, apellidoM=?, correo=?, telefono=? WHERE id_asistente=?";
            ps = connection.prepareStatement(sql);

            ps.setString(1, a.getNombre());
            ps.setString(2, a.getApellidoP());
            ps.setString(3, a.getApellidoM());
            ps.setString(4, a.getCorreo());
            ps.setString(5, a.getTelefono());
            ps.setInt(6, a.getIdAsistente());

            int filaActualizada = ps.executeUpdate();
            return filaActualizada > 0;
        } catch (SQLException ex) {
            System.out.println("Error al actualizar asistente: " + ex.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
            }
        }
        return false;
    }

    public boolean eliminar(int idAsistente) {
        boolean estado = false;
        Connection connection = null;
        PreparedStatement st = null;
        Conexion cn = new Conexion();
        try {
            connection = cn.getConnection();
            String sql = "DELETE FROM asistente WHERE id_asistente = ?";
            st = connection.prepareStatement(sql);

            st.setInt(1, idAsistente);
            int filaElimina = st.executeUpdate();
            estado = filaElimina > 0;
        } catch (SQLException ex) {
            System.out.println("Error al eliminar asistente: " + ex.getMessage());
        } finally {
            try {
                if (st != null) st.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
            }
        }
        return estado;
    }

    public Asistente buscarUno(int idAsistente) {
        Conexion cn = new Conexion();
        Connection connection = cn.getConnection();
        ResultSet rs = null;
        PreparedStatement ps = null;
        Asistente asistente = null;

        try {
            String sql = "SELECT id_asistente, nombre, apellidoP, apellidoM, correo, telefono FROM asistente WHERE id_asistente=?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, idAsistente);

            rs = ps.executeQuery();

            if (rs.next()) {
                asistente = new Asistente();
                asistente.setIdAsistente(rs.getInt("id_asistente"));
                asistente.setNombre(rs.getString("nombre"));
                asistente.setApellidoP(rs.getString("apellidoP"));
                asistente.setApellidoM(rs.getString("apellidoM"));
                asistente.setCorreo(rs.getString("correo"));
                asistente.setTelefono(rs.getString("telefono"));
            }
        } catch (SQLException ex) {
            System.out.println("Error al buscar asistente: " + ex.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (rs != null) rs.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
            }
        }
        return asistente;
    }
    
    public boolean buscarPorCorreo(String correo) {
        Conexion cn = new Conexion();
        Connection connection = cn.getConnection();
        ResultSet rs = null;
        PreparedStatement ps = null;

        try {
            String sql = "SELECT id_asistente FROM asistente WHERE correo=?";
            ps = connection.prepareStatement(sql);
            ps.setString(1, correo);

            rs = ps.executeQuery();

            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            System.out.println("Error al buscar asistente por correo: " + ex.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (rs != null) rs.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                System.out.println("Error al cerrar recursos: " + ex.getMessage());
            }
        }

        return false; 
    }


}
