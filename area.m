

% Data
angles = [0, 5, 10, 15, 17.5, 20, 22.5, 25];
x_over_c = [0.016, 0.071, 0.175, 0.317, 0.510, 0.698, 0.032, 0.119, 0.230, 0.413, 0.603, 0.794];
Cp_values = [
    0.135, -0.560, -0.613, -0.505, -0.342, -0.162, -0.036, -0.541, -0.559, -0.397, -0.288, -0.072;
    0.852, 0.110, -0.203, -0.203, -0.148, -0.074, -1.143, -1.254, -0.996, -0.701, -0.332, -0.111;
    -0.850, 0.585, 0.208, 0.019, 0.038, 0.019, -2.417, -1.850, -1.510, -0.755, -0.415, -0.113;
    1.000, 0.913, 0.515, 0.258, 0.159, 0.059, -3.430, -2.617, -1.388, -0.793, -0.396, -0.159;
    0.959, 1.019, 0.630, 0.346, 0.203, 0.081, -3.619, -2.928, -1.362, -0.773, -0.427, -0.163;
    1.070, 1.103, 0.723, 0.443, 0.256, 0.093, -0.699, -0.746, -0.746, -0.769, -0.746, -0.653;
    1.099, 1.223, 0.842, 0.570, 0.347, 0.149, -0.545, -0.594, -0.594, -0.644, -0.644, -0.594;
    1.025, 1.340, 1.004, 0.778, 0.477, 0.251, -0.351, -0.401, -0.427, -0.452, -0.552, -0.552;
];

CL = zeros(size(angles));

for idx = 1:length(angles)
    % Split the data for upper and lower surfaces
    x_upper_surface = x_over_c(1:6);
    y_upper_surface = Cp_values(idx, 1:6);
    x_lower_surface = x_over_c(7:end);
    y_lower_surface = Cp_values(idx, 7:end);

    % Spline fit for both groups
    spline_upper = @(x) ppval(spline(x_upper_surface, y_upper_surface), x);
    spline_lower = @(x) ppval(spline(x_lower_surface, y_lower_surface), x);

    % Define the function representing the difference between the upper and lower surface splines
    diff_splines = @(x) spline_upper(x) - spline_lower(x);

    % Calculate the area between the curves using Romberg method
    area_between_curves = romberg(diff_splines, min(x_over_c), max(x_over_c), 4);
    CL(idx) = area_between_curves;
    fprintf('Angle: %.2f, CL: %.4f\n', angles(idx), CL(idx));
end

% Plotting
figure;
plot(angles, CL, '-*','Color','r');
xlabel('Angle (degrees)');
ylabel('CL');
title('CL vs. Angle');

grid on;

function result = romberg(f, a, b, n)
    % f: function to be integrated
    % a, b: integration limits
    % n: number of iterations

    R = zeros(n, n);
    h = b - a;
    
    % Initialize the R(1, 1) entry
    R(1, 1) = h / 2 * (f(a) + f(b));
    
    for j = 2:n
        h = h / 2;
        sum = 0;
        for k = 1:2^(j-2)
            sum = sum + f(a + (2*k-1)*h);
        end
        
        % Trapezoidal rule
        R(j, 1) = 1/2 * R(j-1, 1) + sum * h;
        
        % Richardson extrapolation
        for k = 2:j
            R(j, k) = (4^(k-1) * R(j, k-1) - R(j-1, k-1)) / (4^(k-1) - 1);
        end
    end
    
    result = R(n, n);
end

