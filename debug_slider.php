<?php
require_once('configuration/Database.php');
require_once('model/Slider.php');

class SliderDebug extends Slider {
    function debugSave($field_array, $files = null) {
        // Log the input data
        error_log("Field Array: " . print_r($field_array, true));
        error_log("Files: " . print_r($files, true));
        
        $this->setFields($field_array, $files);
        
        // Log the processed data
        error_log("Title: " . $this->title);
        error_log("URL: " . $this->url);
        error_log("Status: " . $this->status);
        error_log("Image: " . print_r($this->image, true));
        
        try {
            if (isset($this->image) && file_exists($this->image['tmp_name'])) {
                $path = 'upload/slider';
                if (!file_exists($path)) {
                    mkdir($path, 0755, true);
                }
                
                $image = time().'-'.$this->image['name'];
                $fullPath = $path."/".$image;
                
                error_log("Trying to move file to: " . $fullPath);
                if (move_uploaded_file($this->image['tmp_name'], $fullPath)) {
                    error_log("File moved successfully");
                } else {
                    error_log("Failed to move file. Upload error: " . $_FILES['image']['error']);
                    error_log("Target path permissions: " . substr(sprintf('%o', fileperms($path)), -4));
                }
            }
            
            // Build and log the SQL query
            if ($this->id == null) {
                $query = "INSERT INTO slider (title, url, image, status) VALUES (?, ?, ?, ?)";
                $params = [$this->title, $this->url, $image ?? 'default.png', $this->status];
            } else {
                $result = $this->mightyGetByID($this->id);
                $image = isset($image) ? $image : $result['image'];
                $query = "UPDATE slider SET title = ?, url = ?, image = ?, status = ? WHERE id = ?";
                $params = [$this->title, $this->url, $image, $this->status, $this->id];
            }
            
            error_log("SQL Query: " . $query);
            error_log("Parameters: " . print_r($params, true));
            
            // Execute query using PDO
            $stmt = $this->connection->prepare($query);
            $result = $stmt->execute($params);
            error_log("Query execution result: " . ($result ? "Success" : "Failed"));
            
            return $result;
            
        } catch (Exception $e) {
            error_log("Error in slider save: " . $e->getMessage());
            return false;
        }
    }
}

// Create instance and test
$sliderDebug = new SliderDebug();

// Test with sample data
$testData = [
    'title' => 'Test Slider',
    'url' => 'https://example.com',
    'status' => 'on'
];

if (isset($_FILES['image'])) {
    $result = $sliderDebug->debugSave($testData, $_FILES);
    echo "Save result: " . ($result ? "Success" : "Failed");
} else {
    echo "No file uploaded. Please use the form to test.";
}
?>
