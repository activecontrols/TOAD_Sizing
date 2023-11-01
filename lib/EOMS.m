function x_dot = EOMS(t, x, throttle, m_inert)
    r_1 = x(1);
    r_dot_1 = x(2);
    m = x(3);
    
    if isa(x(1), 'double')
        if m > m_inert
            m_dot = throttle2MassFlow(throttle);
            F = throttle2Thrust(throttle);
        else
            m_dot = 0;
            F = 0;
        end
    else
        m_dot = piecewise(m > m_inert, throttle2MassFlow(throttle), m <= m_inert, 0);
        F = piecewise(m > m_inert, throttle2Thrust(throttle), m <= m_inert, 0);
    end

    r_ddot_1 = (1/m)*(F - m*9.81);

    x_dot = [r_dot_1; r_ddot_1; m_dot];
end

function F = throttle2Thrust(throttle)
    F = 4.44822*(550.02*throttle - 0.01);
end

function m_dot = throttle2MassFlow(throttle)
    m_dot = -0.453592*(2.42*throttle + 0.30);
end