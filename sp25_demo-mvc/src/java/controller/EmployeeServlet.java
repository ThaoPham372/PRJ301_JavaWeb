
package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Employee;
import service.EmployeeService;
import service.EmployeeServiceImpl;

@WebServlet (name="EmployeeServlet", urlPatterns={"/employees"})
public class EmployeeServlet extends HttpServlet {
    private EmployeeService employeeService = new EmployeeServiceImpl();        
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                showCreateForm(request,response);
                break;
            case "edit" :
                showEditForm(request, response);
                break;
            case "delete":
                deleteEmp(request, response);
                break;
            default:
                listEmployees (request,response);
                break;
        }
    }
    
   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "create":
                createEmp(request, response);
                break;
            case "edit":
                updateEmp(request, response);
                break;
            default:
                listEmployees(request, response);
                break;
        }
    }
    
    // List employees
    private void listEmployees (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List <Employee> emplist = employeeService.findAll();
        request.setAttribute("employees", emplist);
        RequestDispatcher dispatcher = request.getRequestDispatcher("employee/listEmp.jsp");
        dispatcher.forward(request, response);
    }
    
    // Show create form
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    RequestDispatcher dispatcher = request.getRequestDispatcher("employee/createEmp.jsp");
    dispatcher.forward(request, response);
}
    // Create employee
    private void createEmp(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        Employee newEmp = new Employee(id, name, email, address);
        employeeService.save(newEmp);

    response.sendRedirect("employees");
    }
    
    // Show edit form
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    int id = Integer.parseInt(request.getParameter("id"));
    Employee existingEmp = employeeService.findById(id);
    request.setAttribute("emp", existingEmp);
    RequestDispatcher dispatcher = request.getRequestDispatcher("employee/editEmp.jsp");
    dispatcher.forward(request, response);
}
    
    // Update employees
    private void updateEmp(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        Employee emp = new Employee(id, name, email, address);
        employeeService.update(id, emp);

        response.sendRedirect("employees");
    }
    
    // Delete Employee
    private void deleteEmp(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    int id = Integer.parseInt(request.getParameter("id"));
    employeeService.remove(id);
    response.sendRedirect("employees");
    }
}

