function x_dot = EOMS(t, x, throttle, m_inert)
    raw = readmatrix('./data/AC Throttle Values.xlsx');
    throttle_table = raw(:, 1)*100;
    thrust_table = raw(:, 3);
    massflow_table = raw(:, 4);
    
    r_1 = x(1);
    r_dot_1 = x(2);
    m = x(3);
    
    if isa(x(1), 'double')
        if m > m_inert
            m_dot = throttle2MassFlow(throttle, throttle_table, massflow_table);
            F = throttle2Thrust(throttle, throttle_table, thrust_table);
        else
            m_dot = 0;
            F = 0;
        end
    else
        m_dot = piecewise(m > m_inert, throttle2MassFlow(throttle, throttle_table, massflow_table), m <= m_inert, 0);
        F = piecewise(m > m_inert, throttle2Thrust(throttle, throttle_table, thrust_table), m <= m_inert, 0);
    end

    r_ddot_1 = (1/m)*(F - m*9.81);

    x_dot = [r_dot_1; r_ddot_1; m_dot];
end

function F = throttle2Thrust(throttle, throttle_table, thrust_table)
    F = interp1(throttle_table, thrust_table, throttle);
end

function m_dot = throttle2MassFlow(throttle, throttle_table, massflow_table)
    m_dot = interp1(throttle_table, massflow_table, throttle);
end