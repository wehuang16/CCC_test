within CCC_test.ESTCP;
block coupled_rk4
  parameter Real T00 = 1;
  parameter Real w00 = 5;
  parameter Real x00 = 2;
  parameter Real delT = 1;


  // State variables
  Real T0(start=T00);
  Real w0(start=w00);
  Real x0(start=x00);
  Real T1;
  Real w1;
  Real x1;
  Real j11;
  Real j12;
  Real j13;
  Real j14;
  Real k11;
  Real k12;
  Real k13;
  Real k14;

equation
  der(T0)=0;
  der(w0)=0;
  der(x0)=0;

  j11=delT*w_function(w0,x0,T0);
  k11=delT*x_function(w0,x0,T0);

  j12=delT*w_function(w0+j11/2,x0+k11/2,T0+delT/2);
  k12=delT*x_function(w0+j11/2,x0+k11/2,T0+delT/2);

  j13=delT*w_function(w0+j12/2,x0+k12/2,T0+delT/2);
  k13=delT*x_function(w0+j12/2,x0+k12/2,T0+delT/2);

  j14=delT*w_function(w0+j13,x0+k13,T0+delT);
  k14=delT*x_function(w0+j13,x0+k13,T0+delT);

  T1=T0+delT;
  w1=w0+(j11+2*j12+2*j13+j14)/6;
  x1=x0+(k11+2*k12+2*k13+k14)/6;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=5,
      Interval=0.01,
      __Dymola_Algorithm="Dassl"));
end coupled_rk4;
