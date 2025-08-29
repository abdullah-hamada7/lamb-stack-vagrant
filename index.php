<?php
$dbhost = 'localhost:3306';
$dbuser = 'root';
$dbpass = 'root';
$dbname = 'test';

$conn = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);

if (!$conn) {
    die('Connection failed: ' . mysqli_connect_error());
}

$query = 'SELECT * FROM posts';
$result = mysqli_query($conn, $query);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello PHP</title>
</head>
<body>
    <h1>Hello PHP</h1>

    <?php if (mysqli_num_rows($result) > 0): ?>
        <ul>
            <?php while ($row = mysqli_fetch_object($result)): ?>
                <li><?php echo htmlspecialchars($row->post); ?></li>
            <?php endwhile; ?>
        </ul>
    <?php else: ?>
        <p>No posts</p>
    <?php endif; ?>

</body>
</html>

<?php mysqli_close($conn); ?>
