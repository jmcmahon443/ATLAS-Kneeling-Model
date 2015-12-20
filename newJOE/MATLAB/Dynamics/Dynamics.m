function[] = Dynamics( TimeStep )
    addpath('R:\MATLAB\Kinematics');

    global q qd;
    global data;
    global C;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;

    SymbolicKinematics();

    % Jacobians
    for i = 1:length( LFootRFoot )
        A = vpa(jacobian( [LFootRFoot(i).X, LFootRFoot(i).Y, LFootRFoot(i).Z], q ));
        B = [ zeros(1, 20); zeros(1, 20); ones(1, 20) ];
        LFootRFoot(i).J = [ A; B ];
        LFootRFoot(i).V = LFootRFoot(i).J*qd';
        
        Acom = vpa(jacobian( [LFootRFoot(i).ComPosX, LFootRFoot(i).ComPosY, LFootRFoot(i).ComPosZ], q ));
        Bcom = [ zeros(1, 20); zeros(1, 20); ones(1, 20) ];
        LFootRFoot(i).Jcom = [ Acom; Bcom ];
        LFootRFoot(i).Vcom = LFootRFoot(i).Jcom*qd';        
    end
    % Populate I
    for i = 1:length( LFootRFoot )
        LFootRFoot(i).I = data(MapJoint(LFootRFoot(i).name).I;
    end
    % Lagrangians
    for i = 1:length( LFootRFoot )
        K = 0.5*LFootRFoot(i).mass*norm(LFootRFoot(i).Vcom)^2;
        Krot=0.5*LFootRFoot(i).I*norm(qd(i))^2;
        P = LFootRFoot(i).mass*9.81*LFootRFoot(i).ComPosZ;
        LFootRFoot(i).L = K + Krot - P;
    end
    % Generalized Joint Torques
    syms t;
    for i = 1:length( LFootRFoot )
        tau = 0;
        for j = 1:length(q)
            d_qd = diff(LFootRFoot(i).L,qd(j));
            qs = sym('qs(t)');
            d_qd = subs(d_qd,q(j),qs);

            new_tau = diff(d_qd,t)-diff(LFootRFoot(i).L,q(j));
            tau = tau + new_tau;
        end
        LFootRFoot(i).tau = tau;
    end
end