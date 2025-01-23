<?php
$servername = "localhost";
$username = "oyunhavu_admin";
$password = "MO4lyV9Kf)m=";
$dbname = "oyunhavu_app";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Check if slider table exists
    $stmt = $conn->prepare("SHOW TABLES LIKE 'slider'");
    $stmt->execute();
    $tableExists = $stmt->rowCount() > 0;
    
    if ($tableExists) {
        echo "Slider table exists\n";
        
        // Get table structure
        $stmt = $conn->prepare("DESCRIBE slider");
        $stmt->execute();
        $structure = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo "\nTable structure:\n";
        print_r($structure);
        
        // Get table content
        $stmt = $conn->prepare("SELECT * FROM slider");
        $stmt->execute();
        $content = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo "\nTable content:\n";
        print_r($content);
    } else {
        echo "Slider table does not exist\n";
        
        // Create slider table
        $sql = "CREATE TABLE `slider` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `title` varchar(255) NOT NULL,
            `image` varchar(255) NOT NULL,
            `game_id` int(11) DEFAULT NULL,
            `active` tinyint(1) DEFAULT 1,
            PRIMARY KEY (`id`)
        )";
        
        $conn->exec($sql);
        echo "Slider table created successfully\n";
    }
    
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}

$conn = null;
?>
