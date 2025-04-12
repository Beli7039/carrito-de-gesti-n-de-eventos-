const addToCart=document.querySelectorAll('[data-btn-action="add-btn-cart"]');

const closeModal=document.querySelector('.jsModalCerrar');

addToCart.forEach(btn => {
    
    btn.addEventListener('click', (event) => {
        event.preventDefault();
        const idEvento = btn.getAttribute('data-idevento');
        
        fetch(`IndexServlet?metodo=inscribirse&idevento=${idEvento}`)
            .then(response => {
                if (response.status === 401) {
                    window.location.href = "login.jsp";
                } else {
                    return response.json();
                }
            })
            .then(data => {
                llenarCarrito(data);

            })
            .catch(error => console.error("Error al cargar datos:", error));
    });


});

function llenarCarrito(data) {
	let lista_carrito = document.getElementById("lista_carrito");
	let subtotalElement = document.getElementById("subtotal");
	let descuentoElement = document.getElementById("descuento");
	let totalElement = document.getElementById("total");
	
	lista_carrito.innerHTML = '';
	let subtotal = 0;
	let descuento = 0;

	data.forEach(item => {
		let itemDiv = document.createElement("div");
		itemDiv.classList.add("modal__item");

		let miniaturaDiv = document.createElement("div");
		miniaturaDiv.classList.add("modal__miniatura");
		let img = document.createElement("img");
		img.src = `img/${item.imagen}`;
		img.alt = item.nombre;
		miniaturaDiv.appendChild(img);

		let textoEventoDiv = document.createElement("div");
		textoEventoDiv.classList.add("modal__texto-evento");
		let nombreP = document.createElement("p");
		nombreP.textContent = item.nombre;
		let precioP = document.createElement("p");
		precioP.innerHTML = `<strong>S/. ${item.precio}</strong>`;
		textoEventoDiv.appendChild(nombreP);
		textoEventoDiv.appendChild(precioP);

		let eliminarBtn = document.createElement("button");
		eliminarBtn.classList.add("eliminar-item");
		eliminarBtn.title = "Eliminar";
		eliminarBtn.innerHTML = `<i class="fas fa-trash"></i>`;
		eliminarBtn.onclick = function() {
			eliminarItem(item.idInscripcion);
		};

		itemDiv.appendChild(miniaturaDiv);
		itemDiv.appendChild(textoEventoDiv);
		itemDiv.appendChild(eliminarBtn);

		lista_carrito.appendChild(itemDiv);
		subtotal += parseFloat(item.precio);
	});
	
	let total = subtotal - descuento;

	subtotalElement.textContent = `S/. ${subtotal.toFixed(2)}`;
	descuentoElement.textContent = `S/. ${descuento.toFixed(2)}`;
	totalElement.textContent = `S/. ${total.toFixed(2)}`;
}

//CERRAR EL MODAL
closeModal.addEventListener('click',(event)=>{
    event.target.parentNode.parentNode.classList.remove('active');
})

document.getElementById("seguir_comprando").addEventListener('click',(event)=>{
	event.preventDefault(); 
    const modal = document.getElementById('jsModalCarrito');
    modal.classList.remove('active');
})

//CERRAMOS MODAL CUANDO HACEMOS CLICK FUERA DEL CONTENDINO DEL MODAL
window.onclick = (event)=>{
    const modal=document.querySelector('.modalcarrito.active');

    if(event.target == modal){
        modal.classList.remove('active');
    }
}

document.getElementById("carritoAbrir").addEventListener("click",function(event){
	const nameModal=event.target.getAttribute('data-modal');
    const modal=document.querySelector(nameModal);
    modal.classList.add('active');
});

function eliminarItem(idInscripcion) {
	fetch(`IndexServlet?metodo=eliminarInscripcion&idInscripcion=${idInscripcion}`)
		.then(response => {
			return response.json();
		})
		.then(data => {
			llenarCarrito(data);

		})
		.catch(error => console.error("Error al cargar datos:", error));
}
