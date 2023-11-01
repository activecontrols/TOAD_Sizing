function [t, x_set, x_ref] = simulateModel(sim_input)
    sim_output = sim(sim_input);
    t = sim_output.tout;
    x_set = sim_output.yout(:, 1:3);
    x_ref = sim_output.yout(:, 4:6);
end

