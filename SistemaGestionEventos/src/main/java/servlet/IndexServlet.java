package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AsistenteDAO;
import dao.EntradaDAO;
import dao.EventoDAO;
import dao.InscripcionDAO;
import modelo.Asistente;
import modelo.Entrada;
import modelo.Evento;
import modelo.Inscripcion;



@WebServlet("/IndexServlet")
public class IndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public IndexServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			String metodo = request.getParameter("metodo");
			HttpSession session = request.getSession();
			AsistenteDAO asistenteDAO = new AsistenteDAO();
			InscripcionDAO inscripcionDao = new InscripcionDAO();
			EventoDAO eventoDAO= new EventoDAO();

	        if ("nosotros".equals(metodo)) {
	            RequestDispatcher dispatcher = request.getRequestDispatcher("nosotros.jsp");
	            dispatcher.forward(request, response);
	        }
	        
	        if ("ubicanos".equals(metodo)) {
	            RequestDispatcher dispatcher = request.getRequestDispatcher("ubicanos.jsp");
	            dispatcher.forward(request, response);
	        }
	        
	        
	        
	        if ("procesarPago".equals(metodo)) {
	        	 procesarPago(request, response);
	        }
	        
	        if ("eliminarInscripcion".equals(metodo)) {
	        	session = request.getSession(false);
				if (session != null && session.getAttribute("asistenteId") != null) {			
					int idAsistente = (int) session.getAttribute("asistenteId");
					int idInscripcion = Integer.parseInt(request.getParameter("idInscripcion"));
		        	inscripcionDao.eliminar(idInscripcion);
		        	
		        	List<Inscripcion> inscripciones = inscripcionDao.listarPorAsistente(idAsistente);

					if (inscripciones != null && !inscripciones.isEmpty()) {
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						out.print("[");
						for (int i = 0; i < inscripciones.size(); i++) {
						    Inscripcion inscripcion = inscripciones.get(i);
						    Evento evento = eventoDAO.buscarUno(inscripcion.getIdEvento());

						    out.print("{"
						        + "\"idInscripcion\":\"" + inscripcion.getIdInscripcion() + "\","
						        + "\"idEvento\":\"" + evento.getIdEvento() + "\","
						        + "\"nombre\":\"" + evento.getNombre() + "\","
						        + "\"precio\":\"" + evento.getPrecio() + "\","
						        + "\"imagen\":\"" + evento.getImagen() + "\""
						        + "}");

						    if (i < inscripciones.size() - 1) {
						        out.print(",");
						    }
						}
						out.print("]");
						out.flush();
					} else {
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						out.print("[]");
						out.flush();
					}
				}
	        }
	        
			if ("inscribirse".equals(metodo)) {
				session = request.getSession(false);

				if (session != null && session.getAttribute("asistenteId") != null) {
					int idEvento = Integer.parseInt(request.getParameter("idevento"));
					int idAsistente = (int) session.getAttribute("asistenteId");
					LocalDate fechaInscripcion = LocalDate.now();
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
					String fechaInscripcionStr = fechaInscripcion.format(formatter);
					Date fechaInscripcionDate = Date.valueOf(fechaInscripcionStr);

					Inscripcion inscripcion = new Inscripcion();
					inscripcion.setIdEvento(idEvento);
					inscripcion.setIdAsistente(idAsistente);
					inscripcion.setFechaInscripcion(fechaInscripcionDate);

					Integer op = inscripcionDao.buscarInscripcion(idEvento, idAsistente);
					if (op == null) {
						inscripcionDao.nueva(inscripcion);
					}

					List<Inscripcion> inscripciones = inscripcionDao.listarPorAsistente(idAsistente);

					if (inscripciones != null && !inscripciones.isEmpty()) {
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						out.print("[");
						for (int i = 0; i < inscripciones.size(); i++) {
						    inscripcion = inscripciones.get(i);
						    Evento evento = eventoDAO.buscarUno(inscripcion.getIdEvento());

						    out.print("{"
						        + "\"idInscripcion\":\"" + inscripcion.getIdInscripcion() + "\","
						        + "\"idEvento\":\"" + evento.getIdEvento() + "\","
						        + "\"nombre\":\"" + evento.getNombre() + "\","
						        + "\"precio\":\"" + evento.getPrecio() + "\","
						        + "\"imagen\":\"" + evento.getImagen() + "\""
						        + "}");

						    if (i < inscripciones.size() - 1) {
						        out.print(",");
						    }
						}
						out.print("]");
						out.flush();
					} else {
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						out.print("[]");
						out.flush();
					}

				} else {
					response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
					response.getWriter().write("No autorizado");
				}
			}
	        
	        if ("login".equals(metodo)) {
	        	String correo = request.getParameter("correo");
	            String contrasenia = request.getParameter("contrasenia");
	            Asistente asistente= asistenteDAO.validarInicioSesion(correo, contrasenia);
	            if(asistente!=null) {
	            	session.setAttribute("asistenteId", asistente.getIdAsistente());
	                session.setAttribute("asistente_dato", asistente.getNombre()+" "+asistente.getApellidoP()+" "+asistente.getApellidoM());
	            	session.setAttribute("mensaje", "ha iniciado sesión");
	            	RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
	            	dispatcher.forward(request, response);
	            }else {
	            	session.setAttribute("mensaje", "Correo y/o contraseña incorrecto");
	            	RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
	            	dispatcher.forward(request, response);
	            }
	        }
	        
	        if ("registro".equals(metodo)) {
	        	String nombre = request.getParameter("nombre");
	            String apellidoP = request.getParameter("apellidoP");
	            String apellidoM = request.getParameter("apellidoM");
	            String correo = request.getParameter("correo");
	            String telefono = request.getParameter("telefono");
	            String contrasenia = request.getParameter("contrasenia");
	            
	            boolean existe= asistenteDAO.buscarPorCorreo(correo);
	            if(existe) {
	            	session.setAttribute("mensaje", "El correo ingresado ya existe");
	            	RequestDispatcher dispatcher = request.getRequestDispatcher("registro.jsp");
	                dispatcher.forward(request, response);
	            }else {
	            	Asistente asistente = new Asistente();
	                asistente.setNombre(nombre);
	                asistente.setApellidoP(apellidoP);
	                asistente.setApellidoM(apellidoM);
	                asistente.setCorreo(correo);
	                asistente.setTelefono(telefono);
	                asistente.setContrasenia(contrasenia);
	                boolean estado = asistenteDAO.nuevo(asistente);
	                if(estado) {
	                	session.setAttribute("mensaje", "Se ha registrado satisfactoriamente");
	                	RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
	                    dispatcher.forward(request, response);
	                }else {
	                	session.setAttribute("mensaje", "Ocurrio un error al intentar registrarse");
	                	RequestDispatcher dispatcher = request.getRequestDispatcher("registro.jsp");
	                    dispatcher.forward(request, response);
	                }
	            }

	            
	        }
	        if ("cerrar".equals(metodo)) {
	        	session = request.getSession(false);
	            if (session != null) {
	                session.invalidate();
	            }
	            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
	            dispatcher.forward(request, response);
	        }
			
		}	
	}
	
	private void procesarPago(HttpServletRequest request, HttpServletResponse response) throws IOException {
		boolean pagoExitoso = true;
		HttpSession session = request.getSession();
		InscripcionDAO inscripcionDao = new InscripcionDAO();
		EntradaDAO entradaDAO = new EntradaDAO();
		session = request.getSession(false);
		if (session != null && session.getAttribute("asistenteId") != null) {
			int idAsistente = (int) session.getAttribute("asistenteId");

			String metodoPago = request.getParameter("metodoPago");
			LocalDate fechaInscripcion = LocalDate.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String fechaInscripcionStr = fechaInscripcion.format(formatter);
			Date fechaInscripcionDate = Date.valueOf(fechaInscripcionStr);

			List<Inscripcion> inscripciones = inscripcionDao.listarPorAsistente(idAsistente);
			for (int i = 0; i < inscripciones.size(); i++) {
				Inscripcion inscripcion = inscripciones.get(i);
				Entrada entrada = new Entrada();
				entrada.setIdAsistente(idAsistente);
				entrada.setIdEvento(inscripcion.getIdEvento());
				entrada.setMetodoPago(metodoPago);
				entrada.setFechaCompra(fechaInscripcionDate);
				entradaDAO.nueva(entrada);
				inscripcionDao.eliminar(inscripcion.getIdInscripcion());

			}
		}


	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");

	    PrintWriter out = response.getWriter();

	    if (pagoExitoso) {
	        out.print("{\"status\":\"success\","
	                + "\"message\":\"Pago procesado con éxito.\"}");
	    } else {
	        out.print("{\"status\":\"error\","
	                + "\"message\":\"Error al procesar el pago.\"}");
	    }
	    out.flush();
	}



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
