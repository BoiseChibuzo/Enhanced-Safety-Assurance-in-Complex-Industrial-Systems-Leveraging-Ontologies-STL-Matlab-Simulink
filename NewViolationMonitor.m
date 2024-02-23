% Initialize the system and parameters
InitBreach;
u0 = [63.053, 53.98, 24.644, 61.302, 22.21, 40.064, 38.10, 46.534, 47.446, 41.106, 18.114, 50];
Fp_0 = 100;
r_values = [0.351/Fp_0, 3664/Fp_0, 4509/Fp_0, 9.35/Fp_0, 0.337/Fp_0, 25.16/Fp_0, 22.95/Fp_0];
Eadj_0 = 0;
SP17_0 = 20;
load Mode1xInitial;

Ts_base = 0.0005;
Ts_save = 0.001;

% Run the simulation
sim('MultiLoop_mode1');
% setting a new threshold for the stripper liquid level
%set_param('MultiLoop_mode1/TE Plant/TE Code', 'LiquidLevelThreshold', '200');

% Extract simulation results
t1 = tout;  % Assuming 'tout' is the time vector in the simulation
simoutResults = simout(:, [1, 2, 3, 5]);

% Setup for Breach
Bdata = setupBreach(t1, simoutResults);

% Check specifications and respond
%checkAndRespond(Bdata, 'Reactor Pressure', 'alw_[0, 10] (reactorPressure[t] < 200)');
% Reactor Pressure Checks
checkAndRespond(Bdata, 'Reactor Pressure', 'alw_[0, 100] (reactorPressure[t] < 2895)');
checkAndRespond(Bdata, 'Reactor Pressure Alt1', 'ev (reactorPressure[t] > 3000)');
checkAndRespond(Bdata, 'Reactor Pressure Alt2', 'alw (reactorPressure[t] > 2800 and reactorPressure[t] < 2900)');

% Reactor Level Checks
checkAndRespond(Bdata, 'Reactor Level', 'alw (reactorLevel[t] > 50) and alw(reactorLevel[t] < 100)');
checkAndRespond(Bdata, 'Reactor Level Alt1', 'ev (reactorLevel[t] < 45)');
checkAndRespond(Bdata, 'Reactor Level Alt2', 'alw (reactorLevel[t] <= 105)');

% Reactor Temperature Checks
checkAndRespond(Bdata, 'Reactor Temperature', 'alw (reactorTemperature[t] < 150)');
checkAndRespond(Bdata, 'Reactor Temperature Alt', 'alw (reactorTemperature[t] > 120 and reactorTemperature[t] < 150)');

% Stripper Level Checks
checkAndRespond(Bdata, 'Stripper Level', 'alw (stripperLevel[t] > 30) and alw(stripperLevel[t] < 100)');
checkAndRespond(Bdata, 'Stripper Level Alt1', 'alw (stripperLevel[t] >= 25)');
checkAndRespond(Bdata, 'Stripper Level Alt2', 'ev (stripperLevel[t] > 105)');


% ... Add other specification checks ...

% Function definitions

function Bdata = setupBreach(timeVector, simoutResults)
    Bdata = BreachTraceSystem({'reactorPressure', 'reactorLevel', 'reactorTemperature', 'stripperLevel'});
    trace = [timeVector, simoutResults];
    Bdata.AddTrace(trace);
    Bdata.PlotSignals();
end

function checkAndRespond(Bdata, parameter, formula)
    phi = STL_Formula('phi', formula);
    result = Bdata.CheckSpec(phi);
    if result < 0
        logViolation(parameter, formula);
        triggerAlarm(parameter);
    end
end

function logViolation(parameter, formula)
    logFileName = getLogFileName();
    fileID = fopen(logFileName, 'a');
    if fileID == -1
        error('Failed to open log file');
    end
    try
        logMessage = sprintf('Violation detected in %s for formula: %s\n', parameter, formula);
        fprintf(fileID, logMessage);
    catch
        disp('Error while logging the violation.');
    end
    fclose(fileID);
end

function triggerAlarm(parameter)
    disp(['ALARM: Boundary violation detected in ', parameter, '!']);
end

function logFileName = getLogFileName()
    persistent runTimestamp;
    if isempty(runTimestamp)
        runTimestamp = datestr(now, 'yyyy-mm-dd_HH-MM-SS');
    end
    logFileName = sprintf('violation_log_%s.txt', runTimestamp);
end
