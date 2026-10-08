package com.wheelyx.filter;

import com.wheelyx.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(filterName = "OwnerAuthFilter", urlPatterns = {"/owner/*"})
public class OwnerAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getRequestURI();
        if (path.endsWith("/login") || path.endsWith("/register") || path.endsWith("/login.jsp") || path.endsWith("/register.jsp")) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !user.isOwner()) {
            response.sendRedirect(request.getContextPath() + "/auth/login?role=owner&error=login_required");
            return;
        }

        chain.doFilter(req, res);
    }
}
