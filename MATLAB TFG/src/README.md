average.m:

    Gives an output variable, ITDave, estimating it by average time difference method, giving as input variables; HRTF.SOFA (Obj); azimuth angle (azmth) and elevation angle (elev).

CCross.m:

    Gives an output variable, ITD, estimating it by cross-correlation method, giving as input variables; HRTF.SOFA (Obj); azimuth angle (azmth) and elevation angle (elev).

fit.m:

    Gives an output variable, ITDfit, estimating it by linear curve fitting method, giving as input variables; HRTF.SOFA (Obj); azimuth angle (azmth); elevation angle (elev); beginning of interval (f1); end of interval (f2).

GDelay.m:

    Gives as output variable; ITDp, estimating it by phase difference method; ITDg, estimating it by group delay method; and the frequency vector (f), giving as input variables; HRTF.SOFA (Obj); azimuth angle (azmth) and elevation angle (elev).

LPF3K.m:

    Returns a discrete-time Butterworth Lowpass filter object.

Threshold.m:

    Gives an output variable, ITD, estimating it by threshold method, giving as input variables; HRTF.SOFA (Obj); azimuth angle (azmth) and elevation angle (elev).  
