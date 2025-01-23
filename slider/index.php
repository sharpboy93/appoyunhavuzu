<?php
require_once('../model/Slider.php');
$slider = new Slider();
$records = $slider->mightyGetRecord();
?>

<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12">
            <div class="d-flex flex-wrap align-items-center justify-content-between mb-4">
                <div>
                    <h4 class="mb-3">Slider List</h4>
                </div>
                <a href="index.php?page=slider_create" class="btn btn-primary add-list"><i class="las la-plus mr-3"></i>Add Slider</a>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="table-responsive rounded mb-3">
                <table class="data-table table mb-0 tbl-server-info">
                    <thead class="bg-white text-uppercase">
                        <tr class="ligth ligth-data">
                            <th>Image</th>
                            <th>Title</th>
                            <th>URL</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody class="ligth-body">
                        <?php foreach ($records as $record) { ?>
                            <tr>
                                <td>
                                    <img src="../upload/slider/<?= $record['image'] ?>" class="img-fluid avatar-50 rounded" alt="author-profile">
                                </td>
                                <td><?= $record['title'] ?></td>
                                <td><?= $record['url'] ?></td>
                                <td><?= $record['status'] == 1 ? 'Active' : 'Inactive' ?></td>
                                <td>
                                    <div class="d-flex align-items-center list-action">
                                        <a class="badge bg-success mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="Edit"
                                            href="index.php?page=slider_create&id=<?= $record['id'] ?>"><i class="ri-pencil-line mr-0"></i></a>
                                        <a class="badge bg-warning mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="Delete"
                                            href="index.php?page=slider_delete&id=<?= $record['id'] ?>" onclick="return confirm('Are you sure you want to delete this item?')"><i class="ri-delete-bin-line mr-0"></i></a>
                                    </div>
                                </td>
                            </tr>
                        <?php } ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
