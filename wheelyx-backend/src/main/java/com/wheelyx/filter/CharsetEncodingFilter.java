package com.wheelyx.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

import java.io.IOException;

@WebFilter(filterName = "CharsetEncodingFilter", urlPatterns = {"/*"})
public class CharsetEncodingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");
        chain.doFilter(req, res);
    }
}
