
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
    
    protected void processRequest (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "create":
                break;
            case "edit":
                break;
            case "delete":
                break;
            default:
                listEmployees(request, response);
                break;
        }
        
    }
            
            
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                createEmp(request,response);
                break;
            case "edit" :
                break;
            case "delete":
                break;
            default:
                listEmployees (request,response);
                break;
        }
    }
    
   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    private void listEmployees (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List <Employee> emplist = employeeService.findAll();
        request.setAttribute("employees", emplist);
        RequestDispatcher dispatcher = request.getRequestDispatcher("employee/listEmp.jsp");
        dispatcher.forward(request, response);
    }

    private void createEmp(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("employee/createEmp.jsp");
        dispatcher.forward(request, response);
    }
}

