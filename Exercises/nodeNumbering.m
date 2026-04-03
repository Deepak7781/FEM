% =========================================================================
%  line_nodes.m
%  Draws a horizontal line, divides it into N equal segments, plots and
%  labels each node with its number.
% =========================================================================

clear; clc; close all;

% -------------------------------------------------------------------------
%  USER INPUT
% -------------------------------------------------------------------------
N = 11;          % Number of segments  (nodes = N+1, labelled 1 to N+1)

% Line end-points
x_start = 0;
x_end   = 1;
y       = 0;    % constant y (horizontal line)

% -------------------------------------------------------------------------
%  COMPUTE NODE POSITIONS
% -------------------------------------------------------------------------
x_nodes = linspace(x_start, x_end, N + 1);   % N+1 equally spaced nodes
y_nodes = y * ones(1, N + 1);

% -------------------------------------------------------------------------
%  PLOT
% -------------------------------------------------------------------------
figure('Name', 'Line with N Segments', 'NumberTitle', 'off', ...
       'Color', 'white', 'Position', [100 100 900 350]);

hold on;

% --- Draw the line -------------------------------------------------------
plot([x_start x_end], [y y], '-', ...
     'Color',     [0.15 0.35 0.65], ...
     'LineWidth', 2.5);

% --- Draw segment markers (tick marks) -----------------------------------
tick_half = 0.035;                              % half-height of tick mark
for k = 1 : N + 1
    plot([x_nodes(k) x_nodes(k)], ...
         [y - tick_half, y + tick_half], '-', ...
         'Color',     [0.15 0.35 0.65], ...
         'LineWidth', 1.5);
end

% --- Plot nodes as filled circles ----------------------------------------
scatter(x_nodes, y_nodes, 80, ...
        'MarkerFaceColor', [0.95 0.45 0.10], ...
        'MarkerEdgeColor', 'white', ...
        'LineWidth',       1.2);

% --- Label each node -----------------------------------------------------
label_offset = 0.06;                            % vertical offset for text

for k = 1 : N + 1
    text(x_nodes(k), y + label_offset, ...
         sprintf('Node %d', k), ...
         'HorizontalAlignment', 'center', ...
         'VerticalAlignment',   'bottom', ...
         'FontSize',            10, ...
         'FontWeight',          'bold', ...
         'Color',               [0.15 0.35 0.65]);
end

% --- Label the segments in between ---------------------------------------
for k = 1 : N
    x_mid = (x_nodes(k) + x_nodes(k+1)) / 2;
    text(x_mid, y - label_offset, ...
         sprintf('Seg %d', k), ...
         'HorizontalAlignment', 'center', ...
         'VerticalAlignment',   'top', ...
         'FontSize',            9, ...
         'Color',               [0.50 0.50 0.50]);
end

% --- Axes and title ------------------------------------------------------
title(sprintf('Line divided into N = %d equal segments  (%d nodes)', N, N+1), ...
      'FontSize', 13, 'FontWeight', 'bold');
xlabel('Position along line', 'FontSize', 11);

axis([-0.05  1.05  -0.35  0.35]);
axis off;
box  off;

hold off;