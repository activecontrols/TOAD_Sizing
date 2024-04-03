function x_dot = systemDynamics(t, x, altitude_waypoints, throttle_models, m_dry)
    r = x(1);
    v = x(2);
    m = x(3);

    r_ref = interp1(altitude_waypoints(:, 1), altitude_waypoints(:, 2), t);
    throttle = -.5*(r - r_ref);

    if throttle <= 0.4
        throttle = 0.4;
    elseif throttle >= 1
        throttle = 1;
    end

    T = interp1(throttle_models(:, 1), throttle_models(:, 2), throttle);
    m_dot = -1*interp1(throttle_models(:, 1), throttle_models(:, 3), throttle);
    
    if (m <= m_dry)
        T = 0;
        m_dot = 0;
    end

    r_dot = v;
    v_dot = T/m - 9.81;
    
    x_dot = [r_dot; v_dot; m_dot];
end

