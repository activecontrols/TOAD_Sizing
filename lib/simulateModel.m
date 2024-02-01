function history = simulateModel(m_0, m_dry, altitude_waypoints, throttle_models)
    opts = odeset('RelTol', 1e-12, 'AbsTol', 1e-12);
    x_0 = [altitude_waypoints(1, 2); 0; m_0];
    t = linspace(altitude_waypoints(1, 1), altitude_waypoints(end, 1), 10000)';
    [~, x_hist] = ode45(@(t, x) systemDynamics(t, x, altitude_waypoints, ...
                    throttle_models, m_dry), t, ...
                    x_0, opts);
    history = [t, x_hist, interp1(altitude_waypoints(:, 1), ...
                                    altitude_waypoints(:, 2), t)];
end