% T?a ?? c�c ?i?m m?c
waypoints = [0, 0; 1, 1; 2, 3; 4, 2; 5, 4];

% T?o ma tr?n tr?ng s? cho c�c ?i?m m?c
numWaypoints = size(waypoints, 1);
weights = zeros(numWaypoints);
for i = 1:numWaypoints
    for j = i+1:numWaypoints
        distance = norm(waypoints(i,:) - waypoints(j,:));
        weights(i, j) = distance;
        weights(j, i) = distance;
    end
end

% T?o ???ng ?i tu?n t? gi?a c�c ?i?m m?c
pathCoordinates = [];
currentNode = [0, 0];
for i = 1:numWaypoints
    % T�m ???ng ?i t? currentNode ??n ?i?m m?c ti?p theo
    [~, path, ~] = graphshortestpath(sparse(weights), find(all(waypoints == currentNode, 2)), i, 'Method', 'Dijkstra');
    
    % Th�m ???ng ?i t? currentNode ??n ?i?m m?c ti?p theo v�o pathCoordinates
    pathCoordinates = [pathCoordinates; waypoints(path, :)];
    
    % C?p nh?t currentNode cho ??n ?i?m m?c ti?p theo
    currentNode = waypoints(i, :);
end

% Hi?n th? ???ng ?i ban ??u
figure;
plot(waypoints(:, 1), waypoints(:, 2), 'bo'); % Hi?n th? c�c ?i?m m?c
hold on;
plot(pathCoordinates(:, 1), pathCoordinates(:, 2), 'r-'); % Hi?n th? ???ng ?i
plot(0, 0, 'ro'); % Hi?n th? v? tr� ban ??u c?a robot
hold off;

% Di chuy?n robot theo path
for i = 1:size(pathCoordinates, 1)
    robotPosition = pathCoordinates(i, :);
    % Hi?n th? v? tr� robot m?i
    figure;
    plot(waypoints(:, 1), waypoints(:, 2), 'bo'); % Hi?n th? c�c ?i?m m?c
    hold on;
    plot(pathCoordinates(:, 1), pathCoordinates(:, 2), 'r-'); % Hi?n th? ???ng ?i
    plot(robotPosition(1), robotPosition(2), 'ro'); % Hi?n th? v? tr� robot m?i
    hold off;
    % T?m d?ng ?? hi?n th? v? tr� robot tr�n ?? th?
    pause(1); % ?i?u ch?nh th?i gian d?ng t�y theo nhu c?u
end
