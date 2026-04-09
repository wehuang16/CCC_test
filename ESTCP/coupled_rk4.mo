within CCC_test.ESTCP;
block coupled_rk4
  parameter Real T00 = 1;
  parameter Real w00 = 5;
  parameter Real x00 = 2;
  parameter Real m00 = 0;
  parameter Real delT = 1;


  // State variables
  Real T0(start=T00);
  Real w0(start=w00);
  Real x0(start=x00);
  Real m0(start=m00);

  Real T1;
  Real w1;
  Real x1;
  Real m1;
  Real j11;
  Real j12;
  Real j13;
  Real j14;
  Real k11;
  Real k12;
  Real k13;
  Real k14;
  Real l11;
  Real l12;
  Real l13;
  Real l14;

  Real T2;
  Real w2;
  Real x2;
  Real m2;
  Real j21;
  Real j22;
  Real j23;
  Real j24;
  Real k21;
  Real k22;
  Real k23;
  Real k24;
  Real l21;
  Real l22;
  Real l23;
  Real l24;


  Real T3;
  Real w3;
  Real x3;
  Real m3;
  Real j31;
  Real j32;
  Real j33;
  Real j34;
  Real k31;
  Real k32;
  Real k33;
  Real k34;
  Real l31;
  Real l32;
  Real l33;
  Real l34;

  Real T4;
  Real w4;
  Real x4;
  Real m4;
  Real j41;
  Real j42;
  Real j43;
  Real j44;
  Real k41;
  Real k42;
  Real k43;
  Real k44;
  Real l41;
  Real l42;
  Real l43;
  Real l44;

  Real T5;
  Real w5;
  Real x5;
  Real m5;
  Real j51;
  Real j52;
  Real j53;
  Real j54;
  Real k51;
  Real k52;
  Real k53;
  Real k54;
  Real l51;
  Real l52;
  Real l53;
  Real l54;

equation
  der(T0)=0;
  der(w0)=0;
  der(x0)=0;
  der(m0)=0;

  j11=delT*w_function(w0,x0,T0);
  k11=delT*x_function(w0,x0,T0);
  l11=delT*m_function(w0,x0,T0);

  j12=delT*w_function(w0+j11/2,x0+k11/2,T0+delT/2);
  k12=delT*x_function(w0+j11/2,x0+k11/2,T0+delT/2);
  l12=delT*m_function(w0+j11/2,x0+k11/2,T0+delT/2);

  j13=delT*w_function(w0+j12/2,x0+k12/2,T0+delT/2);
  k13=delT*x_function(w0+j12/2,x0+k12/2,T0+delT/2);
  l13=delT*m_function(w0+j12/2,x0+k12/2,T0+delT/2);

  j14=delT*w_function(w0+j13,x0+k13,T0+delT);
  k14=delT*x_function(w0+j13,x0+k13,T0+delT);
  l14=delT*m_function(w0+j13,x0+k13,T0+delT);

  T1=T0+delT;
  w1=w0+(j11+2*j12+2*j13+j14)/6;
  x1=x0+(k11+2*k12+2*k13+k14)/6;
  m1=m0+(l11+2*l12+2*l13+l14)/6;

  j21=delT*w_function(w1,x1,T1);
  k21=delT*x_function(w1,x1,T1);
  l21=delT*m_function(w1,x1,T1);

  j22=delT*w_function(w1+j21/2,x1+k21/2,T1+delT/2);
  k22=delT*x_function(w1+j21/2,x1+k21/2,T1+delT/2);
  l22=delT*m_function(w1+j21/2,x1+k21/2,T1+delT/2);

  j23=delT*w_function(w1+j22/2,x1+k22/2,T1+delT/2);
  k23=delT*x_function(w1+j22/2,x1+k22/2,T1+delT/2);
  l23=delT*m_function(w1+j22/2,x1+k22/2,T1+delT/2);

  j24=delT*w_function(w1+j23,x1+k23,T1+delT);
  k24=delT*x_function(w1+j23,x1+k23,T1+delT);
  l24=delT*m_function(w1+j23,x1+k23,T1+delT);

  T2=T1+delT;
  w2=w1+(j21+2*j22+2*j23+j24)/6;
  x2=x1+(k21+2*k22+2*k23+k24)/6;
  m2=m1+(l21+2*l22+2*l23+l24)/6;

  j31=delT*w_function(w2,x2,T2);
  k31=delT*x_function(w2,x2,T2);
  l31=delT*m_function(w2,x2,T2);

  j32=delT*w_function(w2+j31/2,x2+k31/2,T2+delT/2);
  k32=delT*x_function(w2+j31/2,x2+k31/2,T2+delT/2);
  l32=delT*m_function(w2+j31/2,x2+k31/2,T2+delT/2);

  j33=delT*w_function(w2+j32/2,x2+k32/2,T2+delT/2);
  k33=delT*x_function(w2+j32/2,x2+k32/2,T2+delT/2);
  l33=delT*m_function(w2+j32/2,x2+k32/2,T2+delT/2);

  j34=delT*w_function(w2+j33,x2+k33,T2+delT);
  k34=delT*x_function(w2+j33,x2+k33,T2+delT);
  l34=delT*m_function(w2+j33,x2+k33,T2+delT);

  T3=T2+delT;
  w3=w2+(j31+2*j32+2*j33+j34)/6;
  x3=x2+(k31+2*k32+2*k33+k34)/6;
  m3=m2+(l31+2*l32+2*l33+l34)/6;


  j41=delT*w_function(w3,x3,T3);
  k41=delT*x_function(w3,x3,T3);
  l41=delT*m_function(w3,x3,T3);

  j42=delT*w_function(w3+j41/2,x3+k41/2,T3+delT/2);
  k42=delT*x_function(w3+j41/2,x3+k41/2,T3+delT/2);
  l42=delT*m_function(w3+j41/2,x3+k41/2,T3+delT/2);

  j43=delT*w_function(w3+j42/2,x3+k42/2,T3+delT/2);
  k43=delT*x_function(w3+j42/2,x3+k42/2,T3+delT/2);
  l43=delT*m_function(w3+j42/2,x3+k42/2,T3+delT/2);

  j44=delT*w_function(w3+j43,x3+k43,T3+delT);
  k44=delT*x_function(w3+j43,x3+k43,T3+delT);
  l44=delT*m_function(w3+j43,x3+k43,T3+delT);

  T4=T3+delT;
  w4=w3+(j41+2*j42+2*j43+j44)/6;
  x4=x3+(k41+2*k42+2*k43+k44)/6;
  m4=m3+(l41+2*l42+2*l43+l44)/6;


  j51=delT*w_function(w4,x4,T4);
  k51=delT*x_function(w4,x4,T4);
  l51=delT*m_function(w4,x4,T4);

  j52=delT*w_function(w4+j51/2,x4+k51/2,T4+delT/2);
  k52=delT*x_function(w4+j51/2,x4+k51/2,T4+delT/2);
  l52=delT*m_function(w4+j51/2,x4+k51/2,T4+delT/2);

  j53=delT*w_function(w4+j52/2,x4+k52/2,T4+delT/2);
  k53=delT*x_function(w4+j52/2,x4+k52/2,T4+delT/2);
  l53=delT*m_function(w4+j52/2,x4+k52/2,T4+delT/2);

  j54=delT*w_function(w4+j53,x4+k53,T4+delT);
  k54=delT*x_function(w4+j53,x4+k53,T4+delT);
  l54=delT*m_function(w4+j53,x4+k53,T4+delT);

  T5=T4+delT;
  w5=w4+(j51+2*j52+2*j53+j54)/6;
  x5=x4+(k51+2*k52+2*k53+k54)/6;
  m5=m4+(l51+2*l52+2*l53+l54)/6;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=5,
      Interval=0.01,
      __Dymola_Algorithm="Dassl"));
end coupled_rk4;
