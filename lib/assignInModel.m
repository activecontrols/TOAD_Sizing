function sim_input = assignInModel(altitude_waypoints, m_inert, m_propellant)
    model = "TOAD_1DOF_model";
    load_system(model);
    workspace = get_param(model, 'modelworkspace');
    
    time = linspace(altitude_waypoints(1, 1), altitude_waypoints(end, 1), 1000)';
    
    altitude = interp1(altitude_waypoints(:, 1), altitude_waypoints(:, 2), time);
    workspace.assignin('reference_trajectory', [time, altitude]);
    workspace.assignin('m_inert', m_inert);
    workspace.assignin('m_propellant', m_propellant);
    workspace.assignin('K', getControlGain(m_inert));
    save_system(model);

    sim_input = Simulink.SimulationInput(model);
end

