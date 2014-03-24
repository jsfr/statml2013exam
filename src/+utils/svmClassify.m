function C = svmClassify(params, trainData, heldOut)
    libsvmpath = 'libsvm-3.17/matlab'; % If libsvm lies somewhere else change this
    addpath(libsvmpath);
    
    flags = ['-c ' num2str(params(1)) ' -g ' num2str(params(2)) ' -q'];
    model = svmtrain(trainData(:,end), trainData(:,1:end-1), flags);
    C = svmpredict(heldOut(:, end), heldOut(:, 1:end-1), model, '-q');
end