% ComputeEnergy - Program to compute kinetic and potential energy
% for a particle acted on by a conservative force       

%@ Function to calculate and plot the kinetic and potential energy of
% a particle over time, given certain initial parameters from the App UI.
function ComputeEnergy(app)

    %@ Initialize variables
    k = app.kEditField.Value;                                               % Kappa coefficient (N/m)
    q = app.qEditField.Value;                                               % q coefficient (N/m^3)
    m = app.mEditField.Value;                                               % Mass (kg)
    v = app.vEditField.Value;                                               % Velocity (m/s)
    x = app.xEditField.Value;                                               % Displacement (m)
    t = app.tEditField.Value;                                               % Total time (s)

    %@ Read kinetic and potential energy check boxes' values to 
    % determine whether to show the respective plots
    KEVisibility = app.KECheckBox.Value;                                    % Visibility of kinetic energy plot
    PEVisibility = app.PECheckBox.Value;                                    % Visibility of potential energy plot

    %@ Set up plot of kinetic and potential energy versus time
    axes = app.UIAxes;                                                      % Access the UIAxes object
    cla(axes);                                                              % Clear axes
    xlabel(axes, 'Time (s)');                                               % x-axis label                                      
    ylabel(axes, 'Energy (J)');                                             % y-axis label
    grid(axes, 'on');                                                       % Display grid line
    hold(axes, 'on');                                                       % Hold the plot on screen

    %@ Set up variables to control the number of time steps
    nStep = 300;                                                            % Number of time steps
    dt = t/(nStep-1);                                                       % Time step (s)

    %@ Create arrays to store equally spaced time values,
    % the kinetic and potential energy values for the plot(s)
    T = 0:dt:t;                                                             % Array of time values
    KE = zeros(1, nStep);                                                   % Array of kinetic energy values
    PE = zeros(1, nStep);                                                   % Array of potential energy values

    %@ Loop for desired number of steps
    for i = 1:nStep

        %@ Compute kinetic and potential energy
        KEnergy = 0.5 * m * v ^ 2;                                          % Kinetic energy    
        PEnergy = -0.5 * k * x ^ 2 + q * x ^ 4;                             % Potential energy

        %@ Store kinetic and potential energy values in their array
        KE(i) = KEnergy;
        PE(i) = PEnergy;
    
        %@ Compute force and acceleration
        F = k * x - 4 * q * x ^ 3;                                          % Force
        a = F / m;                                                          % Acceleration

        %@ Update position and velocity using Euler-Cromer
        v = v + a * dt;                                                     
        x = x + v * dt;                                                    
    end
    
    %@ Check if kinetic energy plot is visible
    if KEVisibility
        plot(axes, T, KE, 'Color', 'red', 'LineWidth', 1.5, 'DisplayName', 'KE');
    end

    %@ Check if potential energy plot is visible
    if PEVisibility
        plot(axes, T, PE, 'Color', 'blue', 'LineWidth', 1.5, 'DisplayName', 'PE');
    end

    drawnow;                                                                % Draw the plot(s)
    legend(axes, 'Location', 'northeast');                                  % Add legend to the plot(s)
    hold(axes, 'off');                                                      % Release the hold on the plot
end
