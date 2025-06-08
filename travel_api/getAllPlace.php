<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$conn = new mysqli("localhost", "root", "", "travel_app");

if ($conn->connect_error) {
    die(json_encode(["error" => "Connection failed"]));
}

$sql = "SELECT * FROM places";
$result = $conn->query($sql);

$places = [];

while ($row = $result->fetch_assoc()) {
    $places[] = $row;
}

echo json_encode($places);

$conn->close();
?>
