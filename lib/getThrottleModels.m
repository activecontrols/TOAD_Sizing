function throttleModels = getThrottleModels()
    raw = readmatrix('./data/AC Throttle Values.xlsx');
    throttleModels = raw(:, [1, 3, 4]);
end

