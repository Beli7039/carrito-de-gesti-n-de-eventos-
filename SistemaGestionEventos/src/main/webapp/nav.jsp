
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">
            <i class="fas fa-calendar-alt me-2"></i>EventosApp
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain" aria-expanded="false">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">
                        <i class="fas fa-home me-1"></i> Inicio
                    </a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="IndexServlet?metodo=nosotros">
                        <i class="fas fa-users me-1"></i> Nosotros
                    </a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="IndexServlet?metodo=ubicanos">
                        <i class="fas fa-map-marker-alt me-1"></i> Ubícanos
                    </a>
                </li>
            </ul>
            
            <ul class="navbar-nav ms-auto">
                <%
                Integer id = (Integer) session.getAttribute("asistenteId");
                if (id == null) {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">
                        <i class="fas fa-sign-in-alt me-1"></i> Iniciar Sesión
                    </a>
                </li>
                
                <li class="nav-item">
                    <a class="btn btn-outline-light ms-2" href="registro.jsp">
                        <i class="fas fa-user-plus me-1"></i> Registrarse
                    </a>
                </li>
                <% } else { %>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                        <i class="fas fa-user-circle me-1"></i> Mi Cuenta
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#">
                            <i class="fas fa-user me-2"></i> Perfil
                        </a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item" href="IndexServlet?metodo=cerrar">
                                <i class="fas fa-sign-out-alt me-2"></i> Cerrar Sesión
                            </a>
                        </li>
                    </ul>
                </li>
                
                <li class="nav-item ms-2" id="carritoAbrir">
                    <a class="btn btn-warning position-relative"  href="#" data-modal="#jsModalCarrito">
                        <i class="fas fa-shopping-cart" style="pointer-events: none;"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                            0
                        </span>
                    </a>
                </li>
                <% } %>
                
                <li class="nav-item">
                    <a class="nav-link" href="EventoServlet?metodo=listar"> Admi
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>