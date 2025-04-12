<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro | Sistema de Eventos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card-registro {
            max-width: 600px;
            margin: 2rem auto;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            border: none;
        }
        .card-header {
            background: #4e73df;
            color: white;
            border-radius: 10px 10px 0 0 !important;
            padding: 1.5rem;
            text-align: center;
        }
        .form-label {
            font-weight: 600;
            color: #5a5c69;
        }
        .form-control {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 1rem;
        }
        .btn-registro {
            background: #4e73df;
            border: none;
            padding: 12px;
            font-weight: 600;
            width: 100%;
            margin-top: 1rem;
        }
        .btn-registro:hover {
            background: #2e59d9;
        }
        .input-group-text {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
    <%@ include file="nav.jsp" %>

    <div class="container py-5">
        <div class="card card-registro animate__animated animate__fadeIn">
            <div class="card-header">
                <h3><i class="fas fa-user-plus me-2"></i>Crear nueva cuenta</h3>
            </div>
            <div class="card-body p-4">
                <%
                String mensaje = (String) session.getAttribute("mensaje");
                if (mensaje != null) {
                %>
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    <%=mensaje%>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                session.removeAttribute("mensaje");
                }
                %>
                
                <form action="IndexServlet?metodo=registro" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="nombre" class="form-label">Nombre</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="apellidoP" class="form-label">Apellido Paterno</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" class="form-control" id="apellidoP" name="apellidoP" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="apellidoM" class="form-label">Apellido Materno</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input type="text" class="form-control" id="apellidoM" name="apellidoM" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="correo" class="form-label">Correo electrónico</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input type="email" class="form-control" id="correo" name="correo" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="contrasenia" class="form-label">Contraseña</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control" id="contrasenia" name="contrasenia" required>
                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="telefono" class="form-label">Teléfono</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-phone"></i></span>
                            <input type="text" class="form-control" id="telefono" name="telefono">
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-registro">
                        <i class="fas fa-user-plus me-2"></i>Registrarse
                    </button>
                    
                    <div class="text-center mt-3">
                        <p>¿Ya tienes una cuenta? <a href="login.jsp">Inicia sesión aquí</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('contrasenia');
            const icon = this.querySelector('i');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    </script>
</body>
</html>
