<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nosotros | Sistema de Eventos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/estilo.css">
    <style>
        body {
            background-color: #f8f9fc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .banner-nosotros {
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            color: white;
            padding: 100px 0;
            margin-bottom: 50px;
        }
        
        .titulo-seccion {
            color: #4e73df;
            position: relative;
            padding-bottom: 15px;
            margin-bottom: 30px;
        }
        
        .titulo-seccion:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 60px;
            height: 4px;
            background: #4e73df;
        }
        
        .card-equipo {
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s;
            margin-bottom: 30px;
        }
        
        .card-equipo:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        
        .icono-nosotros {
            font-size: 2.5rem;
            color: #4e73df;
            margin-bottom: 20px;
        }
        
        .img-equipo {
            border-radius: 10px 10px 0 0;
            width: 100%;
            height: 250px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <%@ include file="nav.jsp" %>
    
    <!-- Banner Principal -->
    <div class="banner-nosotros text-center">
        <div class="container">
            <h1 class="display-4 fw-bold mb-4">Sobre Nosotros</h1>
            <p class="lead">Conectando personas a través de experiencias memorables</p>
        </div>
    </div>
    
    <div class="container py-5">
        <div class="row mb-5">
            <div class="col-lg-6">
                <h2 class="titulo-seccion">Nuestra Historia</h2>
                <p class="lead">Desde 2015, hemos estado transformando la manera en que las personas experimentan eventos.</p>
                <p>Somos un equipo apasionado por crear experiencias únicas e inolvidables. Lo que comenzó como un pequeño proyecto entre amigos, hoy se ha convertido en la plataforma líder de gestión de eventos en la región.</p>
                <p>Nuestra misión es simple pero poderosa: conectar a las personas con eventos que enriquezcan sus vidas, ya sea para aprender, celebrar o simplemente disfrutar.</p>
            </div>
            <div class="col-lg-6">
                <img src="img/foto4.avif" 
                     alt="Nuestro equipo trabajando" 
                     class="img-fluid rounded shadow">
            </div>
        </div>
        
        <div class="row mb-5">
            <div class="col-12 text-center mb-5">
                <h2 class="titulo-seccion">Lo Que Nos Define</h2>
            </div>
            
            <div class="col-md-4 text-center mb-4">
                <div class="p-4">
                    <i class="fas fa-bullseye icono-nosotros"></i>
                    <h3>Misión</h3>
                    <p>Facilitar la conexión entre organizadores y asistentes a través de una plataforma intuitiva que simplifica la gestión y participación en eventos.</p>
                </div>
            </div>
            
            <div class="col-md-4 text-center mb-4">
                <div class="p-4">
                    <i class="fas fa-eye icono-nosotros"></i>
                    <h3>Visión</h3>
                    <p>Ser reconocidos como el referente en tecnología para eventos, innovando constantemente para mejorar la experiencia de todos nuestros usuarios.</p>
                </div>
            </div>
            
            <div class="col-md-4 text-center mb-4">
                <div class="p-4">
                    <i class="fas fa-heart icono-nosotros"></i>
                    <h3>Valores</h3>
                    <p>Pasión, Innovación, Integridad y Excelencia son los pilares que guían cada decisión que tomamos en nuestro día a día.</p>
                </div>
            </div>
        </div>
        
        <div class="row mb-5">
            <div class="col-12 text-center mb-5">
                <h2 class="titulo-seccion">Conoce Nuestro Equipo</h2>
                <p class="lead">El talento humano detrás de cada evento exitoso</p>
            </div>
            
            <div class="col-md-4">
                <div class="card card-equipo">
                    <img src="img/foto3.avif" 
                         class="img-equipo" 
                         alt="Fundador">
                    <div class="card-body text-center">
                        <h4 class="card-title">Carlos Mendoza</h4>
                        <h6 class="text-primary">Fundador & CEO</h6>
                        <p class="card-text">Con más de 15 años en la industria de eventos, Carlos lidera nuestra visión estratégica.</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card card-equipo">
                    <img src="img/foto1.avif" 
                         class="img-equipo" 
                         alt="Directora de Operaciones">
                    <div class="card-body text-center">
                        <h4 class="card-title">María Fernández</h4>
                        <h6 class="text-primary">Directora de Operaciones</h6>
                        <p class="card-text">Especialista en logística de eventos con un enfoque en la excelencia operativa.</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card card-equipo">
                    <img src="img/foto2.avif" 
                         class="img-equipo" 
                         alt="CTO">
                    <div class="card-body text-center">
                        <h4 class="card-title">Javier López</h4>
                        <h6 class="text-primary">CTO</h6>
                        <p class="card-text">Líder tecnológico que asegura que nuestra plataforma sea robusta e innovadora.</p>
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