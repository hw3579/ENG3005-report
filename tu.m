
xx = [0.016 0.071 0.175 0.317 0.510 0.698 0.032 0.119 0.230 0.413 0.603 0.794];
yy = [
    0.135 -0.560 -0.613 -0.505 -0.342 -0.162 -0.036 -0.541 -0.559 -0.397 -0.288 -0.072;
    0.852 0.110 -0.203 -0.203 -0.148 -0.074 -1.143 -1.254 -0.996 -0.701 -0.332 -0.111;
    -0.850 0.585 0.208 0.019 0.038 0.019 -2.417 -1.850 -1.510 -0.755 -0.415 -0.113;
    1.000 0.913 0.515 0.258 0.159 0.059 -3.430 -2.617 -1.388 -0.793 -0.396 -0.159;
    0.959 1.019 0.630 0.346 0.203 0.081 -3.619 -2.928 -1.362 -0.773 -0.427 -0.163;
    1.070 1.103 0.723 0.443 0.256 0.093 -0.699 -0.746 -0.746 -0.769 -0.746 -0.653;
    1.099 1.223 0.842 0.570 0.347 0.149 -0.545 -0.594 -0.594 -0.644 -0.644 -0.594;
    1.025 1.340 1.004 0.778 0.477 0.251 -0.351 -0.401 -0.427 -0.452 -0.552 -0.552;
];

angleTitles = {'0°', '5°', '10°', '15°', '17.5°', '20°', '22.5°', '25°'};
f = figure('Units', 'inches', 'Position', [0 0 8.3 11.7]);
for i = 1:8
    % 2x4 subplot configuration.
    row = 1 + floor((i-1)/4); % 1 for plots 1-4, 2 for plots 5-8
    col = mod(i-1, 4) + 1;
    subplot(4, 2, i);


    y=yy(i,:);

    % Add points (0,0) and (1,0) to the data
    x_upper_surface = [0, xx(1:6), 1];
    y_upper_surface = [0, y(1:6), 0];

    x_lower_surface = [0, xx(7:end), 1];
    y_lower_surface = [0, y(7:end), 0];

    % Interpolation for both groups
    xq_upper_surface = linspace(min(x_upper_surface), max(x_upper_surface), 500);
    yq_upper_surface = interp1(x_upper_surface, y_upper_surface, xq_upper_surface, 'pchip');

    xq_lower_surface = linspace(min(x_lower_surface), max(x_lower_surface), 500);
    yq_lower_surface = interp1(x_lower_surface, y_lower_surface, xq_lower_surface, 'pchip');

    % Plot
    hold on;
    plot(xq_upper_surface, yq_upper_surface, '-', 'LineWidth', 1.5);   % Plot the upper surface
    plot(xq_lower_surface, yq_lower_surface, '--', 'LineWidth', 1.5);  % Plot the lower surface
    xlabel('Chord Position $x/c$', 'Interpreter', 'latex');    % Label for x-axis
    ylabel('Pressure Coefficient $C_p$', 'Interpreter', 'latex');  % Label for y-axis
    title('Pressure Distribution Over aerofoil');  % Title for the graph
    legend('Upper Surface','Lower Surface');  % Legends
    grid on;

    % Reverse the y-axis direction to match the graphs and set y-axis limits
    set(gca, 'YDir', 'reverse');
    ylim([-4, 4]);  % Setting y-axis limits

    hold off;
    % Optional: Adjust the x and y ticks for clarity
    xticks([0 0.5 1]);
    yticks([-4:1:4]);
        % Add title from the angleTitles list
    title(['Pressure Distribution Over aerofoil - ', angleTitles{i}]);
end

% Save and print the figure
f = gcf;
saveas(f, 'output.fig');
print(f, 'output.eps', '-depsc');
