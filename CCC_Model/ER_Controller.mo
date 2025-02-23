within CCC_test.CCC_Model;
model ER_Controller

  Modelica.Blocks.Interfaces.RealInput HP_nSet
    "relative compressor speed of HP"
    annotation (Placement(transformation(extent={{-140,42},{-100,82}})));
  Modelica.Blocks.Interfaces.RealInput HP_setpoint "setpoint for the HP"
    annotation (Placement(transformation(extent={{-142,-20},{-102,20}})));
  Modelica.Blocks.Interfaces.RealInput T_sys
    "temperature of the system provided by the HP"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput ER_set annotation (Placement(
        transformation(extent={{100,-20},{140,20}}), iconTransformation(extent=
            {{100,-20},{140,20}})));
  Buildings.Controls.Continuous.LimPID conPID
    annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{34,18},{54,-2}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold=1)
    annotation (Placement(transformation(extent={{-84,52},{-64,72}})));
  Modelica.Blocks.Logical.LogicalDelay logicalDelay(delayTime=60)
    annotation (Placement(transformation(extent={{-44,52},{-24,72}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=0)
    annotation (Placement(transformation(extent={{-18,74},{2,94}})));
equation
  connect(HP_setpoint, conPID.u_s)
    annotation (Line(points={{-122,0},{-68,0}}, color={0,0,127}));
  connect(T_sys, conPID.u_m) annotation (Line(points={{-120,-60},{-56,-60},{-56,
          -12}}, color={0,0,127}));
  connect(conPID.y, switch1.u1)
    annotation (Line(points={{-45,0},{32,0}}, color={0,0,127}));
  connect(HP_nSet, realToBoolean.u)
    annotation (Line(points={{-120,62},{-86,62}}, color={0,0,127}));
  connect(realToBoolean.y, logicalDelay.u)
    annotation (Line(points={{-63,62},{-46,62}}, color={255,0,255}));
  connect(logicalDelay.y2, switch1.u2) annotation (Line(points={{-23,56},{2,56},
          {2,8},{32,8}}, color={255,0,255}));
  connect(switch1.y, ER_set)
    annotation (Line(points={{55,8},{76,8},{76,0},{120,0}}, color={0,0,127}));
  connect(realExpression.y, switch1.u3) annotation (Line(points={{3,84},{24,84},
          {24,16},{32,16}}, color={0,0,127}));
end ER_Controller;
