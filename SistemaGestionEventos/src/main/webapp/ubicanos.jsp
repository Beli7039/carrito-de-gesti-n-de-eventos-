<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ubícanos | Sistema de Eventos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/estilo.css">
    <style>
        body {
            background-color: #f8f9fc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .mapa-container {
            height: 500px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 25px rgba(0,0,0,0.1);
        }
        
        .card-sede {
            border-radius: 10px;
            transition: all 0.3s;
            border: none;
            box-shadow: 0 3px 15px rgba(0,0,0,0.1);
        }
        
        .card-sede:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        
        .titulo-principal {
            color: #4e73df;
            position: relative;
            padding-bottom: 15px;
        }
        
        .titulo-principal:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 80px;
            height: 4px;
            background: #4e73df;
        }
        
        .icono-contacto {
            font-size: 2rem;
            color: #4e73df;
        }
    </style>
</head>
<body>
    <%@ include file="nav.jsp" %>
    
    <div class="container py-5">
        <!-- Encabezado -->
        <div class="row mb-5">
            <div class="col-12 text-center">
                <h1 class="titulo-principal">Nuestras Sedes de Eventos</h1>
                <p class="lead text-muted">Descubre dónde realizamos nuestros mejores eventos</p>
            </div>
        </div>
        
        <!-- Mapa y Contenido -->
        <div class="row mb-5">
            <div class="col-lg-8 mb-4 mb-lg-0">
                <div class="mapa-container">
                    <!-- Mapa de Google Maps -->
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3901.965949600882!2d-76.9915839851886!3d-12.06763754542556!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105c5f619ee3ec7%3A0x14206cb9cc452e4a!2sCentro%20de%20Convenciones%20Lima!5e0!3m2!1ses!2spe!4v1620000000000!5m2!1ses!2spe" 
                            width="100%" 
                            height="100%" 
                            style="border:0;" 
                            allowfullscreen="" 
                            loading="lazy">
                    </iframe>
                </div>
            </div>
            
            <div class="col-lg-4">
                <div class="card card-sede h-100">
                    <div class="card-body p-4">
                        <h3 class="card-title mb-4"><i class="fas fa-map-marker-alt text-danger me-2"></i> Ubicación Principal</h3>
                        
                        <div class="mb-4">
                            <h5 class="fw-bold">Centro de Convenciones Lima</h5>
                            <p class="text-muted">Av. Javier Prado Este 4200, San Borja</p>
                            <p class="text-muted">Lima, Perú</p>
                        </div>
                        
                        <hr>
                        
                        <h5 class="fw-bold mb-3">Contacto</h5>
                        <div class="d-flex align-items-center mb-3">
                            <i class="fas fa-phone icono-contacto me-3"></i>
                            <div>
                                <p class="mb-0">Teléfono</p>
                                <p class="fw-bold">(01) 123-4567</p>
                            </div>
                        </div>
                        
                        <div class="d-flex align-items-center mb-3">
                            <i class="fas fa-envelope icono-contacto me-3"></i>
                            <div>
                                <p class="mb-0">Correo</p>
                                <p class="fw-bold">contacto@eventosapp.com</p>
                            </div>
                        </div>
                        
                        <div class="d-flex align-items-center">
                            <i class="fas fa-clock icono-contacto me-3"></i>
                            <div>
                                <p class="mb-0">Horario</p>
                                <p class="fw-bold">Lunes a Viernes: 9am - 6pm</p>
                                <p class="fw-bold">Sábados: 9am - 1pm</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Sedes adicionales -->
        <div class="row">
            <div class="col-12 mb-4">
                <h3 class="titulo-principal">Otras Sedes</h3>
            </div>
            
            <div class="col-md-4 mb-4">
                <div class="card card-sede h-100">
                    <div class="card-body p-4">
                        <h5 class="card-title fw-bold"><i class="fas fa-map-marker-alt text-primary me-2"></i> Sede Norte</h5>
                        <p class="text-muted">Av. Alfredo Mendiola 1800, Independencia</p>
                        <p class="text-muted">Lima, Perú</p>
                        <hr>
                        <p class="fw-bold"><i class="fas fa-phone me-2"></i> (01) 987-6543</p>
                        <p class="fw-bold"><i class="fas fa-clock me-2"></i> L-V: 10am - 7pm</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4 mb-4">
                <div class="card card-sede h-100">
                    <div class="card-body p-4">
                        <h5 class="card-title fw-bold"><i class="fas fa-map-marker-alt text-primary me-2"></i> Sede Sur</h5>
                        <p class="text-muted">Av. Los Héroes 500, San Juan de Miraflores</p>
                        <p class="text-muted">Lima, Perú</p>
                        <hr>
                        <p class="fw-bold"><i class="fas fa-phone me-2"></i> (01) 765-4321</p>
                        <p class="fw-bold"><i class="fas fa-clock me-2"></i> L-V: 9am - 6pm</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4 mb-4">
                <div class="card card-sede h-100">
                    <div class="card-body p-4">
                        <h5 class="card-title fw-bold"><i class="fas fa-map-marker-alt text-primary me-2"></i> Sede Centro</h5>
                        <p class="text-muted">Jr. de la Unión 600, Cercado de Lima</p>
                        <p class="text-muted">Lima, Perú</p>
                        <hr>
                        <p class="fw-bold"><i class="fas fa-phone me-2"></i> (01) 321-0987</p>
                        <p class="fw-bold"><i class="fas fa-clock me-2"></i> L-S: 8am - 8pm</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<%@ include file="carrito.jsp" %>
	<%@ include file="footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/app.js"></script>
</body>
</html>