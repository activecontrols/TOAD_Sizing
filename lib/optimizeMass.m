function [m_propellant, guess_history, t_set, x_set, x_ref] = optimizeMass(altitude_waypoints, m_inert, m_minimum)
    max_iterations = 100;
    low_bound = 0;
    high_bound = m_inert*2;
    guess_k = high_bound;
    guess_k_minus_1 = 0;
    diff = guess_k - guess_k_minus_1;
    convergence_threshold = 0.00001;
    guess_history = -ones(max_iterations, 1);
    convergence_factor = 0.5;
    
    i = 1;
    while (i < max_iterations) && (abs(diff)/guess_k > convergence_threshold)
        guess_history(i) = guess_k;
        sim_input = assignInModel(altitude_waypoints, m_inert, guess_k);
        [t_set, x_set, x_ref] = simulateModel(sim_input);
        m_final = x_set(end, 3);
        if (m_final < m_minimum)
            low_bound = guess_k;
        else
            high_bound = guess_k;
        end
        guess_k_minus_1 = guess_k;
        guess_k = convergence_factor*low_bound + (1 - convergence_factor)*high_bound;
        diff = guess_k - guess_k_minus_1;
        i = i + 1;
        convergence_factor = convergence_factor / 1.1;
    end
    guess_history = guess_history(guess_history > 0);
    m_propellant = guess_history(end);
end
