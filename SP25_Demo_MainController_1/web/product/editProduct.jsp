<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 500px;
            margin: auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #007bff;
            font-size: 26px;
            border: 2px solid #007bff;
            border-radius: 6px;
            background: #e9f2ff;
            padding: 10px;
        }
        table {
            width: 100%;
            border-spacing: 10px;
        }
        td {
            padding: 6px;
        }
        input[type="text"], input[type="number"], input[type="date"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .actions {
            margin-top: 20px;
            text-align: center;
        }
        .btn {
            display: inline-block;
            padding: 10px 18px;
            font-size: 14px;
            font-weight: bold;
            border-radius: 5px;
            text-decoration: none;
            margin: 0 8px;
            cursor: pointer;
            border: none;
        }
        .btn-update {
            background-color: #007bff;
            color: white;
        }
        .btn-update:hover {
            background-color: #0056b3;
        }
        .btn-cancel {
            background-color: #6c757d;
            color: white;
            text-decoration: none;
        }
        .btn-cancel:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Edit Product</h2>

    <form action="products?action=update" method="post">
        <input type="hidden" name="id" value="${product.id}"/>

        <table>
            <tr>
                <td><b>Name:</b></td>
                <td><input type="text" name="name" value="${product.name}" required/></td>
            </tr>
            <tr>
                <td><b>Price:</b></td>
                <td><input type="number" step="0.01" name="price" value="${product.price}" required/></td>
            </tr>
            <tr>
                <td><b>Description:</b></td>
                <td><input type="text" name="description" value="${product.description}" required/></td>
            </tr>
            <tr>
                <td><b>Stock:</b></td>
                <td><input type="number" name="stock" value="${product.stock}" required/></td>
            </tr>
            <tr>
                <td><b>Import Date:</b></td>
                <td>
                    <input type="date" name="import_date" 
                           value="${product.importDate.toLocalDateTime().toLocalDate()}" required/>
                </td>
            </tr>
        </table>

        <div class="actions">
            <input type="submit" value="💾 Update" class="btn btn-update"/>
            <a href="products?action=list" class="btn btn-cancel">❌ Cancel</a>
        </div>
    </form>
</div>
</body>
</html>
