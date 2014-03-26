How to run
==========
To run the code, you should follow these steps:

* Install MATLAB 2013a or higher.
    * older versions of MATLAB may also work, but no gurantees are given.
* If not already there, get [`libsvm-3.17`](http://www.csie.ntu.edu.tw/~cjlin/libsvm/) and compile the MATLAB part following the readme from the library. 
* Put the libsvm library in `src`, such that the MATLAB part of the library can be found in `src/libsvm-3.17/matlab/`.
    * Alternatively you can manually change the path to the library in `question3.m` and `svmClassify.m`.
* Make sure all the needed data files can be found in `data` lying at the same level as `src` and that a folder `figures` exist, also at the same level as `src` (i.e. not inside, but beside).
* Start MATLAB and run the main script: `main.m`
    * Please note that the scripts use relative paths and therefore you need to be standing in `src` when running the script.

Should you only wish to run the script of a single question, you can instead run `questionX.m` where `X` is the number of the question. Do note however that `question5.m` is dependent on `question4.m`.

Source files
============
The following files can be found in `src`:

* `main.m`
* `question1.m`
* `question2.m`
* `question3.m`
* `question4.m`
* `question5.m`
* `question7.m`

Furthermore the following files can be found in `src/+utils`:

* `betterPlots.m`
* `crossValidation.m`
* `jaakkola.m`
* `kNN.m`
* `linearRegression.m`
* `meanSquaredError.m`
* `pca.m`
* `polyPredict.m`
* `polyRegression.m`
* `svmClassify.m`
* `trainLDA.m`