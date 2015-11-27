addpath('R:\Atlas\ATLAS-Kneeling-Model\MATLAB\Kinematics');
% addpath('R:\Atlas\ATLAS-Kneeling-Model\MATLAB\Dynamics');

% Make sure you check your local address of file on addpath

global q ;
global LFootRFoot;
global PelvisTorso;
global TorsoLArm;
global TorsoRArm;

run('q1.m');
% run('Data.m');
TimeIncrement = 1;

PositionKinematics();
Positions;
% LinkCentersofMasses();
% AngularVelocities();
% AngularAccelerations();
% ForwardRecursion();
% Radii();
% BackwardRecursion();
% Torques();
% Pressure();