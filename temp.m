newRow = 1; % Hàng m?i b?n mu?n thêm vào
matrix = [1 2;2 3;3 4;4 5;5 6];
matrix(:,2)
ismember(newRow, matrix(:,2))
% matrix(1, :) = []