within CCC_test.Examples;
model TestHeatPump
  extends Modelica.Icons.Example;
  CCC.Fluid.Examples.HP_TES_water hP_TES_water_v2_1
    annotation (Placement(transformation(extent={{-6,20},{34,56}})));
  Modelica.Blocks.Sources.Constant const(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-68,70},{-48,90}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 12)
    annotation (Placement(transformation(extent={{-76,36},{-56,56}})));
  Modelica.Blocks.Sources.Constant const2(k=1.5)
    annotation (Placement(transformation(extent={{-66,-12},{-46,8}})));
  Modelica.Blocks.Sources.Constant const6(k=273.15 + 50)
    annotation (Placement(transformation(extent={{52,-18},{72,2}})));
  Modelica.Blocks.Sources.Constant const4(k=273.15 + 0)
    annotation (Placement(transformation(extent={{52,-50},{72,-30}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true)
    annotation (Placement(transformation(extent={{-2,-30},{18,-10}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{30,72},{50,92}})));
  Modelica.Blocks.Sources.Constant const5(k=5000)
    annotation (Placement(transformation(extent={{-76,-48},{-56,-28}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant2(k=false)
    annotation (Placement(transformation(extent={{-62,-82},{-42,-62}})));
  Modelica.Blocks.Sources.Constant const3(k=2000)
    annotation (Placement(transformation(extent={{70,48},{90,68}})));
equation
  connect(const.y,hP_TES_water_v2_1. T_closet) annotation (Line(points={{-47,80},
          {-16,80},{-16,53.3692},{-7.57143,53.3692}}, color={0,0,127}));
  connect(const1.y,hP_TES_water_v2_1. Tdcw) annotation (Line(points={{-55,46},{
          -31.6,46},{-31.6,48.6615},{-7.57143,48.6615}}, color={0,0,127}));
  connect(const2.y,hP_TES_water_v2_1. mdot_dcw) annotation (Line(points={{-45,-2},
          {-32,-2},{-32,43.1231},{-7.57143,43.1231}},     color={0,0,127}));
  connect(const6.y, hP_TES_water_v2_1.TSupSet) annotation (Line(points={{73,-8},
          {76,-8},{76,33.4308},{35.5714,33.4308}}, color={0,0,127}));
  connect(const4.y,hP_TES_water_v2_1. T_OA) annotation (Line(points={{73,-40},{
          86,-40},{86,37.3077},{35.5714,37.3077}}, color={0,0,127}));
  connect(booleanConstant1.y,hP_TES_water_v2_1. HP_mode) annotation (Line(
        points={{51,82},{58,82},{58,41.4615},{35.5714,41.4615}}, color={255,0,
          255}));
  connect(booleanConstant.y,hP_TES_water_v2_1. HP_On) annotation (Line(points={{19,-20},
          {46,-20},{46,29.2769},{35.5714,29.2769}},          color={255,0,255}));
  connect(const5.y,hP_TES_water_v2_1. ResistanceThermalCapacity) annotation (
      Line(points={{-55,-38},{-44,-38},{-44,-36},{-20,-36},{-20,31.7692},{
          -7.57143,31.7692}}, color={0,0,127}));
  connect(booleanConstant2.y,hP_TES_water_v2_1. Resistance_On) annotation (Line(
        points={{-41,-72},{-30,-72},{-30,-68},{-16,-68},{-16,24.5692},{-7.57143,
          24.5692}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestHeatPump;
