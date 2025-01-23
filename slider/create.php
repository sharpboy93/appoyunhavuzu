<?php
require_once('../model/Slider.php');
$slider = new Slider();

$id = isset($_GET['id']) ? $_GET['id'] : null;
$record = null;
if ($id !== null) {
    $record = $slider->mightyGetByID($id);
}
?>

<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12">
            <div class="d-flex flex-wrap align-items-center justify-content-between mb-4">
                <div>
                    <h4 class="mb-3"><?= $id === null ? 'Add' : 'Edit' ?> Slider</h4>
                </div>
                <a href="index.php?page=slider" class="btn btn-primary add-list">Back</a>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <form method="post" action="index.php?page=slider_save" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="<?= $id ?>">
                        
                        <div class="form-group">
                            <label>Title</label>
                            <input type="text" class="form-control" name="title" value="<?= isset($record['title']) ? $record['title'] : '' ?>" required>
                        </div>
                        
                        <div class="form-group">
                            <label>URL</label>
                            <input type="text" class="form-control" name="url" value="<?= isset($record['url']) ? $record['url'] : '' ?>">
                        </div>
                        
                        <div class="form-group">
                            <label>Image</label>
                            <?php if (isset($record['image'])) { ?>
                                <div class="mb-2">
                                    <img src="../upload/slider/<?= $record['image'] ?>" style="max-width: 200px;">
                                </div>
                            <?php } ?>
                            <input type="file" class="form-control" name="image" <?= $id === null ? 'required' : '' ?>>
                        </div>
                        
                        <div class="form-group">
                            <label>Status</label>
                            <div class="custom-control custom-switch">
                                <input type="checkbox" class="custom-control-input" name="status" id="status" <?= (!isset($record['status']) || $record['status'] == 1) ? 'checked' : '' ?>>
                                <label class="custom-control-label" for="status">Active</label>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary mr-2">Submit</button>
                        <button type="reset" class="btn btn-danger">Reset</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
