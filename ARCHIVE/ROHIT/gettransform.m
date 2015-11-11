 function [T1,T2,T3] = gettransform() 
% Curr_joints = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] ; 

syms q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12 q13 q14 q15 q16 q17 q18 q19 q20
% Setting up values for DH parameters for references
% q1 = Curr_joints(1); q2 = Curr_joints(2); q3 = Curr_joints(3);q4 = Curr_joints(4);q5 = Curr_joints(5);
% q6 = Curr_joints(6); q7 = Curr_joints(7); q8 = Curr_joints(8);q9 = Curr_joints(9);q10 = Curr_joints(10);
% q11 = Curr_joints(11); q12 = Curr_joints(12);q13 = Curr_joints(13);q14 = Curr_joints(14);q15 = Curr_joints(15);
% q16 = Curr_joints(16); q17 = Curr_joints(17);q18 = Curr_joints(18);q19 = Curr_joints(19);q20 = Curr_joints(20);

d1 = .422;
d2 = sqrt(.05^2+.374^2);
tq2 = atan(.05/.374);
d3 = 0.0225;
d4 = sqrt(.066^2+.05^2);
tq4 = tq2+pi/2-atan(.066/.05);
tq3 = pi/2-atan(0.066/.05);
d5 = 0.089;
d6 = 0.05;
d7 = sqrt(.066^2+.0225^2);
tq6 = pi/2-atan(.0225/0.066);
d8 = d2;
tq8 = tq2;

%DH parameters for legs
d       = vpa([0,0,0,-d3,0,0,0,0,0,d6,0,0,0,0,0],3);
theta   = vpa([q1,q2,q3+tq2,q4-tq4,tq3,q5-pi/2,q6,q7,q8,q9+tq6,pi/2-tq6,q10+tq8,q11-tq8,q12,q13],3);
a       = vpa([0,d1,d2,d4,0,0,-d5,-d5,0,-d7,0,-d8,d1,0,0],3);
alpha   = [pi/2,0,0,0,-pi/2,-pi/2,0,0,pi/2,0,pi/2,0,0,-pi/2,0];
 
% T_identity = [1,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1] ;
      
%DH Table
DHpars = vpa([d;theta;a;alpha],3) ;
    for i = 1:length(d)
        Trans{i}    = dhtransform(DHpars(:,i));              %Generate transform from DHparams
        T_frame{i}  = vpa(Trans{i},3);     
    end

T1 = T_frame ;

%DH parameters for left arm
d_l     = vpa([0.162,0,0.1406,0,-0.245,0],3);
theta_l = vpa([q14,pi/2+q15,q16,pi/2,q19,q20+pi],3);
a_l     = vpa([-0.0125,0,-0.5276,0.2256,0.11,-0.605762],3);
alpha_l = [-pi/2,pi/2,0,-pi/2,pi/2,0]; 

DHpars_l = vpa([d_l;theta_l;a_l;alpha_l],3) ;
    for i = 1:length(d_l)
        Trans{i}     = dhtransform(DHpars_l(:,i));              %Generate transform from DHparams
        T_frame_l{i} = vpa(Trans{i},3);       
    end

T2 = T_frame_l ;

% DH Parameters for right arm

d_r     = vpa([0.162,0,0.1406,0,-0.245,0],3);
theta_r = vpa([q14,pi/2+q15,q16,pi/2,q17,q18],3);
a_r     = vpa([-0.0125,0,-0.5276,-0.2256,-0.11,-0.605762],3);
alpha_r = [-pi/2,pi/2,0,-pi/2,pi/2,0];

DHpars_r = vpa([d_r;theta_r;a_r;alpha_r],3) ;
    for i = 1:length(d_r)
        Trans{i}          = dhtransform(DHpars_r(:,i));              %Generate transform from DHparams
        T_frame_r{i}      = vpa(Trans{i},3);  
    end
T3 = T_frame_r ;
return;
 end