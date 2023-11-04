
xx = [0.016 0.071 0.175 0.317 0.510 0.698 0.032 0.119 0.230 0.413 0.603 0.794];
yy = [
0.133	-0.517989727	-0.477510001	-0.497749864	-0.356070823	-0.254871508	-0.194151919	-0.598949179	-0.558469453	-0.396550549	-0.33583096	-0.052472878;
0.94	0.075336003	-0.171241063	-0.253433418	-0.21233724	-0.171241063	-1.280837859	-1.321934036	-1.034260793	-0.664395194	-0.417818128	-0.171241063;
0.9	0.52009266	0.123647466	-0.001545753	-0.064142363	-0.105873436	-2.526275672	-1.858578503	-1.524729919	-0.731839531	-0.43972202	-0.168470045;
0.839	0.663548193	0.200926959	0.074757532	-0.030383658	-0.135524848	-3.079478156	-2.217320402	-1.207964982	-0.703287271	-0.493004892	-0.303750751;
0.818	0.76687557	0.258240451	0.173467931	0.025116022	-0.080849628	-2.963115304	-2.221355755	-1.055733607	-0.589484747	-0.504712228	-0.419939708;
0.859	0.757353123	0.227941756	0.139706528	0.007353686	-0.213234384	-0.8970574	-0.985292628	-0.852939786	-0.764704558	-0.67646933	-0.499998875;
0.9	0.753318078	0.259954233	0.170251716	0.035697941	-0.143707094	-0.59221968	-0.547368421	-0.547368421	-0.547368421	-0.637070938	-0.547368421;
0.92	0.839038926	0.379150144	0.287172388	0.149205753	-0.034749759	-0.54062742	-0.54062742	-0.494638541	-0.517632981	-0.586616298	-0.54062742;

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
    yq_upper_surface = interp1(x_upper_surface, y_upper_surface, xq_upper_surface,'linear');

    xq_lower_surface = linspace(min(x_lower_surface), max(x_lower_surface), 500);
    yq_lower_surface = interp1(x_lower_surface, y_lower_surface, xq_lower_surface,'linear');

    % Plot
    hold on;
    plot(xq_upper_surface, yq_upper_surface, '-', 'LineWidth', 1,'Color','r');   % Plot the upper surface
    plot(xq_lower_surface, yq_lower_surface, '-', 'LineWidth', 1,'Color','black');  % Plot the lower surface
    xlabel(' $x/c$', 'Interpreter', 'latex');    % Label for x-axis
    ylabel(' $C_p$', 'Interpreter', 'latex');  % Label for y-axis
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
    title(['Pressure Distribution- ', angleTitles{i}]);
end

% Save and print the figure
f = gcf;
saveas(f, 'output.fig');
print(f, 'output.eps', '-depsc');
