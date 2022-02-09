
import keras
import numpy as np
from keras.datasets import mnist
from keras.utils import np_utils
from keras.utils import to_categorical
from keras.models import Sequential, Model, load_model
from keras.layers import Dense, Activation, Convolution2D, MaxPooling2D, Flatten, Input, Dropout
from keras.optimizers import Adam
from sklearn import metrics
import scipy.io as sio


load_xtrain = sio.loadmat('trainFeature.mat')
load_ytrain = sio.loadmat('Y_TrainBaru1.mat')
load_xtest = sio.loadmat('testFeature.mat')
load_ytest = sio.loadmat('Y_TestBaru1.mat')
X_train = load_xtrain['X_TrainData']
Y_train = load_ytrain['Y_Train']
X_test = load_xtest['X_TestData']
Y_test = load_ytest['Y_Test']


Y_train = Y_train[0]
Y_test = Y_test[0]
X_train[0].shape



X_train = X_train.reshape(61,30,30,1)
X_test = X_test.reshape(30,30,30,1)


Y_train = to_categorical(Y_train)
Y_test = to_categorical(Y_test)



#check image shape
print('train shape :', X_train.shape)
print('test shape :', X_test.shape)
print('label train shape :', Y_train.shape)
print('label test shape :', Y_test.shape)


model = Sequential([
    Convolution2D(16,(2,2), input_shape=(30,30,1), strides=(1,1),activation='relu', padding='same'),
    MaxPooling2D(pool_size=(2,2), strides = (2,2)),
    Convolution2D(32,(2,2), strides=(1,1),activation='relu', padding = 'same'),
    MaxPooling2D(pool_size=(2,2), strides = (2,2)),
    Convolution2D(64,(2,2), strides=(1,1),activation='relu', padding = 'same'),
    MaxPooling2D(pool_size=(2,2), strides=(2,2)),
    Flatten(),
    Dense(96, activation='relu'),
    Dense(120, activation='relu'),
    Dense(4, activation = 'softmax')
])


model.summary()


# compile model
model.compile(loss='categorical_crossentropy', optimizer='Adam', metrics=['accuracy'])



# fit model
hist = model.fit(x=X_train,y=Y_train, epochs=50, batch_size=128, validation_data=(X_test, Y_test), verbose=1)


y_pred = model.predict(X_test)


matrix = metrics.confusion_matrix(Y_test.argmax(axis=1), y_pred.argmax(axis=1))
print(matrix)

