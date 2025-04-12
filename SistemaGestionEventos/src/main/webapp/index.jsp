<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="modelo.Evento" %>
<%@page import="dao.EventoDAO" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Index</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css/estilo.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
	<%@ include file="nav.jsp" %>
	<div class="banner-container">
    <div class="banner-overlay"></div>
    <img src="img/banner.jpg" alt="Eventos destacados" class="banner-img">
    <div class="banner-content">
        <h1 class="banner-title">Los Mejores Eventos</h1>
        <p class="banner-text">Descubre experiencias únicas e inolvidables</p>
    </div>
</div>
    
    
	<div class="contenedor">
        

        <h1 class="titulo">Eventos</h1>

        <div class="evento-grid">
		    <%
		    EventoDAO eventoDao = new EventoDAO();
		    List<Evento> listaEventos = eventoDao.listar();
		    if (listaEventos != null && !listaEventos.isEmpty()) {
		        for (Evento evento : listaEventos) {
		    %>
		    <div class="evento-grid__item">
		        <div class="evento-grid__imagen">
		            <img src="img/<%= evento.getImagen() %>" alt="">
		        </div>
		
		        <div class="evento-grid__informacion">
		            <p class="evento-grid__nombre"><%= evento.getNombre() %></p>
		            <p class="evento-grid__precio">S/. <%= evento.getPrecio() %></p>
		
		            <a href="#" class="evento-grid__btn btn-defecto" 
		               data-btn-action="add-btn-cart" 
		               data-modal="#jsModalCarrito"  
		               data-idevento="<%= evento.getIdEvento() %>">Inscribirse</a>
		        </div>
		    </div>
		    <% }} %>
		</div>
    </div>
    
    <%@ include file="carrito.jsp" %>
    <%@ include file="footer.jsp" %>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="js/app.js"></script>
</body>
</html>