<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Login</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
	
	 <style>
        :root {
            --color-primario: #4e73df;
            --color-secundario: #f8f9fc;
            --color-accento: #2e59d9;
        }
        
        body {
            background-color: #f8f9fc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .contenedor-login {
            max-width: 450px;
            margin: auto;
            padding: 2.5rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.1);
        }
        
        .cabecera-login {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .cabecera-login img {
            height: 70px;
            margin-bottom: 1.5rem;
        }
        
        .cabecera-login h2 {
            color: var(--color-primario);
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .form-control {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            border: 1px solid #ddd;
        }
        
        .form-control:focus {
            border-color: var(--color-primario);
            box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.2);
        }
        
        .btn-iniciar-sesion {
            background-color: var(--color-primario);
            color: white;
            border: none;
            padding: 12px;
            font-weight: 600;
            width: 100%;
            border-radius: 8px;
            transition: all 0.3s;
        }
        
        .btn-iniciar-sesion:hover {
            background-color: var(--color-accento);
            transform: translateY(-2px);
        }
        
        .pie-login {
            text-align: center;
            margin-top: 2rem;
            color: #6c757d;
        }
        
        .pie-login a {
            color: var(--color-primario);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .pie-login a:hover {
            text-decoration: underline;
        }
        
        .input-group-text {
            background-color: #f8f9fa;
        }
        
        .alert {
            border-radius: 8px;
        }
    </style>
</head>
<body>
	<%@ include file="nav.jsp" %>
    
    <div class="container my-auto p-5">
        <div class="contenedor-login animate__animated animate__fadeIn">
            <div class="cabecera-login">
                <img src="img/3710314.png" alt="Logo" class="img-fluid">
                <h2>Iniciar Sesión</h2>
                <p class="text-muted">Ingresa tus credenciales para acceder al sistema</p>
            </div>
            
            <%
            String mensaje = (String) session.getAttribute("mensaje");
            if (mensaje != null) {
            %>
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                <i class="fas fa-info-circle me-2"></i> <%=mensaje%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
            </div>
            <%
                session.removeAttribute("mensaje");
            }
            %>
            
            <form action="IndexServlet?metodo=login" method="post">
                <div class="mb-3">
                    <label for="correo" class="form-label">Correo electrónico</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                        <input type="email" class="form-control" id="correo" name="correo" placeholder="tu@email.com" required>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label for="contrasenia" class="form-label">Contraseña</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="contrasenia" name="contrasenia" placeholder="••••••••" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-iniciar-sesion mb-3">
                    <i class="fas fa-sign-in-alt me-2"></i> Iniciar Sesión
                </button>
                
            </form>
            
            <div class="pie-login">
                <p>¿No tienes una cuenta? <a href="registro.jsp">Regístrate aquí</a></p>
                <p class="small text-muted mt-3">
                    <i class="fas fa-lock me-1"></i> Tus datos están protegidos
                </p>
            </div>
        </div>
    </div>
    
    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#togglePassword').click(function() {
                const passwordInput = $('#contrasenia');
                const icon = $(this).find('i');
                
                if (passwordInput.attr('type') === 'password') {
                    passwordInput.attr('type', 'text');
                    icon.removeClass('fa-eye').addClass('fa-eye-slash');
                } else {
                    passwordInput.attr('type', 'password');
                    icon.removeClass('fa-eye-slash').addClass('fa-eye');
                }
            });
        });
    </script>
</body>
</html>
