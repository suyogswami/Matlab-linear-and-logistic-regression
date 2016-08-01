function LinearRegression = linearRegression(inputFile, testFile, order)
	load franke
    inputData = importdata(inputFile);
    if(order==1)
		values = [ones(size(inputData,1),1) inputData(:,[1 2])];
    end
    if(order==2)
		values = [ones(size(inputData,1),1) inputData(:,[1 2]) inputData(:, (1)).^2 inputData(:, (2)).^2 inputData(:, (1)).*inputData(:, (2))];
    end
    if(order==3)
		values = [ones(size(inputData,1),1) inputData(:,[1 2]) inputData(:, (1)).^2 inputData(:, (2)).^2 inputData(:, (1)).*inputData(:, (2)) inputData(:, (1)).^3 inputData(:, (2)).^3 inputData(:, (1)).^2.*inputData(:, (2)) inputData(:, (1)).*inputData(:, (2)).^2];
    end
    if(order==4)
		values = [ones(size(inputData,1),1) inputData(:,[1 2]) inputData(:, (1)).^2 inputData(:, (2)).^2 inputData(:, (1)).*inputData(:, (2)) inputData(:, (1)).^3 inputData(:, (2)).^3 inputData(:, (1)).^2.*inputData(:, (2)) inputData(:, (1)).*inputData(:, (2)).^2 inputData(:, (1)).^4 inputData(:, (2)).^4 inputData(:, (1)).^3.*inputData(:, (2)) inputData(:, (1)).*inputData(:, (2)).^3 inputData(:, (1)).^2.*inputData(:, (2)).^2];	
    end
	type = inputData(:,(3));
	dataSize= size(inputData, 1);
    theta = pinv(values' *values)*values' *type;
    disp('Theta is: ')
    disp(theta)
	predictions = values * theta;
	squaredError = (predictions-type).^2;
	J = (1/(2*dataSize)) * sum(squaredError);
	%disp(J);
	sf = fit([inputData(:,(1)), inputData(:,(2))],predictions,'poly23');
	plot(sf,[inputData(:,(1)), inputData(:,(2))],predictions);
	testData = importdata(testFile);
	if(order==1)
		test_values = [ones(size(testData,1),1) testData(:,[1 2])];
    end
    if(order==2)
		test_values = [ones(size(testData,1),1) testData(:,[1 2]) testData(:, (1)).^2 testData(:, (2)).^2 testData(:, (1)).*testData(:, (2))];
    end
    if(order==3)
		test_values = [ones(size(testData,1),1) testData(:,[1 2]) testData(:, (1)).^2 testData(:, (2)).^2 testData(:, (1)).*testData(:, (2)) testData(:, (1)).^3 testData(:, (2)).^3 testData(:, (1)).^2.*testData(:, (2)) testData(:, (1)).*testData(:, (2)).^2];
    end
    if(order==4)
		test_values = [ones(size(testData,1),1) testData(:,[1 2]) testData(:, (1)).^2 testData(:, (2)).^2 testData(:, (1)).*testData(:, (2)) testData(:, (1)).^3 testData(:, (2)).^3 testData(:, (1)).^2.*testData(:, (2)) testData(:, (1)).*testData(:, (2)).^2 testData(:, (1)).^4 testData(:, (2)).^4 testData(:, (1)).^3.*testData(:, (2)) testData(:, (1)).*testData(:, (2)).^3 testData(:, (1)).^2.*testData(:, (2)).^2];	
    end
    n = size(test_values, 1);
    predict = test_values * theta;
    disp('Prediction over test data');
    disp(predict)
    test_type = testData(:,(3));
	squaredErr = (predict-test_type).^2;
	J = (1/(2*n)) * sum(squaredErr);
	disp('Error function is ');
	disp(J);
	%sf1 = fit([testData(:,(1)), testData(:,(2))],predict,'poly23');
	%plot(sf1,[testData(:,(1)), testData(:,(2))],predict);