
<%@page import="modelo.Inscripcion" %>
<%@page import="modelo.Evento" %>
<%@page import="dao.EventoDAO" %>
<%@page import="dao.InscripcionDAO" %>
<%@page import="java.util.List" %>

<div class="modalcarrito" id="jsModalCarrito">
	<div class="modal__contenedor">
		<button type="button"
			class="modal__cerrar fa-solid fa-xmark jsModalCerrar "></button>

		<div class="modal__informacion">
			<div class="modal__header">
				<h2>
					<i class=""></i>Carrito
				</h2>
			</div>
			

			<div class="modal__body" id="modal__body">
				<div class="" id=lista_carrito>
					<%
						Integer id2 = (Integer) session.getAttribute("asistenteId");
						float subtotal=0.00f;
						float descuento=0.00f;
						float total=0.00f;
						if (id2 != null) {
							InscripcionDAO inscripcionDao = new InscripcionDAO();
							EventoDAO eventoDAO= new EventoDAO();
							List<Inscripcion> inscripciones = inscripcionDao.listarPorAsistente(id2);
							for (int i = 0; i < inscripciones.size(); i++) {
							    Inscripcion inscripcion = inscripciones.get(i);
							    Evento evento = eventoDAO.buscarUno(inscripcion.getIdEvento());
							    subtotal += evento.getPrecio();
					%>	
						<div class="modal__item">
							<div class="modal__miniatura">
								<img src="img/<%= evento.getImagen() %>" alt="Naranja">
							</div>
							<div class="modal__texto-evento">
								<p><%= evento.getNombre() %></p>
								<p>
									<strong>S/. <%= evento.getPrecio() %></strong>
								</p>
							</div>
							<button class="eliminar-item" title="Eliminar" onclick="eliminarItem(<%= inscripcion.getIdInscripcion() %>)">
							    <i class="fas fa-trash"></i>
							</button>
						</div>
						
		            <%}
							total= subtotal-descuento;
						
						}%>
				</div>
			</div>

			<div class="modal__footer">
				<div class="modal__lista-precio">
					<ul>
						<li>Subtotal: <strong id="subtotal">S/. <%= subtotal %></strong></li>
						<li>Descuento: <strong id="descuento">S/. <%= descuento %></strong></li>
					</ul>
					<h4 class="modal__total-cart" >Total: <span id="total">S/. <%= total %></span></h4>
				</div>

				<div class="modal__btns">
					<a href="#" id="seguir_comprando" class="btn-border">Seguir comprando</a> 
					<a href="procesar_pago.jsp" class="btn-primario">Procesar Pago</a>
				</div>
			</div>
		</div>
	</div>
</div>