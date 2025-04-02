
const buscar=document.getElementById("buscar");
const moverInput=document.getElementById("MoviInput");
buscar.addEventListener("click",function()
{
   if(moverInput.classList.contains("mover"))
      {
         moverInput.classList.remove("mover");
         moverInput.value="";//Diseño web corporativo
      }
   else
      moverInput.classList.add("mover");
   //Esto se resume en poner la clase toggle. Si no se utiliza nada lógico dejarla con la clase toggle.
   //Acceder al DOM para eliminar el texto una vez que el usuario vuelva a tocar la lupa.
  });

  moverInput.addEventListener("keydown",(e)=>{
   if(e.key=="Enter")
      {
         alert("La barra de búsqueda está inactiva");
         moverInput.value="";
      }
  })


/*
En una parte de la interfaz simular como si acaso ya existen personas trabajando 
con la empresa de softcore.
*/
let url="https://jsonplaceholder.typicode.com/users";
fetch(url)
.then(resp=>resp.json())
.then(r=>console.table(r))
.catch(err=>console.error("Ups ha ocurrido un pequeño error "+err));
//Los datos existen solo serian modificarlos y colocarlos en la interfaz correcta



  //Validación de caracteres para campos de seguridad

//Manipular el DOM de tal manera que sea 
//posible la interacción con la lupa.

/*Nota:
      Lo que quiero es que la barra se expanda dinamicamente
      tengo dos opciones:
      1->Hacerlo desde el CSS (Esta la miro mas viable)
         Esto es lo que miro mas correcto ya que si deseo
         que solo lo haga cuando este en modo telefono(Responsive)
         sea dinámico y cuando sea en computador no haga nada
      
      2->Hacerlo desde el JS con intervalos de tiempos.
      */