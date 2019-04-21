
fpath = 'D:\data';  %this is the path of 5000 images, you can change
flist = dir(sprintf('%s/*.png', fpath));

images = [];%%!!!!!
for imidx = 1: length(flist)
    fprintf('[%d]', imidx); %ÏÔÊ¾½ø³Ì
    fname = sprintf('%s/%s', fpath, flist(imidx).name);
    im = imread(fname);
    im= reshape(im,28*28,1);
    images(imidx,:)=im;
    fprintf('\n');
end


train_feature = [];
test_feature = [];
for i=1:4000
    train_feature(i,:)=images(i,:);
end
for i=4001:5000
    test_feature(i-4000,:)=images(i,:);
end
train_feature=train_feature';
test_feature = test_feature';

%another
load label;

train_label=zeros(4000, 10);
test_label=zeros(1000, 10);
for i=1:4000
    for j=0:9
        if label(i,1) == j
            train_label(i,j+1) = 1
        end
    end
end
for i=1:1000
    for j=0:9
        if label(i+4000,1) == j
            test_label(i,j+1) = 1
        end
    end
end
train_label=train_label';
test_label=test_label';

%% Training (Note: I divide the code of use PCA and don't use PCA with comment)

% % this is the code that don't use PCA (the user can use the "Comment" function in EDITOR to add or delete the comment)
 ann_model=patternnet(26);
 save("ann_model");
 net=ann_model;
 net.trainParam.lr=0.8   % learning rate
 
 [net,tr]=train(net,train_feature,train_label);
 
 y=net(test_feature);
 plotconfusion(test_label,y);
 
 
% %this is the code if use PCA 
%  train_feature=train_feature';
%  [COEFF SCORE latent]=pca(train_feature);
%  pcaData=SCORE(:,1:10);
%  pcaData=pcaData';
%  
%  test_feature=test_feature';
%  [COEFF1 SCORE1 latent1]=pca(test_feature);
%  pcaData1=SCORE1(:,1:10);
%  pcaData1=pcaData1';
%  
%  ann_model=patternnet(26);
%  save("ann_model");
%  net=ann_model;
%  net.trainParam.lr=0.8   %learning rate
%  
%  [net,tr]=train(net,pcaData,train_label);
%  y=net(pcaData1);
%  plotconfusion(test_label,y);