<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Product</title>
</head>
<body>
<h2>Edit Product</h2>

<form action="products?action=update" method="post">
    <input type="hidden" name="id" value="${product.id}"/>

    <table>
        <tr>
            <td>Name:</td>
            <td><input type="text" name="name" value="${product.name}" required/></td>
        </tr>
        <tr>
            <td>Price:</td>
            <td><input type="number" step="0.01" name="price" value="${product.price}" required/></td>
        </tr>
        <tr>
            <td>Description:</td>
            <td><input type="text" name="description" value="${product.description}" required/></td>
        </tr>
        <tr>
            <td>Stock:</td>
            <td><input type="number" name="stock" value="${product.stock}" required/></td>
        </tr>
        <tr>
            <td>Import Date:</td>
            <td><input type="date" name="import_date" 
                       value="${product.importDate.toLocalDateTime().toLocalDate()}" required/></td>
        </tr>
    </table>
    <input type="submit" value="Update"/>
    <a href="products?action=list">Cancel</a>
</form>

</body>
</html>
