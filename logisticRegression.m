function Logistic = logisticRegression(inputFile, testFile)
    inputData = fopen(inputFile,'r');
    line= textscan(inputData,'%d %d %d %s','Delimiter',',');
	height = line{1};
	weight = line{2};
	age = line{3};
	sex = line{4};
    for n = 1:size(sex,1)
		if(strcmp(sex(n),'M'))
			sex_list(n)=1;
		else
			sex_list(n)=0;
		end
    end
	Sex = sex_list';
    values = [height(:,(1)) weight(:,(1)) age(:,(1))];
	type = [Sex(:,(1))];
	fclose(inputData);
	values = [ones(size(values,1),1) values];
	values = double(values);
	theta = [ones(size (values, 2),1)];
    theta(1,1)=theta(1,1).*.5;
	expo = 1+exp(-values*theta);
	numo = ones(size(expo));
	thetaSize = size(theta, 1);
	predict = numo./expo;
	m = size(values,1);
	cost = (type.*log(predict))+((1-type).*log(1-predict));
    Logistic = -(1/m)*sum(cost);
    neg_logistic = -Logistic;
    J_theta = neg_logistic;
	while((Logistic~=0))
       if(J_theta<0)
			break;
       end	
    delta = zeros(1, thetaSize);
        for i = 1:thetaSize
			predict = ones(size(expo))./1+exp(-values*theta);
			S = ((predict)-type).*values(:, [i]);
			delta(i) = [((1/m)* sum(S))];
        end
		delta = delta';
		theta = theta - ((delta).* 0.000001);
		J_theta = neg_logistic;
        cost = (type.*log(predict))+((1-type).*log(1-predict));
        neg_logistic = -(1/m)*sum(cost);
	end
	expo = 1+exp(-values*theta);
	numo = ones(size(expo));
	predict = numo./expo;
    disp('Predictions for training data:')
    disp(predict)
    testData = fopen(testFile,'r');
    line= textscan(testData,'%d %d %d %s','Delimiter',',');
	height = line{1};
	weight = line{2};
	age = line{3};
	sex = line{4};
    for n = 1:size(sex,1)
		if(strcmp(sex(n),'M'))
			sex_list(n)=1;
		else
			sex_list(n)=0;
		end
    end
	Sex = sex_list';
    test_data = [height(:,[1]) weight(:,[1]) age(:,[1])];
	test_value = [Sex(:,[1])];
	fclose(testData);
	test_data = [ones(size(test_data,1),1) test_data];
	test_data = double(test_data);
	expo = 1+exp(-test_data*theta);
	numo = ones(size(expo));
	predict = numo./expo;
	disp('Predictions for the given test data');
    disp(predict);
