within CCC_test.ESTCP;
block coupled_rk4_poppe
  //parameter Real T_a00=273.15+16;
  //parameter Real phi00=0.2;
  //parameter Real m_a0 = 30;
  // Real m_w00 = 50;
  //parameter Real p0 = 101325;
  //parameter Real T_w00 = 273.15+20;


  parameter Real delT_w = 0.8;
  final parameter Real Me0=0;

  // State variables
  //Real T_a0(start=T_a00);
  //Real phi0(start=phi00);
  //Real m_a(start=m_a0);
  //Real m_w0(start=m_w00);
  //Real p(start=p0);
  //Real T_w0(start=T_w00);

  Buildings.Controls.OBC.CDL.Interfaces.RealInput T_a0
    annotation (Placement(transformation(extent={{-140,54},{-100,94}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput phi0
    annotation (Placement(transformation(extent={{-140,-14},{-100,26}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput m_a
    annotation (Placement(transformation(extent={{-144,-50},{-104,-10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput m_w0
    annotation (Placement(transformation(extent={{-142,-88},{-102,-48}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput p
    annotation (Placement(transformation(extent={{-138,-124},{-98,-84}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput T_w0
    annotation (Placement(transformation(extent={{-140,22},{-100,62}})));

  Real x_w0;
  Real h_ma0;


  Real T_a1;
  Real phi1;
  Real m_w1;
  Real T_w1;
  Real x_w1;
  Real h_ma1;
  Real Me1;
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

  Real T_a2;
  Real phi2;
  Real m_w2;
  Real T_w2;
  Real x_w2;
  Real h_ma2;
  Real Me2;
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

  Real T_a3;
  Real phi3;
  Real m_w3;
  Real T_w3;
  Real x_w3;
  Real h_ma3;
  Real Me3;
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

  Real T_a4;
  Real phi4;
  Real m_w4;
  Real T_w4;
  Real x_w4;
  Real h_ma4;
  Real Me4;
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

  Real T_a5;
  Real phi5;
  Real m_w5;
  Real T_w5;
  Real x_w5;
  Real h_ma5;
  Real Me5;
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


  x_w0 = CCC_test.ESTCP.x_pTphi(p,T_a0,phi0);
  h_ma0 = CCC_test.ESTCP.h_pTphi(p,T_a0,phi0);





  j11=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w0,h_ma0,T_w0,m_w0,m_a,x_w0,p);
  k11=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w0,h_ma0,T_w0,m_w0,m_a,x_w0,p);
  l11=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w0,h_ma0,T_w0,m_w0,m_a,x_w0,p);

  j12=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w0+j11/2,h_ma0+k11/2,T_w0+delT_w/2,m_w0,m_a,x_w0,p);
  k12=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w0+j11/2,h_ma0+k11/2,T_w0+delT_w/2,m_w0,m_a,x_w0,p);
  l12=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w0+j11/2,h_ma0+k11/2,T_w0+delT_w/2,m_w0,m_a,x_w0,p);

  j13=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w0+j12/2,h_ma0+k12/2,T_w0+delT_w/2,m_w0,m_a,x_w0,p);
  k13=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w0+j12/2,h_ma0+k12/2,T_w0+delT_w/2,m_w0,m_a,x_w0,p);
  l13=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w0+j12/2,h_ma0+k12/2,T_w0+delT_w/2,m_w0,m_a,x_w0,p);

  j14=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w0+j13,h_ma0+k13,T_w0+delT_w,m_w0,m_a,x_w0,p);
  k14=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w0+j13,h_ma0+k13,T_w0+delT_w,m_w0,m_a,x_w0,p);
  l14=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w0+j13,h_ma0+k13,T_w0+delT_w,m_w0,m_a,x_w0,p);

  T_w1=T_w0+delT_w;
  x_w1=x_w0+(j11+2*j12+2*j13+j14)/6;
  h_ma1=h_ma0+(k11+2*k12+2*k13+k14)/6;
  Me1=Me0+(l11+2*l12+2*l13+l14)/6;

  (T_a1,phi1) =  CCC_test.ESTCP.Tphi_hxp(h_ma1,x_w1,p);
  m_w1 = m_a*(x_w1-x_w0)+m_w0;


  j21=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w1,h_ma1,T_w1,m_w0,m_a,x_w0,p);
  k21=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w1,h_ma1,T_w1,m_w0,m_a,x_w0,p);
  l21=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w1,h_ma1,T_w1,m_w0,m_a,x_w0,p);

  j22=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w1+j21/2,h_ma1+k21/2,T_w1+delT_w/2,m_w0,m_a,x_w0,p);
  k22=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w1+j21/2,h_ma1+k21/2,T_w1+delT_w/2,m_w0,m_a,x_w0,p);
  l22=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w1+j21/2,h_ma1+k21/2,T_w1+delT_w/2,m_w0,m_a,x_w0,p);

  j23=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w1+j22/2,h_ma1+k22/2,T_w1+delT_w/2,m_w0,m_a,x_w0,p);
  k23=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w1+j22/2,h_ma1+k22/2,T_w1+delT_w/2,m_w0,m_a,x_w0,p);
  l23=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w1+j22/2,h_ma1+k22/2,T_w1+delT_w/2,m_w0,m_a,x_w0,p);

  j24=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w1+j23,h_ma1+k23,T_w1+delT_w,m_w0,m_a,x_w0,p);
  k24=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w1+j23,h_ma1+k23,T_w1+delT_w,m_w0,m_a,x_w0,p);
  l24=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w1+j23,h_ma1+k23,T_w1+delT_w,m_w0,m_a,x_w0,p);

  T_w2=T_w1+delT_w;
  x_w2=x_w1+(j21+2*j22+2*j23+j24)/6;
  h_ma2=h_ma1+(k21+2*k22+2*k23+k24)/6;
  Me2=Me1+(l21+2*l22+2*l23+l24)/6;

  (T_a2,phi2) =  CCC_test.ESTCP.Tphi_hxp(h_ma2,x_w2,p);
  m_w2 = m_a*(x_w2-x_w0)+m_w0;

  j31=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w2,h_ma2,T_w2,m_w0,m_a,x_w0,p);
  k31=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w2,h_ma2,T_w2,m_w0,m_a,x_w0,p);
  l31=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w2,h_ma2,T_w2,m_w0,m_a,x_w0,p);

  j32=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w2+j31/2,h_ma2+k31/2,T_w2+delT_w/2,m_w0,m_a,x_w0,p);
  k32=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w2+j31/2,h_ma2+k31/2,T_w2+delT_w/2,m_w0,m_a,x_w0,p);
  l32=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w2+j31/2,h_ma2+k31/2,T_w2+delT_w/2,m_w0,m_a,x_w0,p);

  j33=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w2+j32/2,h_ma2+k32/2,T_w2+delT_w/2,m_w0,m_a,x_w0,p);
  k33=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w2+j32/2,h_ma2+k32/2,T_w2+delT_w/2,m_w0,m_a,x_w0,p);
  l33=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w2+j32/2,h_ma2+k32/2,T_w2+delT_w/2,m_w0,m_a,x_w0,p);

  j34=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w2+j33,h_ma2+k33,T_w2+delT_w,m_w0,m_a,x_w0,p);
  k34=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w2+j33,h_ma2+k33,T_w2+delT_w,m_w0,m_a,x_w0,p);
  l34=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w2+j33,h_ma2+k33,T_w2+delT_w,m_w0,m_a,x_w0,p);

  T_w3=T_w2+delT_w;
  x_w3=x_w2+(j31+2*j32+2*j33+j34)/6;
  h_ma3=h_ma2+(k31+2*k32+2*k33+k34)/6;
  Me3=Me2+(l31+2*l32+2*l33+l34)/6;

  (T_a3,phi3) =  CCC_test.ESTCP.Tphi_hxp(h_ma3,x_w3,p);
  m_w3 = m_a*(x_w3-x_w0)+m_w0;

  j41=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w3,h_ma3,T_w3,m_w0,m_a,x_w0,p);
  k41=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w3,h_ma3,T_w3,m_w0,m_a,x_w0,p);
  l41=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w3,h_ma3,T_w3,m_w0,m_a,x_w0,p);

  j42=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w3+j41/2,h_ma3+k41/2,T_w3+delT_w/2,m_w0,m_a,x_w0,p);
  k42=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w3+j41/2,h_ma3+k41/2,T_w3+delT_w/2,m_w0,m_a,x_w0,p);
  l42=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w3+j41/2,h_ma3+k41/2,T_w3+delT_w/2,m_w0,m_a,x_w0,p);

  j43=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w3+j42/2,h_ma3+k42/2,T_w3+delT_w/2,m_w0,m_a,x_w0,p);
  k43=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w3+j42/2,h_ma3+k42/2,T_w3+delT_w/2,m_w0,m_a,x_w0,p);
  l43=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w3+j42/2,h_ma3+k42/2,T_w3+delT_w/2,m_w0,m_a,x_w0,p);

  j44=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w3+j43,h_ma3+k43,T_w3+delT_w,m_w0,m_a,x_w0,p);
  k44=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w3+j43,h_ma3+k43,T_w3+delT_w,m_w0,m_a,x_w0,p);
  l44=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w3+j43,h_ma3+k43,T_w3+delT_w,m_w0,m_a,x_w0,p);

  T_w4=T_w3+delT_w;
  x_w4=x_w3+(j41+2*j42+2*j43+j44)/6;
  h_ma4=h_ma3+(k41+2*k42+2*k43+k44)/6;
  Me4=Me3+(l41+2*l42+2*l43+l44)/6;

  (T_a4,phi4) =  CCC_test.ESTCP.Tphi_hxp(h_ma4,x_w4,p);
  m_w4 = m_a*(x_w4-x_w0)+m_w0;

  j51=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w4,h_ma4,T_w4,m_w0,m_a,x_w0,p);
  k51=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w4,h_ma4,T_w4,m_w0,m_a,x_w0,p);
  l51=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w4,h_ma4,T_w4,m_w0,m_a,x_w0,p);

  j52=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w4+j51/2,h_ma4+k51/2,T_w4+delT_w/2,m_w0,m_a,x_w0,p);
  k52=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w4+j51/2,h_ma4+k51/2,T_w4+delT_w/2,m_w0,m_a,x_w0,p);
  l52=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w4+j51/2,h_ma4+k51/2,T_w4+delT_w/2,m_w0,m_a,x_w0,p);

  j53=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w4+j52/2,h_ma4+k52/2,T_w4+delT_w/2,m_w0,m_a,x_w0,p);
  k53=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w4+j52/2,h_ma4+k52/2,T_w4+delT_w/2,m_w0,m_a,x_w0,p);
  l53=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w4+j52/2,h_ma4+k52/2,T_w4+delT_w/2,m_w0,m_a,x_w0,p);

  j54=delT_w*CCC_test.ESTCP.RightHandSide_dx_w(x_w4+j53,h_ma4+k53,T_w4+delT_w,m_w0,m_a,x_w0,p);
  k54=delT_w*CCC_test.ESTCP.RightHandSide_dh_ma(x_w4+j53,h_ma4+k53,T_w4+delT_w,m_w0,m_a,x_w0,p);
  l54=delT_w*CCC_test.ESTCP.RightHandSide_dMe(x_w4+j53,h_ma4+k53,T_w4+delT_w,m_w0,m_a,x_w0,p);

  T_w5=T_w4+delT_w;
  x_w5=x_w4+(j51+2*j52+2*j53+j54)/6;
  h_ma5=h_ma4+(k51+2*k52+2*k53+k54)/6;
  Me5=Me4+(l51+2*l52+2*l53+l54)/6;

  (T_a5,phi5) =  CCC_test.ESTCP.Tphi_hxp(h_ma5,x_w5,p);
  m_w5 = m_a*(x_w5-x_w0)+m_w0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=5,
      Interval=0.01,
      __Dymola_Algorithm="Dassl"));
end coupled_rk4_poppe;
