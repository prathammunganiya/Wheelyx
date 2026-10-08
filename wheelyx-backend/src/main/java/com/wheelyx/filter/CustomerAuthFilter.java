package com.wheelyx.filter;

import com.wheelyx.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(filterName = "CustomerAuthFilter", urlPatterns = {"/customer/*"})
public class CustomerAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !user.isCustomer()) {
            // Strictly block unauthorized access to customer pages
            response.sendRedirect(request.getContextPath() + "/auth/login?role=customer&error=login_required");
            return;
        }

        chain.doFilter(req, res);
    }
}
