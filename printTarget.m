% S? l??ng ?i?m c?n l?y
numPoints = 15;

% Kh?i t?o m?ng l?u tr? t?a ?? c?a c�c ?i?m
points = zeros(numPoints, 2);

% L?y ng?u nhi�n t?a ?? x v� y cho t?ng ?i?m
for i = 1:numPoints
    while true
        x = randi([15 45]);
        y = randi([15 45]);
        
        % T�nh kho?ng c�ch t? ?i?m hi?n t?i ??n c�c ?i?m ?� l?y tr??c ?�
        distances = sqrt(sum((points(1:i-1, :) - [x, y]).^2, 2));
        
        % Ki?m tra ?i?u ki?n v? kho?ng c�ch
        if ~any(distances < 3) && all(distances > 4)
            points(i, :) = [x, y];
            break;
        end
    end
end

% Hi?n th? t?a ?? c?a c�c ?i?m
disp(points);
% V? c�c ?i?m l�n ?? th?
plot(points(:, 1), points(:, 2), 'o');
axis([10 50 10 50]); % ??t gi?i h?n tr?c x v� y

% ??t nh�n cho tr?c x v� y
xlabel('X');
ylabel('Y');

% ??t ti�u ?? cho ?? th?
title('V? c�c ?i?m ng?u nhi�n');
