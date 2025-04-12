package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.EventoDAO;
import modelo.Evento;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@MultipartConfig
@WebServlet("/EventoServlet")
public class EventoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EventoServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String metodo = request.getParameter("metodo");

            HttpSession session = request.getSession();
            EventoDAO eventoDao = new EventoDAO();

            if ("listar".equals(metodo)) {
                List<Evento> eventos = eventoDao.listar();
                request.setAttribute("listaEventos", eventos);

                RequestDispatcher dispatcher = request.getRequestDispatcher("evento.jsp");
                dispatcher.forward(request, response);
            } else if ("agregar".equals(metodo)) {
                String nombre = request.getParameter("nombre");
                String descripcion = request.getParameter("descripcion");
                String fechaInicio = request.getParameter("fechaInicio");
                String hora = request.getParameter("hora");
                
                String fechaFin = request.getParameter("fechaFin");
                String precio = request.getParameter("precio");
                String ubicacion = request.getParameter("ubicacion");
                String mensaje;
                
                if (!hora.matches("\\d{2}:\\d{2}:\\d{2}")) {
                	hora += ":00";
                }
                
                Date fechaInicio_ = Date.valueOf(fechaInicio);
                Date fechaFin_ = Date.valueOf(fechaFin);
                Time hora_ = Time.valueOf(hora);
                
                Evento evento= new Evento();
                evento.setNombre(nombre);
                evento.setDescripcion(descripcion);
                evento.setFechaInicio(fechaInicio_);
                evento.setHora(hora_);
                evento.setFechaFin(fechaFin_);
                evento.setPrecio(Double.parseDouble(precio));
                evento.setUbicacion(ubicacion);
                
                
                Part parteImagen = request.getPart("imagen");

	             String extension = "";
	             String nombreOriginal = Paths.get(parteImagen.getSubmittedFileName()).getFileName().toString();
	             int punto = nombreOriginal.lastIndexOf(".");
	             if (punto >= 0) {
	                 extension = nombreOriginal.substring(punto);
	             }
	
	             DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
	             String timestamp = LocalDateTime.now().format(formatter);
	             String nombreArchivo = "evento_" + timestamp + extension;
	
	             String rutaCarpeta = request.getServletContext().getRealPath("/img");
	             File carpeta = new File(rutaCarpeta);
	             if (!carpeta.exists()) carpeta.mkdirs();
	
	             String rutaImagen = rutaCarpeta + File.separator + nombreArchivo;
	             parteImagen.write(rutaImagen);
	
	             evento.setImagen(nombreArchivo);

                boolean estado = eventoDao.nuevo(evento);
                if (!estado) {
                    mensaje = "Error al registrar nuevo evento";
                    session.setAttribute("mensaje", mensaje);
                } else {
                    mensaje = "Evento registrado";
                    session.setAttribute("mensaje", mensaje);
                }

                session.setAttribute("mensaje", mensaje);
                response.sendRedirect("EventoServlet?metodo=listar");
            } 
            else if ("editar".equals(metodo)) {
                String idEvento = request.getParameter("idEvento");

                if (request.getParameter("cargar") != null) {
                    Evento evento = eventoDao.buscarUno(Integer.parseInt(idEvento));

                    if (evento != null) {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");

                        out.print("{\"idEvento\":\"" + evento.getIdEvento() + "\","
                                + "\"nombre\":\"" + evento.getNombre() + "\","
                                + "\"descripcion\":\"" + evento.getDescripcion() + "\","
                                + "\"fechaInicio\":\"" + evento.getFechaInicio() + "\","
                                + "\"hora\":\"" + evento.getHora() + "\","
                                + "\"fechaFin\":\"" + evento.getFechaFin() + "\","
                                + "\"precio\":\"" + evento.getPrecio() + "\","
                                + "\"imagen\":\"" + evento.getImagen() + "\","
                                + "\"ubicacion\":\"" + evento.getUbicacion() + "\"}");

                        out.flush();
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Evento no encontrado");
                    }
                } else {
                	String nombre = request.getParameter("nombre");
                    String descripcion = request.getParameter("descripcion");
                    String fechaInicio = request.getParameter("fechaInicio");
                    String hora = request.getParameter("hora");
                    
                    String fechaFin = request.getParameter("fechaFin");
                    String precio = request.getParameter("precio");
                    String ubicacion = request.getParameter("ubicacion");
                    
                    if (!hora.matches("\\d{2}:\\d{2}:\\d{2}")) {
                    	hora += ":00";
                    }
                    
                    Date fechaInicio_ = Date.valueOf(fechaInicio);
                    Date fechaFin_ = Date.valueOf(fechaFin);
                    Time hora_ = Time.valueOf(hora);
                    
                    Evento evento= new Evento();
                    evento.setIdEvento(Integer.parseInt(idEvento));
                    evento.setNombre(nombre);
                    evento.setDescripcion(descripcion);
                    evento.setFechaInicio(fechaInicio_);
                    evento.setHora(hora_);
                    evento.setFechaFin(fechaFin_);
                    evento.setPrecio(Double.parseDouble(precio));
                    evento.setUbicacion(ubicacion);
                    
                    Part parteImagen = request.getPart("imagen");
                    
                    if (parteImagen != null && parteImagen.getSize() > 0) {//selecciono una imagen
                    	//eliminar imagne anterior
                    	String img_anterior=request.getParameter("imagenActual");
                    	if (img_anterior != null && !img_anterior.isEmpty()) {
                            String rutaCarpeta = request.getServletContext().getRealPath("/img");
                            File imagenAnterior = new File(rutaCarpeta + File.separator + img_anterior);

                            if (imagenAnterior.exists()) {
                                imagenAnterior.delete();
                            }
                        }
                    	
                    	String extension = "";
	       	             String nombreOriginal = Paths.get(parteImagen.getSubmittedFileName()).getFileName().toString();
	       	             int punto = nombreOriginal.lastIndexOf(".");
	       	             if (punto >= 0) {
	       	                 extension = nombreOriginal.substring(punto);
	       	             }
	       	
	       	             DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
	       	             String timestamp = LocalDateTime.now().format(formatter);
	       	             String nombreArchivo = "evento_" + timestamp + extension;
	       	
	       	             String rutaCarpeta = request.getServletContext().getRealPath("/img");
	       	             File carpeta = new File(rutaCarpeta);
	       	             if (!carpeta.exists()) carpeta.mkdirs();
	       	
	       	             String rutaImagen = rutaCarpeta + File.separator + nombreArchivo;
	       	             parteImagen.write(rutaImagen);
	       	
	       	             evento.setImagen(nombreArchivo);
                    	
                    }else {
                    	evento.setImagen(request.getParameter("imagenActual"));
                    }
                    

                    boolean estado= eventoDao.actualizar(evento);
                    String msj="Evento no se ha modificado";
                    if(estado) {
                    	msj="Evento modificado";
                    }

                    session.setAttribute("mensaje", msj);
                    response.sendRedirect("EventoServlet?metodo=listar");
                }
            } else if ("eliminar".equals(metodo)) {
                String idEvento = request.getParameter("idEvento");
                Evento evento = eventoDao.buscarUno(Integer.parseInt(idEvento));
                if(evento!=null) {
                	String img_anterior=evento.getImagen();
                	if (img_anterior != null && !img_anterior.isEmpty()) {
                        String rutaCarpeta = request.getServletContext().getRealPath("/img");
                        File imagenAnterior = new File(rutaCarpeta + File.separator + img_anterior);

                        if (imagenAnterior.exists()) {
                            imagenAnterior.delete();
                        }
                    }
                	
                	boolean estado= eventoDao.eliminar(Integer.parseInt(idEvento));
                    if(!estado) {
                    	session.setAttribute("mensaje", "Evento eliminado");
                    }else {
                    	session.setAttribute("mensaje", "Evento no eliminado");
                    }
                }
                

                response.sendRedirect("EventoServlet?metodo=listar");
            }


        }
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
