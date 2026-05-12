xN = 5;
yN = 5;

x = linspace(6, 16, xN+1);
y = linspace(2, 12, yN+1);

[X, Y] = meshgrid(x, y);

plot(X, Y, 'o', 'Color', 'g', 'MarkerFaceColor','r')   
hold on

for i = 1:size(X,1)
    plot(X(i,:), Y(i,:), 'r-')   % horizontal lines
end

for j = 1:size(X,2)
    plot(X(:,j), Y(:,j), 'r-')   % vertical lines
end


% Diagonal lines (left to right in each cell)
for i = 1:yN
    for j = 1:xN
        %plot([X(i,j) X(i+1,j+1)], [Y(i,j) Y(i+1,j+1)], 'b-')
        plot([X(i+1,j) X(i,j+1)], [Y(i+1,j) Y(i,j+1)], 'g-')
    end
end

% Node numbering
node = 1;
for i = 1:size(X,1)
    for j = 1:size(X,2)
        text(X(i,j)+0.2, Y(i,j)+0.2, num2str(node), ...
            'FontSize', 10, 'Color', 'w');
        node = node + 1;
    end
end

axis([0 20 0 20])
axis equal
grid on
