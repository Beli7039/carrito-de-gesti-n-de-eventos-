<%@page import="dao.AsistenteDAO" %>
<%@page import="dao.InscripcionDAO" %>
<%@page import="dao.EventoDAO" %>
<%@page import="modelo.Asistente" %>
<%@page import="modelo.Inscripcion" %>
<%@page import="modelo.Evento" %>
<%@page import="java.util.List" %>
<%@page import="java.time.LocalDate" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Datos del Asistente | Sistema de Eventos</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
<link rel="stylesheet" type="text/css" href="css/estilo_procesar_pago.css">
</head>
<body>
	<%@ include file="nav.jsp"%>

	<%
    if (id != null) {
        AsistenteDAO asistenteDAO = new AsistenteDAO();
        Asistente asistente = asistenteDAO.buscarUno(id);
        float subtotal = 0.00f;
        float descuento = 0.00f;
        float total = 0.00f;

        InscripcionDAO inscripcionDao = new InscripcionDAO();
        EventoDAO eventoDAO = new EventoDAO();
        List<Inscripcion> inscripciones = inscripcionDao.listarPorAsistente(id);

        for (Inscripcion inscripcion : inscripciones) {
            Evento evento = eventoDAO.buscarUno(inscripcion.getIdEvento());
            subtotal += evento.getPrecio();
        }

        total = subtotal - descuento;

        String fechaActual = LocalDate.now().toString();
%>

	<div class="container py-5">
		<div class="row justify-content-center">
			<div class="col-lg-10">
				<div
					class="d-sm-flex align-items-center justify-content-between mb-4">
					<h1 class="page-title h3 mb-0">
						<img src="https://cdn-icons-png.flaticon.com/512/3710/3710314.png"
							alt="Logo" class="logo-sm"> Confirmación de Comprar
						Entradas
					</h1>
					<span class="badge bg-primary rounded-pill px-3 py-2"> <i
						class="fas fa-calendar-check me-2"></i>Fecha: <%=fechaActual%>
					</span>
				</div>



				<div class="row">
					<div class="col-lg-8">
						<div class="card mb-4 animate__animated animate__fadeInLeft">
							<div class="card-header">
								<i class="fas fa-user-circle me-2"></i>Información del Asistente
							</div>
							<div class="card-body">
								<div class="row">
									<div class="col-md-6 mb-3">
										<label class="form-label">Nombre</label> <input type="text"
											class="form-control" value="<%=asistente.getNombre()%>"
											readonly>
									</div>
									<div class="col-md-6 mb-3">
										<label class="form-label">Apellido Paterno</label> <input
											type="text" class="form-control"
											value="<%=asistente.getApellidoP()%>" readonly>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label class="form-label">Apellido Materno</label> <input
											type="text" class="form-control"
											value="<%=asistente.getApellidoM()%>" readonly>
									</div>
									<div class="col-md-6 mb-3">
										<label class="form-label">Teléfono</label> <input type="text"
											class="form-control" value="<%=asistente.getTelefono()%>"
											readonly>
									</div>
								</div>
								<div class="mb-3">
									<label class="form-label">Correo Electrónico</label> <input
										type="email" class="form-control"
										value="<%=asistente.getCorreo()%>" readonly>
								</div>
							</div>
						</div>

						<div
							class="card animate__animated animate__fadeInLeft animate__delay-1s">
							<div class="card-header">
								<i class="fas fa-credit-card me-2"></i>Método de Pago
							</div>
							<div class="card-body">
								<div
									class="payment-option active d-flex align-items-center p-3 mb-3">
									<input class="form-check-input me-3" type="radio" name="pago"
										id="tarjeta" value="tarjeta" checked
										style="transform: scale(1.3);"> <img
										src="https://cdn-icons-png.flaticon.com/512/196/196578.png"
										alt="Tarjeta">
									<div>
										<h6 class="mb-1">Tarjeta de Crédito/Débito</h6>
										<small class="text-muted">Pago seguro con cifrado SSL</small>
									</div>
								</div>

								<div class="payment-option d-flex align-items-center p-3 mb-3">
									<input class="form-check-input me-3" type="radio" name="pago"
										id="paypal" value="paypal" style="transform: scale(1.3);">
									<img
										src="https://cdn-icons-png.flaticon.com/512/174/174861.png"
										alt="PayPal">
									<div>
										<h6 class="mb-1">PayPal</h6>
										<small class="text-muted">Paga con tu cuenta PayPal</small>
									</div>
								</div>

								<div class="payment-option d-flex align-items-center p-3">
									<input class="form-check-input me-3" type="radio" name="pago"
										id="transferencia" value="transferencia"
										style="transform: scale(1.3);"> <img
										src="https://cdn-icons-png.flaticon.com/512/2489/2489076.png"
										alt="Transferencia">
									<div>
										<h6 class="mb-1">Transferencia Bancaria</h6>
										<small class="text-muted">Depósito directo a nuestra
											cuenta</small>
									</div>
								</div>

								<div id="tarjetaDetails"
									class="mt-4 animate__animated animate__fadeIn">
									<h5 class="mb-3">
										<i class="fas fa-info-circle me-2"></i>Detalles de Tarjeta
									</h5>
									<div class="row">
										<div class="col-md-12 mb-3">
											<label class="form-label">Número de Tarjeta</label>
											<div class="input-group">
												<input type="text" class="form-control"
													placeholder="1234 5678 9012 3456"> <span
													class="input-group-text"><i class="fab fa-cc-visa"></i>
													<i class="fab fa-cc-mastercard ms-2"></i></span>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 mb-3">
											<label class="form-label">Fecha de Expiración</label> <input
												type="text" class="form-control" placeholder="MM/AA">
										</div>
										<div class="col-md-6 mb-3">
											<label class="form-label">Código CVV</label>
											<div class="input-group">
												<input type="text" class="form-control" placeholder="123">
												<span class="input-group-text" data-bs-toggle="tooltip"
													title="Los 3 dígitos en el reverso de tu tarjeta"> <i
													class="fas fa-question-circle"></i>
												</span>
											</div>
										</div>
									</div>
									<div class="mb-3">
										<label class="form-label">Nombre en la Tarjeta</label> <input
											type="text" class="form-control"
											placeholder="Como aparece en la tarjeta">
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-4">
						<div class="card mb-4 animate__animated animate__fadeInRight">
							<div class="card-header">
								<i class="fas fa-receipt me-2"></i>Resumen de Pago
							</div>
							<div class="card-body">
								<div class="summary-item">
									<h6 class="text-uppercase text-muted small fw-bold">Subtotal</h6>
									<h5 class="fw-bold">
										S/.
										<%=String.format("%.2f", subtotal)%></h5>
								</div>

								<div class="summary-item">
									<h6 class="text-uppercase text-muted small fw-bold">Descuento</h6>
									<h5 class="fw-bold">
										S/.
										<%=String.format("%.2f", descuento)%></h5>
								</div>

								<div class="total-box mt-4 mb-3">
									<h6 class="text-uppercase text-muted small fw-bold">Total
										a Pagar</h6>
									<h3 class="fw-bold text-primary">
										S/.
										<%=String.format("%.2f", total)%></h3>
								</div>

								<div class="d-grid">
									<button type="button" class="btn btn-primary btn-lg"
										onclick="procesarPago()">
										<i class="fas fa-lock me-2"></i>Confirmar y Pagar
									</button>
								</div>

								<div class="text-center mt-3">
									<small class="text-muted"> <i class="fas fa-lock me-1"></i>
										Tu información está protegida con encriptación SSL
									</small>
								</div>
							</div>
						</div>

						<div
							class="card animate__animated animate__fadeInRight animate__delay-1s">
							<div class="card-header bg-success text-white">
								<i class="fas fa-shield-alt me-2"></i>Pago Seguro
							</div>
							<div class="card-body text-center">
								<img src="https://cdn-icons-png.flaticon.com/512/545/545680.png"
									alt="SSL Secure" class="img-fluid mb-3" style="height: 40px;">
								<p class="small">Todos los pagos están procesados de forma
									segura. No almacenamos los detalles de tu tarjeta.</p>
								<div class="d-flex justify-content-around">
									<img
										src="https://cdn-icons-png.flaticon.com/512/196/196578.png"
										alt="Visa" style="height: 25px;"> <img
										src="https://cdn-icons-png.flaticon.com/512/196/196561.png"
										alt="Mastercard" style="height: 25px;"> <img
										src="https://cdn-icons-png.flaticon.com/512/174/174861.png"
										alt="PayPal" style="height: 25px;">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<% } %>

	<div id="paymentModal" class="modal fade" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-body text-center p-5">
					<div class="spinner-border text-primary mb-4" role="status"
						style="width: 4rem; height: 4rem;">
						<span class="visually-hidden">Procesando...</span>
					</div>
					<h3 class="mb-3">Procesando tu pago</h3>
					<p class="text-muted">Por favor no cierres esta ventana. Esto
						puede tomar unos segundos.</p>
				</div>
			</div>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
	<script>
    $(document).ready(function() {
        $('input[name="pago"]').change(function() {
            if ($(this).val() === 'tarjeta') {
                $('#tarjetaDetails').addClass('animate__fadeIn').show();
            } else {
                $('#tarjetaDetails').hide();
            }
        });
        
        $('.payment-option').click(function() {
            $('.payment-option').removeClass('active');
            $(this).addClass('active');
            $(this).find('input[type="radio"]').prop('checked', true);
        });
        
        $('[data-bs-toggle="tooltip"]').tooltip();
    });
    
    function procesarPago() {
        const metodoPago = document.querySelector('input[name="pago"]:checked').value;
        const fechaActual = new Date().toISOString().split('T')[0];
        
        var modal = new bootstrap.Modal(document.getElementById('paymentModal'));
        modal.show();
        
        const formData = new URLSearchParams();
        formData.append('metodoPago', metodoPago);
        formData.append('fechaPago', fechaActual);
        
        fetch('IndexServlet?metodo=procesarPago', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: formData
        })
        .then(response => {
            if (response.status === 401) {
                window.location.href = "login.jsp";
                return Promise.reject('No autorizado');
            } else if (!response.ok) {
                return Promise.reject('Error en la respuesta del servidor');
            }
            return response.json();
        })
        .then(data => {
            setTimeout(() => {
                modal.hide();
                
                Swal.fire({
                    title: data.status === "success" ? '¡Pago Exitoso!' : 'Error',
                    text: data.message, 
                    icon: data.status === "success" ? 'success' : 'error',
                    confirmButtonText: 'Aceptar',
                    confirmButtonColor: data.status === "success" ? '#4e73df' : '#e74a3b',
                    willClose: () => {
                        if(data.status === "success") {
                            window.location.href = 'index.jsp';
                        }
                    }
                });
            }, 3000);
        })
        .catch(error => {
            console.error("Error al procesar el pago:", error);
            modal.hide();
            Swal.fire({
                title: 'Error',
                text: 'Hubo un problema al procesar la solicitud. Intenta nuevamente más tarde.',
                icon: 'error',
                confirmButtonText: 'Aceptar',
                confirmButtonColor: '#e74a3b'
            });
        });
    }
    


</script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
