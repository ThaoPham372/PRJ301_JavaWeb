<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Product</title>
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
            color: #28a745;
            font-size: 26px;
            border: 2px solid #28a745;
            border-radius: 6px;
            background: #e9fce9;
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
        .btn-save {
            background-color: #28a745;
            color: white;
        }
        .btn-save:hover {
            background-color: #218838;
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
    <h2>Add New Product</h2>

    <form action="products?action=insert" method="post">
        <table>
            <tr>
                <td><b>Name:</b></td>
                <td><input type="text" name="name" required/></td>
            </tr>
            <tr>
                <td><b>Price:</b></td>
                <td><input type="number" step="0.01" name="price" required/></td>
            </tr>
            <tr>
                <td><b>Description:</b></td>
                <td><input type="text" name="description" required/></td>
            </tr>
            <tr>
                <td><b>Stock:</b></td>
                <td><input type="number" name="stock" required/></td>
            </tr>
            <tr>
                <td><b>Import Date:</b></td>
                <td><input type="date" name="import_date" required/></td>
            </tr>
        </table>
        <div class="actions">
            <input type="submit" value="💾 Save" class="btn btn-save"/>
            <a href="products?action=list" class="btn btn-cancel">❌ Cancel</a>
        </div>
    </form>
</div>
</body>
</html>
