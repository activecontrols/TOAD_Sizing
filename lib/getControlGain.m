function K = getControlGain(m_inert)
    % syms r_1 r_dot_1 t m u
    % 
    % x = [r_1; r_dot_1; m];
    % x_dot = EOMS(t, x, u, m_inert);
    % Jx = jacobian(x_dot, x);
    % Ju = jacobian(x_dot, u);
    % 
    % x_critical = [0; 0; m_inert + 1e-6];
    % 
    % S = solve(x_dot(3) == 0, u, 'ReturnConditions', true);
    % u_critical = double(S.u(1));
    % 
    % A = double(subs(Jx, [x; u], [x_critical; u_critical]));
    % B = double(subs(Ju, [x; u], [x_critical; u_critical]));
    % Q = eye(size(Jx));
    % R = 1;
    % [K, ~, ~] = lqr(A, B, Q, R);
    % K(3) = 0;
    K = [1, 0, 0];
end

