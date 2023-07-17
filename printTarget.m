% S? l??ng ?i?m c?n l?y
numPoints = 15;

% Kh?i t?o m?ng l?u tr? t?a ?? c?a các ?i?m
points = zeros(numPoints, 2);

% L?y ng?u nhiên t?a ?? x và y cho t?ng ?i?m
for i = 1:numPoints
    while true
        x = randi([15 45]);
        y = randi([15 45]);
        
        % Tính kho?ng cách t? ?i?m hi?n t?i ??n các ?i?m ?ã l?y tr??c ?ó
        distances = sqrt(sum((points(1:i-1, :) - [x, y]).^2, 2));
        
        % Ki?m tra ?i?u ki?n v? kho?ng cách
        if ~any(distances < 3) && all(distances > 4)
            points(i, :) = [x, y];
            break;
        end
    end
end

% Hi?n th? t?a ?? c?a các ?i?m
disp(points);
% V? các ?i?m lên ?? th?
plot(points(:, 1), points(:, 2), 'o');
axis([10 50 10 50]); % ??t gi?i h?n tr?c x và y

% ??t nhãn cho tr?c x và y
xlabel('X');
ylabel('Y');

% ??t tiêu ?? cho ?? th?
title('V? các ?i?m ng?u nhiên');
