function [mass_data, history] = optimizeMass(altitude_waypoints, throttle_models, m_inert, f_prop_min)
    max_iterations = 100;
    convergence_threshold = 0.00001;
    convergence_speed = 0.5;

    m_prop_guess = m_inert;
    last_guess = 0;
    high_bound = m_prop_guess*2;
    low_bound = 0;
    
    i = 0;
    while (i < max_iterations) && (abs(m_prop_guess - last_guess)/m_prop_guess > convergence_threshold)
        last_guess = m_prop_guess;
        m_tank = propellantMassToTankMass(m_prop_guess);
        m_0 = m_inert + m_prop_guess + m_tank;
        
        history = simulateModel(m_0, m_inert + m_tank, altitude_waypoints, throttle_models);

        m_final = history(end, 4);
        m_prop_final = m_final - m_inert - m_tank;
        if (m_prop_final < 0) || (m_prop_final / m_final < f_prop_min)
            low_bound = m_prop_guess;
            m_prop_guess = convergence_speed*high_bound + (1 - convergence_speed)*low_bound;
        else
            high_bound = m_prop_guess;
            m_prop_guess = convergence_speed*low_bound + (1 - convergence_speed)*high_bound;
        end
        i = i + 1;
    end

    m_tank = propellantMassToTankMass(m_prop_guess);
    m_0 = m_inert + m_prop_guess + m_tank;

    history = simulateModel(m_0, m_inert + m_tank, altitude_waypoints, throttle_models);

    m_final = history(end, 4);

    mass_data = [m_0, m_prop_guess, m_tank, m_final];
end
