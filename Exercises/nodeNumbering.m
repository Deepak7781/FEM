N = 5;

x = linspace(6, 16, N+1);
y = 12 * ones(N+1,1);

plot(x, y, 'o-', 'Color', 'white');
hold on


for i = 1:length(x)
    text(x(i), y(i)+0.5, num2str(i), 'HorizontalAlignment','center','FontSize', 10, 'Color', 'blue');
end

axis([0 20 0 20]);


hold off