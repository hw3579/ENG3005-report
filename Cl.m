% Define the data
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

% Preallocate space for CL
CL = zeros(size(angles));

% Calculate CL for each angle
for j = 1:length(angles)
    Cp_u = Cp_values(j, 1:6);
    Cp_l = Cp_values(j, 7:end);
    
    CL_int = 0; % Intermediate sum
    for i = 1:5  % Loop till 5 because we'll consider pairwise values
        CL_int = CL_int + (Cp_l(i+1) + Cp_l(i) - Cp_u(i+1) - Cp_u(i)) * (x_over_c(i+1) - x_over_c(i)) / 2;
    end
    
    CL(j) = CL_int;
end

% Display the results
for j = 1:length(angles)
    fprintf('Angle: %.1f, CL: %.3f\n', angles(j), CL(j));
end

% 绘制图像
figure; % 打开新的图形窗口
plot(angles, -CL, '-o', 'LineWidth', 1.5); % 使用 '-o' 参数来绘制线和标记
xlabel('Angle (degrees)'); % x轴标签
ylabel('$C_L$','Interpreter','latex'); % y轴标签
title('$C_L$ vs Angle',Interpreter='latex'); % 图的标题
grid on; % 打开网格
print('cl.eps', '-depsc');


