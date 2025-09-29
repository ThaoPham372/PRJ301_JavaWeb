<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Product</title>
</head>
<body>
<h2>Add New Product</h2>

<form action="products?action=insert" method="post">
    <table>
        <tr>
            <td>Name:</td>
            <td><input type="text" name="name" required/></td>
        </tr>
        <tr>
            <td>Price:</td>
            <td><input type="number" step="0.01" name="price" required/></td>
        </tr>
        <tr>
            <td>Description:</td>
            <td><input type="text" name="description" required/></td>
        </tr>
        <tr>
            <td>Stock:</td>
            <td><input type="number" name="stock" required/></td>
        </tr>
        <tr>
            <td>Import Date:</td>
            <td><input type="date" name="import_date" required/></td>
        </tr>
    </table>
    <input type="submit" value="Save"/>
    <a href="products?action=list">Cancel</a>
</form>

</body>
</html>
