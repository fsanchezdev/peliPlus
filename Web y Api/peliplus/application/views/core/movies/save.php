<?php echo form_open_multipart(); ?>

<?php if ($movie_id !== ""): ?>
<a href="<?php echo base_url() ?>core/dashboard/movie_save" class="btn btn-primary btn-sm mb-4"><i class="fa fa-plus pr-1"></i>Crear</a>
<?php endif; ?>

<?php if (validation_errors() !== ""): ?>
    <div class="alert alert-danger" role="alert">
        <?php echo validation_errors(); ?>
    </div>
<?php endif; ?>


<div class="form-group">
    <?php
    echo form_label('Nombre', 'name');
    $input = array(
        'name' => 'name',
        'value' => $name,
        'class' => 'form-control',
        'placeholder' => "Nombre"
    );
    echo form_input($input)
    ?>
</div>


<div class="form-group">
    <?php
    echo form_label('Descripción', 'description');
    $input = array(
        'name' => 'description',
        'value' => $description,
        'class' => 'form-control',
    );
    echo form_textarea($input)
    ?>
</div>

<div class="form-group">
    <?php
    echo form_label('Año', 'year');
    $input = array(
        'name' => 'year',
        'value' => $year,
        'type' => 'number',
        'class' => 'form-control',
        'placeholder' => "Año"
    );
    echo form_input($input)
    ?>
</div>

<div class="form-group">
    <?php
    echo form_label('Imagen', 'image');
    $input = array(
        'name' => 'image',
        'type' => 'file',
        'class' => 'form-control',
    );
    echo form_input($input)
    ?>
</div>

<div class="form-group">
    <?php
    echo form_label('Tipo', 'type_movie');
    echo form_dropdown('type_movie_id', $types_movie, $type_movie_id,'class="form-control input-lg"');
    ?>
</div>

<?php if ($image != ""): ?>
    <img class="img-small" src="<?php echo base_url() ?>uploads/movies/<?php echo $image ?>">
   <?php echo "<?php echo base_url() ?>core/dashboard/movie_delete_image/$movie_id" ?>
    <a class="text-danger d-block my-3" href="<?php echo base_url() ?>core/dashboard/movie_delete_image/<?php echo $movie_id ?>">Borrar imagen</a>
<?php endif; ?>

<?php echo form_submit('submit', 'Guardar', 'class="btn btn-primary"'); ?>

<?php echo form_close(); ?>