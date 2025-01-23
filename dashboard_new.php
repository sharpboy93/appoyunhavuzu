<?php
    require('../model/AppSetting.php');
    require('../model/Category.php');
    require('../model/Game.php');
    
    $master_array = [];

    $appsetting = new AppSetting();
    $appsetting_records = $appsetting->mightyQuery("SELECT * FROM `app_settings`");
    
    if($appsetting_records->num_rows > 0){
        foreach( $appsetting_records as $k => $val ){
            $value = json_decode($val['value']);
            $master_array[$val['key']] = $value;
        }
    }
    
    $apiconfiguration = $appsetting->mightyGetByKey('apiconfiguration');
    $value = isset($apiconfiguration) ? json_decode($apiconfiguration['value']) : null;
    $limit = isset($value) ? $value->limit : 10;

    $category_order = isset($value) ? $value->category_order : 'ASC';
    $category_orderby = isset($value) ? $value->category_orderby : 'id';

    // Slider'ı boş dizi olarak ayarla
    $master_array['slider'] = [];
    
    $game_order = isset($value) && isset($value->game_order) ? $value->game_order : 'ASC';
    $game_orderby = isset($value) && isset($value->game_orderby) ? $value->game_orderby : 'id';

    $game = new Game();

    $featured_game = $game->mightyGetRecords([ 'is_featured' => 1, 'order' => $game_order, 'order_by' => $game_orderby ]);
    $master_array['featured_game'] = $featured_game;

    $latest_game = $game->mightyGetRecords(['order' => 'DESC', 'order_by' => 'id' ]);
    $master_array['latest_game'] = $latest_game;

    $category = new Category();
    $category_record = $category->mightyGetRecords( ['order' => $category_order, 'order_by' => $category_orderby ] );
    $category_list = [];
    foreach ($category_record as $key => $value) {
        $value['game'] = [];
        $value['game'] = $game->mightyGetRecords([ 'category_id' => $value['id'], 'order' => $game_order, 'order_by' => $game_orderby ]);
        $category_list[] = $value;
    }

    $master_array['category'] = $category_list;
    header('Content-Type: application/json; charset=utf-8');
    $newJsonString = json_encode($master_array, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE );
    http_response_code(200);
    echo $newJsonString;
    die;
?>
