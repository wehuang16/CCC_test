within CCC_test.ESTCP;
model coupled_rk4_poppe_example
  extends Modelica.Icons.Example;
  coupled_rk4_poppe coupled_rk4_poppe1
    annotation (Placement(transformation(extent={{4,6},{24,26}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant T_a0(k=273.15 + 16)
    annotation (Placement(transformation(extent={{-72,72},{-52,92}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant T_w0(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-72,40},{-52,60}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant phi0(k=0.2)
    annotation (Placement(transformation(extent={{-74,8},{-54,28}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant m_a(k=30)
    annotation (Placement(transformation(extent={{-72,-24},{-52,-4}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant m_w0(k=50)
    annotation (Placement(transformation(extent={{-72,-58},{-52,-38}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant p(k=101325)
    annotation (Placement(transformation(extent={{-72,-98},{-52,-78}})));
equation
  connect(T_a0.y, coupled_rk4_poppe1.T_a0) annotation (Line(points={{-50,82},{
          -24,82},{-24,23.4},{2,23.4}}, color={0,0,127}));
  connect(T_w0.y, coupled_rk4_poppe1.T_w0) annotation (Line(points={{-50,50},{
          -24,50},{-24,20.2},{2,20.2}}, color={0,0,127}));
  connect(phi0.y, coupled_rk4_poppe1.phi0) annotation (Line(points={{-52,18},{
          -26,18},{-26,16.6},{2,16.6}}, color={0,0,127}));
  connect(m_a.y, coupled_rk4_poppe1.m_a) annotation (Line(points={{-50,-14},{
          -24,-14},{-24,13},{1.6,13}}, color={0,0,127}));
  connect(m_w0.y, coupled_rk4_poppe1.m_w0) annotation (Line(points={{-50,-48},{
          -24,-48},{-24,9.2},{1.8,9.2}}, color={0,0,127}));
  connect(p.y, coupled_rk4_poppe1.p) annotation (Line(points={{-50,-88},{-24,
          -88},{-24,5.6},{2.2,5.6}}, color={0,0,127}));
end coupled_rk4_poppe_example;
