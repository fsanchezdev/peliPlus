<a class="btn btn-danger" href="<?php echo base_url() ?>core/dashboard/movie_save">
    <i class="fa fa-plus"></i> Crear
</a>
<br><br>
<table class="table">
    <thead>
        <tr>
           <!-- <th scope="col">#</th>-->
            <th scope="col">Nombre</th>
            <th scope="col">Año</th>
            <th scope="col">Imagen</th>
            <th scope="col">Tipo de película</th>
            <th scope="col">Acciones</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($movies as $key => $movie) : ?>
            <tr>
             <!--   <th scope = "row"><?php echo $movie->movie_id ?></th>-->
                <td><?php echo $movie->name ?></td>
                <td><?php echo $movie->year ?></td>
                <td>
                    <?php if ($movie->image != ""): ?>
                        <img class="img-small-2" src="<?php echo base_url() ?>uploads/movies/<?php echo $movie->image ?>">
                    <?php endif; ?>
                </td>
                <td><?php echo $movie->type_movie ?></td>
                <td>
                    <a target="_blank" class="btn btn-primary btn-sm" href="<?php echo base_url() ?>core/dashboard/movie_show/<?php echo $movie->movie_id ?>">
                        <i class="fa fa-eye"></i>
                    </a>
                     <span data-toggle="modal" data-target="#delete-modal" data-id="<?php echo $movie->movie_id ?>" data-name="<?php echo $movie->name ?>" class="btn btn-danger btn-sm">
                        <i class="fa fa-trash text-light"></i>
                    </span>
                    <a class="btn btn-primary btn-sm" href="<?php echo base_url() ?>core/dashboard/movie_save/<?php echo $movie->movie_id ?>">
                        <i class="fa fa-pencil-alt"></i>
                    </a>
                </td>
            </tr>
        <?php endforeach;
        ?>
    </tbody>
</table>






<!-- Modal -->
<div class="modal fade" id="delete-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Borrar:&nbsp; <span></span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        ¿Seguro que deseas borrar el registro seleccionado?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
        <button type="button" id="bdelete-record" class="btn btn-danger">Borrar</button>
      </div>
    </div>
  </div>
</div>

 <!--<script src="<?php echo base_url() ?>assets/core/js/delete.js" ></script>-->


<script>
    //delete in the modal
 let button
 let id
 let modal =$('#delete-modal')

     
modal.on('show.bs.modal', function (event) {
   button = $(event.relatedTarget) // Button that triggered the modal
  let name = button.data('name')
   id = button.data('id')
  
  modal.find('.modal-title span').text(name)
})

$("#bdelete-record").click(function(){
    $.ajax({
        
   
  url: "movie_delete/"+id
}).done(function() {
  $(button).parent().parent().remove()
  modal.modal('toggle')
});
})
</script>



