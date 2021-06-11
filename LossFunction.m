function loss = LossFunction(yHat, y)
    loss = 0;
    for i=1:length(yHat)
        if y(i) ~= yHat(i)
            loss = loss + 1;
        end
    end
end