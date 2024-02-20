within CCC_test.Ireland_Detached;
package Updated_Heating_System
  model Interim_heating
      package Medium=Buildings.Media.Air
      "Medium model";
      parameter Real air_density(unit="kg/m3")=1.2 "average air density in kg/m3";

      parameter Real kitchen_volume(unit="m3")=29.61 "volume of kitchen";
      parameter Real kitchen_area(unit="m2")=11.387 "area of kitchen";
      parameter Real kitchen_infil(unit="kg/s")=0.007155*air_density "kitchen infiltration in kg/s";

      parameter Real dining_volume(unit="m3")=40.01 "volume of dining room";
      parameter Real dining_infil(unit="kg/s")=0.00967*air_density "dining infiltration in kg/s";
      parameter Real dining_area(unit="m2")=15.3901 "area of dining room";

      parameter Real sitting_volume(unit="m3")=40.01 "volume of sitting room";
      parameter Real sitting_infil(unit="kg/s")=0.00967*air_density "sitting infiltration in kg/s";
      parameter Real sitting_area(unit="m2")=15.3901 "area of sitting room";

      parameter Real study_volume(unit="m3")=21.94 "volume of study room";
      parameter Real study_infil(unit="kg/s")=0.005301*air_density "study infiltration in kg/s";
      parameter Real study_area(unit="m2")=8.4371 "area of study";

      parameter Real BR1_volume(unit="m3")=32.42 "volume of BR1";
      parameter Real BR1_infil(unit="kg/s")=0.007834*air_density "BR1 infiltration in kg/s";
      parameter Real BR1_area(unit="m2")=13.1515 "area of BR1";

      parameter Real BR2_volume(unit="m3")=32.42 "volume of BR2";
      parameter Real BR2_infil(unit="kg/s")=0.007834*air_density "BR2 infiltration in kg/s";
      parameter Real BR2_area(unit="m2")=13.1515 "area of BR2";

      parameter Real BR3_volume(unit="m3")=18.34 "volume of BR3";
      parameter Real BR3_infil(unit="kg/s")=0.004431*air_density "BR3 infiltration in kg/s";
      parameter Real BR3_area(unit="m2")=7.4382 "area of BR3";

      parameter Real BR4_volume(unit="m3")=21.7 "volume of BR4";
      parameter Real BR4_infil(unit="kg/s")=0.005244*air_density "BR4 infiltration in kg/s";
      parameter Real BR4_area(unit="m2")=8.8028 "area of BR4";

      parameter Real bathroom_volume(unit="m3")=10.53 "volume of bathroom";
      parameter Real bathroom_infil(unit="kg/s")=0.002545*air_density "bathroom infiltration in kg/s";
      parameter Real bathroom_area(unit="m2")=4.272 "area of bathroom";

      parameter Real toilet_volume(unit="m3")=7.36 "volume of toilet";
      parameter Real toilet_infil(unit="kg/s")=0.001778*air_density "toilet infiltration in kg/s";
      parameter Real toilet_area(unit="m2")=2.9851 "area of toilet";

      parameter Real water_out_temp=273.15+50 "rad outlet water temp";
    inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
      idfName="C:/Users/User/OneDrive/Documents/School/Thesis/Thesis_Dymola/Ireland_Detached_Original/Detached Original_V960.idf",
      epwName="C:/Users/User/OneDrive/Documents/School/Thesis/Thesis_Dymola/Weather/IRL_Dublin.039690_IWEC.epw",
      weaName="C:/Users/User/OneDrive/Documents/School/Thesis/Thesis_Dymola/Weather/IRL_Dublin.039690_IWEC.mos")
      annotation (Placement(transformation(extent={{-296,-642},{-276,-622}})));

    Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone Kitchen(
      redeclare package Medium = Medium,
      zoneName="GroundXfloor:Kitchen",
      nPorts=2) "Thermal zone"
      annotation (Placement(transformation(extent={{66,50},{106,90}})));
    Buildings.Fluid.FixedResistances.PressureDrop duc(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      linearized=true,
      from_dp=true,
      dp_nominal=100,
      m_flow_nominal=kitchen_infil)
      "Duct resistance (to decouple room and outside pressure)"
      annotation (Placement(transformation(extent={{62,22},{42,42}})));
    Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=kitchen_infil)     "Boundary condition"
      annotation (Placement(transformation(extent={{30,-10},{50,10}})));
    Buildings.Fluid.Sources.Boundary_pT pAtm(redeclare package Medium = Medium,
        nPorts=1) "Boundary condition"
      annotation (Placement(transformation(extent={{-8,22},{12,42}})));

    Modelica.Blocks.Sources.Constant qIntGai[3](each k=0)
      "Internal heat gains, set to zero because these are modeled in EnergyPlus"
      annotation (Placement(transformation(extent={{18,70},{38,90}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToReal kitchen_Tset(realTrue=273.15
           + 22, realFalse=273.15 + 18)
      annotation (Placement(transformation(extent={{198,96},{218,116}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable kitchen_occ(name="Zone People Occupant Count",
        key="GroundXfloor:Kitchen")
      annotation (Placement(transformation(extent={{112,94},{138,120}})));
    Buildings.Controls.OBC.CDL.Reals.GreaterThreshold kitchen_is_Occ
      annotation (Placement(transformation(extent={{158,94},{184,120}})));
    Buildings.Fluid.Sources.Boundary_pT kitchen_in(
      redeclare package Medium = Buildings.Media.Water,
      T=333.15,
      nPorts=1) annotation (Placement(transformation(extent={{444,26},{464,46}})));
    Buildings.Fluid.Sources.Boundary_pT kitchen_out(
      redeclare package Medium = Buildings.Media.Water,
      T=323.15,
      nPorts=1) annotation (Placement(transformation(extent={{670,38},{650,58}})));
    Buildings.Fluid.Movers.Preconfigured.FlowControlled_m_flow kitchen_pump(
      redeclare package Medium = Buildings.Media.Water,
      addPowerToMedium=false,
      m_flow_nominal=0.700/(4.184*10))
      annotation (Placement(transformation(extent={{506,38},{526,58}})));
    Buildings.Controls.OBC.CDL.Reals.PID kitchen_conP(
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
      k=0.5,
      Ti=100,
      yMax=1,
      yMin=0) annotation (Placement(transformation(extent={{230,58},{254,82}})));
    Modelica.Blocks.Math.Gain kitchen_mflow(k=0.700/(4.184*10))
      annotation (Placement(transformation(extent={{292,60},{312,80}})));
    Buildings.Fluid.HeatExchangers.SensibleCooler_T coo(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=0.700/(4.184*10),
      dp_nominal=0)
      annotation (Placement(transformation(extent={{576,42},{596,62}})));
    Modelica.Blocks.Sources.Constant water_out(k=water_out_temp)
      annotation (Placement(transformation(extent={{544,94},{564,114}})));
    Modelica.Blocks.Math.Product kitchen_MCdeltaT
      annotation (Placement(transformation(extent={{286,144},{266,164}})));
    Modelica.Blocks.Sources.Constant CpdeltaT(k=4184*10)
      annotation (Placement(transformation(extent={{356,152},{336,172}})));
    Buildings.HeatTransfer.Sources.PrescribedHeatFlow kitchen_Qrad
      annotation (Placement(transformation(extent={{212,144},{192,164}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone Dining(
      redeclare package Medium = Medium,
      zoneName="GroundXfloor:Dining",
      nPorts=2) "Thermal zone"
      annotation (Placement(transformation(extent={{68,-132},{108,-92}})));
    Buildings.Fluid.FixedResistances.PressureDrop duc1(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      linearized=true,
      from_dp=true,
      dp_nominal=100,
      m_flow_nominal=dining_infil)
      "Duct resistance (to decouple room and outside pressure)"
      annotation (Placement(transformation(extent={{64,-160},{44,-140}})));
    Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir1(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=dining_infil)      "Boundary condition"
      annotation (Placement(transformation(extent={{32,-192},{52,-172}})));
    Buildings.Fluid.Sources.Boundary_pT pAtm1(redeclare package Medium = Medium,
        nPorts=1) "Boundary condition"
      annotation (Placement(transformation(extent={{-6,-160},{14,-140}})));
    Modelica.Blocks.Sources.Constant qIntGai1
                                            [3](each k=0)
      "Internal heat gains, set to zero because these are modeled in EnergyPlus"
      annotation (Placement(transformation(extent={{20,-112},{40,-92}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToReal dining_Tset(realTrue=273.15
           + 22, realFalse=273.15 + 18)
      annotation (Placement(transformation(extent={{200,-86},{220,-66}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable dining_occ(name="Zone People Occupant Count",
        key="GroundXfloor:Dining")
      annotation (Placement(transformation(extent={{114,-88},{140,-62}})));
    Buildings.Controls.OBC.CDL.Reals.GreaterThreshold dining_is_Occ
      annotation (Placement(transformation(extent={{160,-88},{186,-62}})));
    Buildings.Fluid.Sources.Boundary_pT dining_in(
      redeclare package Medium = Buildings.Media.Water,
      T=333.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{448,-166},{468,-146}})));
    Buildings.Fluid.Sources.Boundary_pT dining_out(
      redeclare package Medium = Buildings.Media.Water,
      T=323.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{674,-156},{654,-136}})));
    Buildings.Fluid.Movers.Preconfigured.FlowControlled_m_flow dining_pump(
      redeclare package Medium = Buildings.Media.Water,
      addPowerToMedium=false,
      m_flow_nominal=1.500/(4.184*10))
      annotation (Placement(transformation(extent={{510,-154},{530,-134}})));
    Buildings.Controls.OBC.CDL.Reals.PID dining_conP(
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
      k=0.5,
      Ti=100,
      yMax=1,
      yMin=0)
      annotation (Placement(transformation(extent={{244,-124},{268,-100}})));
    Modelica.Blocks.Math.Gain dining_mflow(k=1.500/(4.184*10))
      annotation (Placement(transformation(extent={{312,-122},{332,-102}})));
    Buildings.Fluid.HeatExchangers.SensibleCooler_T coo1(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=1.500/(4.184*10),
      dp_nominal=0)
      annotation (Placement(transformation(extent={{580,-152},{600,-132}})));
    Modelica.Blocks.Sources.Constant water_out1(k=water_out_temp)
      annotation (Placement(transformation(extent={{548,-98},{568,-78}})));
    Modelica.Blocks.Math.Product dining_MCdeltaT
      annotation (Placement(transformation(extent={{288,-38},{268,-18}})));
    Modelica.Blocks.Sources.Constant CpdeltaT1(k=4184*10)
      annotation (Placement(transformation(extent={{358,-30},{338,-10}})));
    Buildings.HeatTransfer.Sources.PrescribedHeatFlow dining_Qrad
      annotation (Placement(transformation(extent={{214,-38},{194,-18}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone Sitting(
      redeclare package Medium = Medium,
      zoneName="GroundXfloor:Sitting",
      nPorts=2) "Thermal zone"
      annotation (Placement(transformation(extent={{60,-308},{100,-268}})));
    Buildings.Fluid.FixedResistances.PressureDrop duc2(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      linearized=true,
      from_dp=true,
      dp_nominal=100,
      m_flow_nominal=sitting_infil)
      "Duct resistance (to decouple room and outside pressure)"
      annotation (Placement(transformation(extent={{56,-336},{36,-316}})));
    Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir2(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=sitting_infil)     "Boundary condition"
      annotation (Placement(transformation(extent={{24,-368},{44,-348}})));
    Buildings.Fluid.Sources.Boundary_pT pAtm2(redeclare package Medium = Medium,
        nPorts=1) "Boundary condition"
      annotation (Placement(transformation(extent={{-14,-336},{6,-316}})));
    Modelica.Blocks.Sources.Constant qIntGai2
                                            [3](each k=0)
      "Internal heat gains, set to zero because these are modeled in EnergyPlus"
      annotation (Placement(transformation(extent={{12,-288},{32,-268}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToReal sitting_Tset(realTrue=273.15
           + 22, realFalse=273.15 + 18)
      annotation (Placement(transformation(extent={{192,-240},{212,-220}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable sitting_occ(name="Zone People Occupant Count",
        key="GroundXfloor:Sitting")
      annotation (Placement(transformation(extent={{100,-246},{126,-220}})));
    Buildings.Controls.OBC.CDL.Reals.GreaterThreshold sitting_is_Occ
      annotation (Placement(transformation(extent={{148,-246},{174,-220}})));
    Buildings.Fluid.Sources.Boundary_pT sitting_in(
      redeclare package Medium = Buildings.Media.Water,
      T=333.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{368,-340},{388,-320}})));
    Buildings.Fluid.Sources.Boundary_pT sitting_out(
      redeclare package Medium = Buildings.Media.Water,
      T=323.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{570,-312},{550,-292}})));
    Buildings.Fluid.Movers.Preconfigured.FlowControlled_m_flow sitting_pump(
      redeclare package Medium = Buildings.Media.Water,
      addPowerToMedium=false,
      m_flow_nominal=1.500/(4.184*10))
      annotation (Placement(transformation(extent={{406,-312},{426,-292}})));
    Buildings.Controls.OBC.CDL.Reals.PID sitting_conP(
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
      k=0.5,
      Ti=100,
      yMax=1,
      yMin=0)
      annotation (Placement(transformation(extent={{220,-282},{244,-258}})));
    Modelica.Blocks.Math.Gain sitting_mflow(k=1.500/(4.184*10))
      annotation (Placement(transformation(extent={{294,-280},{314,-260}})));
    Buildings.Fluid.HeatExchangers.SensibleCooler_T coo2(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=1.500/(4.184*10),
      dp_nominal=0)
      annotation (Placement(transformation(extent={{476,-308},{496,-288}})));
    Modelica.Blocks.Sources.Constant water_out2(k=water_out_temp)
      annotation (Placement(transformation(extent={{444,-256},{464,-236}})));
    Modelica.Blocks.Math.Product sitting_MCdeltaT
      annotation (Placement(transformation(extent={{280,-214},{260,-194}})));
    Modelica.Blocks.Sources.Constant CpdeltaT2(k=4184*10)
      annotation (Placement(transformation(extent={{350,-206},{330,-186}})));
    Buildings.HeatTransfer.Sources.PrescribedHeatFlow sitting_Qrad
      annotation (Placement(transformation(extent={{206,-214},{186,-194}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone Study(
      redeclare package Medium = Medium,
      zoneName="GroundXfloor:Study",
      nPorts=2) "Thermal zone"
      annotation (Placement(transformation(extent={{50,-498},{90,-458}})));
    Buildings.Fluid.FixedResistances.PressureDrop duc3(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      linearized=true,
      from_dp=true,
      dp_nominal=100,
      m_flow_nominal=study_infil)
      "Duct resistance (to decouple room and outside pressure)"
      annotation (Placement(transformation(extent={{46,-526},{26,-506}})));
    Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir3(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=study_infil)       "Boundary condition"
      annotation (Placement(transformation(extent={{14,-556},{34,-536}})));
    Buildings.Fluid.Sources.Boundary_pT pAtm3(redeclare package Medium = Medium,
        nPorts=1) "Boundary condition"
      annotation (Placement(transformation(extent={{-24,-526},{-4,-506}})));
    Modelica.Blocks.Sources.Constant qIntGai3
                                            [3](each k=0)
      "Internal heat gains, set to zero because these are modeled in EnergyPlus"
      annotation (Placement(transformation(extent={{2,-478},{22,-458}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToReal study_Tset(realTrue=273.15
           + 22, realFalse=273.15 + 18)
      annotation (Placement(transformation(extent={{182,-452},{202,-432}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable study_occ(name="Zone People Occupant Count",
        key="GroundXfloor:Study")
      annotation (Placement(transformation(extent={{96,-454},{122,-428}})));
    Buildings.Controls.OBC.CDL.Reals.GreaterThreshold study_is_Occ
      annotation (Placement(transformation(extent={{142,-454},{168,-428}})));
    Buildings.Fluid.Sources.Boundary_pT study_in(
      redeclare package Medium = Buildings.Media.Water,
      T=333.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{442,-538},{462,-518}})));
    Buildings.Fluid.Sources.Boundary_pT study_out(
      redeclare package Medium = Buildings.Media.Water,
      T=323.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{668,-528},{648,-508}})));
    Buildings.Fluid.Movers.Preconfigured.FlowControlled_m_flow study_pump(
      redeclare package Medium = Buildings.Media.Water,
      addPowerToMedium=false,
      m_flow_nominal=0.850/(4.184*10))
      annotation (Placement(transformation(extent={{504,-528},{524,-508}})));
    Buildings.Controls.OBC.CDL.Reals.PID study_conP(
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
      k=0.5,
      Ti=100,
      yMax=1,
      yMin=0)
      annotation (Placement(transformation(extent={{228,-488},{252,-464}})));
    Modelica.Blocks.Math.Gain study_mflow(k=0.850/(4.184*10))
      annotation (Placement(transformation(extent={{300,-488},{320,-468}})));
    Buildings.Fluid.HeatExchangers.SensibleCooler_T coo3(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=0.850/(4.184*10),
      dp_nominal=0)
      annotation (Placement(transformation(extent={{574,-524},{594,-504}})));
    Modelica.Blocks.Sources.Constant water_out3(k=water_out_temp)
      annotation (Placement(transformation(extent={{542,-472},{562,-452}})));
    Modelica.Blocks.Math.Product study_MCdeltaT
      annotation (Placement(transformation(extent={{270,-404},{250,-384}})));
    Modelica.Blocks.Sources.Constant CpdeltaT3(k=4184*10)
      annotation (Placement(transformation(extent={{340,-396},{320,-376}})));
    Buildings.HeatTransfer.Sources.PrescribedHeatFlow study_Qrad
      annotation (Placement(transformation(extent={{196,-404},{176,-384}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone BR1(
      redeclare package Medium = Medium,
      zoneName="TopXfloor:BR1",
      nPorts=2) "Thermal zone"
      annotation (Placement(transformation(extent={{62,-688},{102,-648}})));
    Buildings.Fluid.FixedResistances.PressureDrop duc4(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      linearized=true,
      from_dp=true,
      dp_nominal=100,
      m_flow_nominal=BR1_infil)
      "Duct resistance (to decouple room and outside pressure)"
      annotation (Placement(transformation(extent={{56,-716},{36,-696}})));
    Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir4(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=BR1_infil)         "Boundary condition"
      annotation (Placement(transformation(extent={{24,-746},{44,-726}})));
    Buildings.Fluid.Sources.Boundary_pT pAtm4(redeclare package Medium = Medium,
        nPorts=1) "Boundary condition"
      annotation (Placement(transformation(extent={{-14,-716},{6,-696}})));
    Modelica.Blocks.Sources.Constant qIntGai4
                                            [3](each k=0)
      "Internal heat gains, set to zero because these are modeled in EnergyPlus"
      annotation (Placement(transformation(extent={{12,-668},{32,-648}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToReal BR1_Tset(realTrue=273.15 +
          22, realFalse=273.15 + 18)
      annotation (Placement(transformation(extent={{192,-642},{212,-622}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable BR1_occ(name="Zone People Occupant Count",
        key="TopXfloor:BR1")
      annotation (Placement(transformation(extent={{106,-644},{132,-618}})));
    Buildings.Controls.OBC.CDL.Reals.GreaterThreshold BR1_is_Occ
      annotation (Placement(transformation(extent={{152,-644},{178,-618}})));
    Buildings.Fluid.Sources.Boundary_pT BR1_in(
      redeclare package Medium = Buildings.Media.Water,
      T=333.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{448,-734},{468,-714}})));
    Buildings.Fluid.Sources.Boundary_pT BR1_out(
      redeclare package Medium = Buildings.Media.Water,
      T=323.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{674,-722},{654,-702}})));
    Buildings.Fluid.Movers.Preconfigured.FlowControlled_m_flow BR1_pump(
      redeclare package Medium = Buildings.Media.Water,
      addPowerToMedium=false,
      m_flow_nominal=1.000/(4.184*10))
      annotation (Placement(transformation(extent={{510,-722},{530,-702}})));
    Buildings.Controls.OBC.CDL.Reals.PID BR1_conP(
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
      k=0.5,
      Ti=100,
      yMax=1,
      yMin=0)
      annotation (Placement(transformation(extent={{238,-678},{262,-654}})));
    Modelica.Blocks.Math.Gain BR1_mflow(k=1.000/(4.184*10))
      annotation (Placement(transformation(extent={{308,-678},{328,-658}})));
    Buildings.Fluid.HeatExchangers.SensibleCooler_T coo4(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=1.000/(4.184*10),
      dp_nominal=0)
      annotation (Placement(transformation(extent={{580,-718},{600,-698}})));
    Modelica.Blocks.Sources.Constant water_out4(k=water_out_temp)
      annotation (Placement(transformation(extent={{548,-666},{568,-646}})));
    Modelica.Blocks.Math.Product BR1_MCdeltaT
      annotation (Placement(transformation(extent={{280,-594},{260,-574}})));
    Modelica.Blocks.Sources.Constant CpdeltaT4(k=4184*10)
      annotation (Placement(transformation(extent={{350,-586},{330,-566}})));
    Buildings.HeatTransfer.Sources.PrescribedHeatFlow BR1_Qrad
      annotation (Placement(transformation(extent={{206,-594},{186,-574}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone BR2(
      redeclare package Medium = Medium,
      zoneName="TopXfloor:BR2",
      nPorts=2) "Thermal zone"
      annotation (Placement(transformation(extent={{62,-880},{102,-840}})));
    Buildings.Fluid.FixedResistances.PressureDrop duc5(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      linearized=true,
      from_dp=true,
      dp_nominal=100,
      m_flow_nominal=BR2_infil)
      "Duct resistance (to decouple room and outside pressure)"
      annotation (Placement(transformation(extent={{56,-908},{36,-888}})));
    Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir5(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=BR2_infil)         "Boundary condition"
      annotation (Placement(transformation(extent={{24,-938},{44,-918}})));
    Buildings.Fluid.Sources.Boundary_pT pAtm5(redeclare package Medium = Medium,
        nPorts=1) "Boundary condition"
      annotation (Placement(transformation(extent={{-14,-908},{6,-888}})));
    Modelica.Blocks.Sources.Constant qIntGai5
                                            [3](each k=0)
      "Internal heat gains, set to zero because these are modeled in EnergyPlus"
      annotation (Placement(transformation(extent={{12,-860},{32,-840}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToReal BR2_Tset(realTrue=
          273.15 + 22, realFalse=273.15 + 18)
      annotation (Placement(transformation(extent={{192,-832},{212,-812}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable BR2_occ(name=
          "Zone People Occupant Count", key="TopXfloor:BR2")
      annotation (Placement(transformation(extent={{106,-836},{132,-810}})));
    Buildings.Controls.OBC.CDL.Reals.GreaterThreshold BR2_is_Occ
      annotation (Placement(transformation(extent={{152,-836},{178,-810}})));
    Buildings.Fluid.Sources.Boundary_pT BR2_in(
      redeclare package Medium = Buildings.Media.Water,
      T=333.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{438,-930},{458,-910}})));
    Buildings.Fluid.Sources.Boundary_pT BR2_out(
      redeclare package Medium = Buildings.Media.Water,
      T=323.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{664,-918},{644,-898}})));
    Buildings.Fluid.Movers.Preconfigured.FlowControlled_m_flow BR2_pump(
      redeclare package Medium = Buildings.Media.Water,
      addPowerToMedium=false,
      m_flow_nominal=1.000/(4.184*10))
      annotation (Placement(transformation(extent={{500,-918},{520,-898}})));
    Buildings.Controls.OBC.CDL.Reals.PID BR2_conP(
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
      k=0.5,
      Ti=100,
      yMax=1,
      yMin=0)
      annotation (Placement(transformation(extent={{238,-870},{262,-846}})));
    Modelica.Blocks.Math.Gain BR2_mflow(k=1.000/(4.184*10))
      annotation (Placement(transformation(extent={{308,-870},{328,-850}})));
    Buildings.Fluid.HeatExchangers.SensibleCooler_T coo5(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=1.000/(4.184*10),
      dp_nominal=0)
      annotation (Placement(transformation(extent={{570,-914},{590,-894}})));
    Modelica.Blocks.Sources.Constant water_out5(k=water_out_temp)
      annotation (Placement(transformation(extent={{538,-862},{558,-842}})));
    Modelica.Blocks.Math.Product BR2_MCdeltaT
      annotation (Placement(transformation(extent={{280,-786},{260,-766}})));
    Modelica.Blocks.Sources.Constant CpdeltaT5(k=4184*10)
      annotation (Placement(transformation(extent={{350,-778},{330,-758}})));
    Buildings.HeatTransfer.Sources.PrescribedHeatFlow BR2_Qrad
      annotation (Placement(transformation(extent={{206,-786},{186,-766}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone BR3(
      redeclare package Medium = Medium,
      zoneName="TopXfloor:BR3",
      nPorts=2) "Thermal zone"
      annotation (Placement(transformation(extent={{62,-1066},{102,-1026}})));
    Buildings.Fluid.FixedResistances.PressureDrop duc6(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      linearized=true,
      from_dp=true,
      dp_nominal=100,
      m_flow_nominal=BR3_infil)
      "Duct resistance (to decouple room and outside pressure)"
      annotation (Placement(transformation(extent={{56,-1094},{36,-1074}})));
    Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir6(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=BR3_infil)         "Boundary condition"
      annotation (Placement(transformation(extent={{24,-1124},{44,-1104}})));
    Buildings.Fluid.Sources.Boundary_pT pAtm6(redeclare package Medium = Medium,
        nPorts=1) "Boundary condition"
      annotation (Placement(transformation(extent={{-14,-1094},{6,-1074}})));
    Modelica.Blocks.Sources.Constant qIntGai6
                                            [3](each k=0)
      "Internal heat gains, set to zero because these are modeled in EnergyPlus"
      annotation (Placement(transformation(extent={{12,-1046},{32,-1026}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToReal BR3_Tset(realTrue=
          273.15 + 22, realFalse=273.15 + 18) annotation (Placement(
          transformation(extent={{192,-1020},{212,-1000}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable BR3_occ(name=
          "Zone People Occupant Count", key="TopXfloor:BR3")
      annotation (Placement(transformation(extent={{106,-1022},{132,-996}})));
    Buildings.Controls.OBC.CDL.Reals.GreaterThreshold BR3_is_Occ
      annotation (Placement(transformation(extent={{152,-1022},{178,-996}})));
    Buildings.Fluid.Sources.Boundary_pT BR3_in(
      redeclare package Medium = Buildings.Media.Water,
      T=333.15,
      nPorts=1) annotation (Placement(transformation(extent={{448,-1104},{468,
              -1084}})));
    Buildings.Fluid.Sources.Boundary_pT BR3_out(
      redeclare package Medium = Buildings.Media.Water,
      T=323.15,
      nPorts=1) annotation (Placement(transformation(extent={{674,-1092},{654,
              -1072}})));
    Buildings.Fluid.Movers.Preconfigured.FlowControlled_m_flow BR3_pump(
      redeclare package Medium = Buildings.Media.Water,
      addPowerToMedium=false,
      m_flow_nominal=0.550/(4.184*10))
                                     annotation (Placement(transformation(
            extent={{510,-1092},{530,-1072}})));
    Buildings.Controls.OBC.CDL.Reals.PID BR3_conP(
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
      k=0.5,
      Ti=100,
      yMax=1,
      yMin=0) annotation (Placement(transformation(extent={{238,-1056},{262,-1032}})));
    Modelica.Blocks.Math.Gain BR3_mflow(k=0.550/(4.184*10))
                                                          annotation (
        Placement(transformation(extent={{308,-1052},{328,-1032}})));
    Buildings.Fluid.HeatExchangers.SensibleCooler_T coo6(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=0.550/(4.184*10),
      dp_nominal=0)
      annotation (Placement(transformation(extent={{580,-1088},{600,-1068}})));
    Modelica.Blocks.Sources.Constant water_out6(k=water_out_temp)
      annotation (Placement(transformation(extent={{548,-1036},{568,-1016}})));
    Modelica.Blocks.Math.Product BR3_MCdeltaT
      annotation (Placement(transformation(extent={{280,-972},{260,-952}})));
    Modelica.Blocks.Sources.Constant CpdeltaT6(k=4184*10)
      annotation (Placement(transformation(extent={{350,-964},{330,-944}})));
    Buildings.HeatTransfer.Sources.PrescribedHeatFlow BR3_Qrad
      annotation (Placement(transformation(extent={{206,-972},{186,-952}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone BR4(
      redeclare package Medium = Medium,
      zoneName="TopXfloor:BR4",
      nPorts=2) "Thermal zone"
      annotation (Placement(transformation(extent={{62,-1246},{102,-1206}})));
    Buildings.Fluid.FixedResistances.PressureDrop duc7(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      linearized=true,
      from_dp=true,
      dp_nominal=100,
      m_flow_nominal=BR4_infil)
      "Duct resistance (to decouple room and outside pressure)"
      annotation (Placement(transformation(extent={{56,-1274},{36,-1254}})));
    Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir7(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=BR4_infil)         "Boundary condition"
      annotation (Placement(transformation(extent={{24,-1304},{44,-1284}})));
    Buildings.Fluid.Sources.Boundary_pT pAtm7(redeclare package Medium =
          Medium, nPorts=1)
                  "Boundary condition"
      annotation (Placement(transformation(extent={{-14,-1274},{6,-1254}})));
    Modelica.Blocks.Sources.Constant qIntGai7
                                            [3](each k=0)
      "Internal heat gains, set to zero because these are modeled in EnergyPlus"
      annotation (Placement(transformation(extent={{12,-1226},{32,-1206}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToReal BR4_Tset(realTrue=
          273.15 + 22, realFalse=273.15 + 18) annotation (Placement(
          transformation(extent={{192,-1200},{212,-1180}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable BR4_occ(name=
          "Zone People Occupant Count", key="TopXfloor:BR4") annotation (
        Placement(transformation(extent={{106,-1202},{132,-1176}})));
    Buildings.Controls.OBC.CDL.Reals.GreaterThreshold BR4_is_Occ annotation (
        Placement(transformation(extent={{152,-1202},{178,-1176}})));
    Buildings.Fluid.Sources.Boundary_pT BR4_in(
      redeclare package Medium = Buildings.Media.Water,
      T=333.15,
      nPorts=1) annotation (Placement(transformation(extent={{450,-1280},{470,
              -1260}})));
    Buildings.Fluid.Sources.Boundary_pT BR4_out(
      redeclare package Medium = Buildings.Media.Water,
      T=323.15,
      nPorts=1) annotation (Placement(transformation(extent={{676,-1268},{656,
              -1248}})));
    Buildings.Fluid.Movers.Preconfigured.FlowControlled_m_flow BR4_pump(
      redeclare package Medium = Buildings.Media.Water,
      addPowerToMedium=false,
      m_flow_nominal=0.650/(4.184*10))
                                     annotation (Placement(transformation(
            extent={{512,-1268},{532,-1248}})));
    Buildings.Controls.OBC.CDL.Reals.PID BR4_conP(
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
      k=0.5,
      Ti=100,
      yMax=1,
      yMin=0) annotation (Placement(transformation(extent={{238,-1236},{262,
              -1212}})));
    Modelica.Blocks.Math.Gain BR4_mflow(k=0.650/(4.184*10))
                                                          annotation (
        Placement(transformation(extent={{308,-1234},{328,-1214}})));
    Buildings.Fluid.HeatExchangers.SensibleCooler_T coo7(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=0.650/(4.184*10),
      dp_nominal=0)
      annotation (Placement(transformation(extent={{584,-1264},{604,-1244}})));
    Modelica.Blocks.Sources.Constant water_out7(k=water_out_temp)
      annotation (Placement(transformation(extent={{550,-1212},{570,-1192}})));
    Modelica.Blocks.Math.Product BR4_MCdeltaT annotation (Placement(
          transformation(extent={{280,-1152},{260,-1132}})));
    Modelica.Blocks.Sources.Constant CpdeltaT7(k=4184*10)
      annotation (Placement(transformation(extent={{350,-1144},{330,-1124}})));
    Buildings.HeatTransfer.Sources.PrescribedHeatFlow BR4_Qrad annotation (
        Placement(transformation(extent={{206,-1152},{186,-1132}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone bathroom(
      redeclare package Medium = Medium,
      zoneName="TopXfloor:Bathroom",
      nPorts=2) "Thermal zone"
      annotation (Placement(transformation(extent={{62,-1448},{102,-1408}})));
    Buildings.Fluid.FixedResistances.PressureDrop duc8(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      linearized=true,
      from_dp=true,
      dp_nominal=100,
      m_flow_nominal=bathroom_infil)
      "Duct resistance (to decouple room and outside pressure)"
      annotation (Placement(transformation(extent={{56,-1476},{36,-1456}})));
    Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir8(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=bathroom_infil)    "Boundary condition"
      annotation (Placement(transformation(extent={{24,-1506},{44,-1486}})));
    Buildings.Fluid.Sources.Boundary_pT pAtm8(redeclare package Medium =
          Medium, nPorts=1)
                  "Boundary condition"
      annotation (Placement(transformation(extent={{-14,-1476},{6,-1456}})));
    Modelica.Blocks.Sources.Constant qIntGai8
                                            [3](each k=0)
      "Internal heat gains, set to zero because these are modeled in EnergyPlus"
      annotation (Placement(transformation(extent={{12,-1428},{32,-1408}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToReal bathroom_Tset(realTrue=
          273.15 + 22, realFalse=273.15 + 18) annotation (Placement(
          transformation(extent={{192,-1402},{212,-1382}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable bathroom_occ(name=
          "Zone People Occupant Count", key="TopXfloor:Bathroom") annotation (
       Placement(transformation(extent={{106,-1404},{132,-1378}})));
    Buildings.Controls.OBC.CDL.Reals.GreaterThreshold bathroom_is_Occ
      annotation (Placement(transformation(extent={{152,-1404},{178,-1378}})));
    Buildings.Fluid.Sources.Boundary_pT bathroom_in(
      redeclare package Medium = Buildings.Media.Water,
      T=333.15,
      nPorts=1) annotation (Placement(transformation(extent={{444,-1504},{464,
              -1484}})));
    Buildings.Fluid.Sources.Boundary_pT bathroom_out(
      redeclare package Medium = Buildings.Media.Water,
      T=323.15,
      nPorts=1) annotation (Placement(transformation(extent={{670,-1492},{650,
              -1472}})));
    Buildings.Fluid.Movers.Preconfigured.FlowControlled_m_flow bathroom_pump(
      redeclare package Medium = Buildings.Media.Water,
      addPowerToMedium=false,
      m_flow_nominal=0.45/(4.184*10))
                                     annotation (Placement(transformation(
            extent={{506,-1492},{526,-1472}})));
    Buildings.Controls.OBC.CDL.Reals.PID bathroom_conP(
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
      k=0.5,
      Ti=100,
      yMax=1,
      yMin=0) annotation (Placement(transformation(extent={{238,-1438},{262,
              -1414}})));
    Modelica.Blocks.Math.Gain bathroom_mflow(k=0.45/(4.184*10))
                                                               annotation (
        Placement(transformation(extent={{308,-1436},{328,-1416}})));
    Buildings.Fluid.HeatExchangers.SensibleCooler_T coo8(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=0.45/(4.184*10),
      dp_nominal=0)
      annotation (Placement(transformation(extent={{576,-1486},{596,-1466}})));
    Modelica.Blocks.Sources.Constant water_out8(k=water_out_temp)
      annotation (Placement(transformation(extent={{544,-1436},{564,-1416}})));
    Modelica.Blocks.Math.Product bathroom_MCdeltaT annotation (Placement(
          transformation(extent={{280,-1354},{260,-1334}})));
    Modelica.Blocks.Sources.Constant CpdeltaT8(k=4184*10)
      annotation (Placement(transformation(extent={{350,-1346},{330,-1326}})));
    Buildings.HeatTransfer.Sources.PrescribedHeatFlow bathroom_Qrad
      annotation (Placement(transformation(extent={{206,-1354},{186,-1334}})));
    Buildings.Controls.OBC.CDL.Reals.Abs abs1
      annotation (Placement(transformation(extent={{262,60},{282,80}})));
    Buildings.Controls.OBC.CDL.Reals.Abs abs2
      annotation (Placement(transformation(extent={{280,-122},{300,-102}})));
    Buildings.Controls.OBC.CDL.Reals.Abs abs3
      annotation (Placement(transformation(extent={{258,-280},{278,-260}})));
    Buildings.Controls.OBC.CDL.Reals.Abs abs4
      annotation (Placement(transformation(extent={{264,-486},{284,-466}})));
    Buildings.Controls.OBC.CDL.Reals.Abs abs5
      annotation (Placement(transformation(extent={{274,-678},{294,-658}})));
    Buildings.Controls.OBC.CDL.Reals.Abs abs6
      annotation (Placement(transformation(extent={{276,-870},{296,-850}})));
    Buildings.Controls.OBC.CDL.Reals.Abs abs7 annotation (Placement(
          transformation(extent={{278,-1054},{298,-1034}})));
    Buildings.Controls.OBC.CDL.Reals.Abs abs8 annotation (Placement(
          transformation(extent={{276,-1234},{296,-1214}})));
    Buildings.Controls.OBC.CDL.Reals.Abs abs9 annotation (Placement(
          transformation(extent={{272,-1436},{292,-1416}})));
    Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
          transformation(extent={{-254,-600},{-214,-560}}),
          iconTransformation(extent={{-158,-266},{-138,-246}})));
    Buildings.Controls.OBC.CDL.Reals.Switch sittingSwitch
      annotation (Placement(transformation(extent={{336,-300},{356,-280}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{296,-332},{316,-312}})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{302,-540},{322,-520}})));
    Buildings.Controls.OBC.CDL.Reals.Switch studySwitch
      annotation (Placement(transformation(extent={{348,-516},{368,-496}})));
    Modelica.Blocks.Sources.Constant const2(k=0)
      annotation (Placement(transformation(extent={{312,-732},{332,-712}})));
    Buildings.Controls.OBC.CDL.Reals.Switch BR1Switch
      annotation (Placement(transformation(extent={{358,-708},{378,-688}})));
    Modelica.Blocks.Sources.Constant const3(k=0)
      annotation (Placement(transformation(extent={{312,-920},{332,-900}})));
    Buildings.Controls.OBC.CDL.Reals.Switch BR2Switch
      annotation (Placement(transformation(extent={{358,-896},{378,-876}})));
    Modelica.Blocks.Sources.Constant const4(k=0) annotation (Placement(
          transformation(extent={{314,-1102},{334,-1082}})));
    Buildings.Controls.OBC.CDL.Reals.Switch BR3Switch annotation (Placement(
          transformation(extent={{360,-1078},{380,-1058}})));
    Buildings.Controls.OBC.CDL.Reals.Switch BR4Switch annotation (Placement(
          transformation(extent={{370,-1258},{390,-1238}})));
    Modelica.Blocks.Sources.Constant const5(k=0) annotation (Placement(
          transformation(extent={{314,-1288},{334,-1268}})));
    Buildings.Controls.OBC.CDL.Reals.Switch bathSwitch annotation (Placement(
          transformation(extent={{370,-1462},{390,-1442}})));
    Modelica.Blocks.Sources.Constant const6(k=0) annotation (Placement(
          transformation(extent={{298,-1526},{318,-1506}})));
    Buildings.Controls.OBC.CDL.Reals.Switch diningSwitch
      annotation (Placement(transformation(extent={{364,-136},{384,-116}})));
    Modelica.Blocks.Sources.Constant const7(k=0)
      annotation (Placement(transformation(extent={{306,-170},{326,-150}})));
    Buildings.Controls.OBC.CDL.Reals.Switch kitchenSwitch
      annotation (Placement(transformation(extent={{356,48},{376,68}})));
    Modelica.Blocks.Sources.Constant const8(k=0)
      annotation (Placement(transformation(extent={{298,14},{318,34}})));
    Buildings.Controls.OBC.CDL.Reals.GreaterThreshold May27(t=12700800)
      annotation (Placement(transformation(extent={{-286,-456},{-266,-436}})));
    Modelica.Blocks.Sources.ContinuousClock continuousClock annotation (
        Placement(transformation(extent={{-328,-478},{-308,-458}})));
    Buildings.Controls.OBC.CDL.Reals.LessThreshold Oct10(t=24451200)
      annotation (Placement(transformation(extent={{-282,-490},{-262,-470}})));
    Buildings.Controls.OBC.CDL.Logical.And summertrue annotation (Placement(
          transformation(extent={{-244,-466},{-224,-446}})));
    Buildings.Controls.OBC.CDL.Logical.Not summerFalse annotation (Placement(
          transformation(extent={{-214,-466},{-194,-446}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone toilet(
      redeclare package Medium = Medium,
      zoneName="TopXfloor:Toilet",
      nPorts=2) "Thermal zone"
      annotation (Placement(transformation(extent={{98,-1684},{138,-1644}})));
    Buildings.Fluid.FixedResistances.PressureDrop duc9(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      linearized=true,
      from_dp=true,
      dp_nominal=100,
      m_flow_nominal=toilet_infil)
      "Duct resistance (to decouple room and outside pressure)"
      annotation (Placement(transformation(extent={{92,-1712},{72,-1692}})));
    Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir9(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=bathroom_infil)    "Boundary condition"
      annotation (Placement(transformation(extent={{60,-1742},{80,-1722}})));
    Buildings.Fluid.Sources.Boundary_pT pAtm9(redeclare package Medium =
          Medium, nPorts=1)
                  "Boundary condition"
      annotation (Placement(transformation(extent={{22,-1712},{42,-1692}})));
    Modelica.Blocks.Sources.Constant qIntGai9
                                            [3](each k=0)
      "Internal heat gains, set to zero because these are modeled in EnergyPlus"
      annotation (Placement(transformation(extent={{48,-1664},{68,-1644}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToReal toilet_Tset(realTrue=
          273.15 + 22, realFalse=273.15 + 18) annotation (Placement(
          transformation(extent={{228,-1638},{248,-1618}})));
    Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable toilet_occ(name=
          "Zone People Occupant Count", key="TopXfloor:Toilet") annotation (
        Placement(transformation(extent={{142,-1640},{168,-1614}})));
    Buildings.Controls.OBC.CDL.Reals.GreaterThreshold toilet_is_Occ
      annotation (Placement(transformation(extent={{188,-1640},{214,-1614}})));
    Buildings.Fluid.Sources.Boundary_pT toilet_in(
      redeclare package Medium = Buildings.Media.Water,
      T=333.15,
      nPorts=1) annotation (Placement(transformation(extent={{480,-1740},{500,
              -1720}})));
    Buildings.Fluid.Sources.Boundary_pT toilet_out(
      redeclare package Medium = Buildings.Media.Water,
      T=323.15,
      nPorts=1) annotation (Placement(transformation(extent={{704,-1728},{684,
              -1708}})));
    Buildings.Fluid.Movers.Preconfigured.FlowControlled_m_flow toilet_pump(
      redeclare package Medium = Buildings.Media.Water,
      addPowerToMedium=false,
      m_flow_nominal=0.32/(4.184*10)) annotation (Placement(transformation(
            extent={{542,-1728},{562,-1708}})));
    Buildings.Controls.OBC.CDL.Reals.PID toilet_conP(
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
      k=0.5,
      Ti=100,
      yMax=1,
      yMin=0) annotation (Placement(transformation(extent={{274,-1674},{298,
              -1650}})));
    Modelica.Blocks.Math.Gain toilet_mflow(k=0.3/(4.184*10)) annotation (
        Placement(transformation(extent={{344,-1672},{364,-1652}})));
    Buildings.Fluid.HeatExchangers.SensibleCooler_T coo9(
      redeclare package Medium = Buildings.Media.Water,
      m_flow_nominal=0.32/(4.184*10),
      dp_nominal=0)
      annotation (Placement(transformation(extent={{612,-1722},{632,-1702}})));
    Modelica.Blocks.Sources.Constant water_out9(k=water_out_temp)
      annotation (Placement(transformation(extent={{580,-1672},{600,-1652}})));
    Modelica.Blocks.Math.Product bathroom_MCdeltaT1
                                                   annotation (Placement(
          transformation(extent={{316,-1590},{296,-1570}})));
    Modelica.Blocks.Sources.Constant CpdeltaT9(k=4184*10)
      annotation (Placement(transformation(extent={{386,-1582},{366,-1562}})));
    Buildings.HeatTransfer.Sources.PrescribedHeatFlow bathroom_Qrad1
      annotation (Placement(transformation(extent={{242,-1590},{222,-1570}})));
    Buildings.Controls.OBC.CDL.Reals.Abs abs10
                                              annotation (Placement(
          transformation(extent={{308,-1672},{328,-1652}})));
    Buildings.Controls.OBC.CDL.Reals.Switch bathSwitch1
                                                       annotation (Placement(
          transformation(extent={{406,-1698},{426,-1678}})));
    Modelica.Blocks.Sources.Constant const9(k=0) annotation (Placement(
          transformation(extent={{334,-1762},{354,-1742}})));
  equation
    connect(pAtm.ports[1], duc.port_b)
      annotation (Line(points={{12,32},{42,32}}, color={0,127,255}));
    connect(duc.port_a, Kitchen.ports[1]) annotation (Line(points={{62,32},{85,32},
            {85,50.9}},        color={0,127,255}));
    connect(freshAir.ports[1], Kitchen.ports[2])
      annotation (Line(points={{50,0},{87,0},{87,50.9}}, color={0,127,255}));
    connect(building.weaBus, freshAir.weaBus) annotation (Line(
        points={{-276,-632},{-180,-632},{-180,-294},{-96,-294},{-96,-176},{
            -16,-176},{-16,0.2},{30,0.2}},
        color={255,204,51},
        thickness=0.5));
    connect(qIntGai.y, Kitchen.qGai_flow)
      annotation (Line(points={{39,80},{64,80}}, color={0,0,127}));
    connect(kitchen_occ.y, kitchen_is_Occ.u)
      annotation (Line(points={{139.3,107},{155.4,107}}, color={0,0,127}));
    connect(kitchen_in.ports[1], kitchen_pump.port_a) annotation (Line(points={{464,36},
            {464,48},{506,48}},              color={0,127,255}));
    connect(kitchen_is_Occ.y, kitchen_Tset.u) annotation (Line(points={{186.6,107},
            {186.6,106},{196,106}}, color={255,0,255}));
    connect(Kitchen.TAir, kitchen_conP.u_m) annotation (Line(points={{107,88},
            {152,88},{152,36},{242,36},{242,55.6}},
                                               color={0,0,127}));
    connect(kitchen_Tset.y, kitchen_conP.u_s) annotation (Line(points={{220,106},
            {220,88},{227.6,88},{227.6,70}},
                                           color={0,0,127}));
    connect(water_out.y, coo.TSet) annotation (Line(points={{565,104},{565,80},
            {574,80},{574,60}},              color={0,0,127}));
    connect(CpdeltaT.y, kitchen_MCdeltaT.u1)
      annotation (Line(points={{335,162},{335,160},{288,160}}, color={0,0,127}));
    connect(kitchen_MCdeltaT.y, kitchen_Qrad.Q_flow)
      annotation (Line(points={{265,154},{212,154}}, color={0,0,127}));
    connect(kitchen_Qrad.port, Kitchen.heaPorAir)
      annotation (Line(points={{192,154},{86,154},{86,70}}, color={191,0,0}));
    connect(kitchen_pump.port_b, coo.port_a) annotation (Line(points={{526,48},
            {526,52},{576,52}},     color={0,127,255}));
    connect(coo.port_b, kitchen_out.ports[1])
      annotation (Line(points={{596,52},{600,52},{600,48},{650,48}},
                                                            color={0,127,255}));
    connect(pAtm1.ports[1], duc1.port_b)
      annotation (Line(points={{14,-150},{44,-150}}, color={0,127,255}));
    connect(duc1.port_a, Dining.ports[1]) annotation (Line(points={{64,-150},{87,-150},
            {87,-131.1}}, color={0,127,255}));
    connect(freshAir1.ports[1], Dining.ports[2]) annotation (Line(points={{52,-182},
            {89,-182},{89,-131.1}}, color={0,127,255}));
    connect(building.weaBus, freshAir1.weaBus) annotation (Line(
        points={{-276,-632},{-148,-632},{-148,-330},{-96,-330},{-96,-181.8},{
            32,-181.8}},
        color={255,204,51},
        thickness=0.5));
    connect(qIntGai1.y, Dining.qGai_flow)
      annotation (Line(points={{41,-102},{66,-102}}, color={0,0,127}));
    connect(dining_occ.y, dining_is_Occ.u)
      annotation (Line(points={{141.3,-75},{157.4,-75}}, color={0,0,127}));
    connect(dining_in.ports[1], dining_pump.port_a) annotation (Line(points={{468,
            -156},{468,-144},{510,-144}},            color={0,127,255}));
    connect(dining_is_Occ.y, dining_Tset.u) annotation (Line(points={{188.6,-75},{
            188.6,-76},{198,-76}}, color={255,0,255}));
    connect(Dining.TAir, dining_conP.u_m) annotation (Line(points={{109,-94},
            {204,-94},{204,-130},{256,-130},{256,-126.4}},
                                                      color={0,0,127}));
    connect(dining_Tset.y, dining_conP.u_s) annotation (Line(points={{222,-76},
            {238,-76},{238,-112},{241.6,-112}},
                                           color={0,0,127}));
    connect(water_out1.y, coo1.TSet) annotation (Line(points={{569,-88},{569,
            -120},{578,-120},{578,-134}},                 color={0,0,127}));
    connect(CpdeltaT1.y, dining_MCdeltaT.u1)
      annotation (Line(points={{337,-20},{337,-22},{290,-22}}, color={0,0,127}));
    connect(dining_MCdeltaT.y, dining_Qrad.Q_flow)
      annotation (Line(points={{267,-28},{214,-28}}, color={0,0,127}));
    connect(dining_Qrad.port, Dining.heaPorAir)
      annotation (Line(points={{194,-28},{88,-28},{88,-112}}, color={191,0,0}));
    connect(dining_pump.port_b, coo1.port_a) annotation (Line(points={{530,
            -144},{555,-144},{555,-142},{580,-142}},
                                              color={0,127,255}));
    connect(coo1.port_b, dining_out.ports[1]) annotation (Line(points={{600,
            -142},{627,-142},{627,-146},{654,-146}},
                                    color={0,127,255}));
    connect(pAtm2.ports[1],duc2. port_b)
      annotation (Line(points={{6,-326},{36,-326}},  color={0,127,255}));
    connect(duc2.port_a, Sitting.ports[1]) annotation (Line(points={{56,-326},{79,
            -326},{79,-307.1}}, color={0,127,255}));
    connect(freshAir2.ports[1], Sitting.ports[2]) annotation (Line(points={{44,-358},
            {81,-358},{81,-307.1}}, color={0,127,255}));
    connect(building.weaBus,freshAir2. weaBus) annotation (Line(
        points={{-276,-632},{-120,-632},{-120,-357.8},{24,-357.8}},
        color={255,204,51},
        thickness=0.5));
    connect(qIntGai2.y, Sitting.qGai_flow)
      annotation (Line(points={{33,-278},{58,-278}}, color={0,0,127}));
    connect(sitting_occ.y, sitting_is_Occ.u)
      annotation (Line(points={{127.3,-233},{145.4,-233}}, color={0,0,127}));
    connect(sitting_in.ports[1], sitting_pump.port_a) annotation (Line(points={{388,
            -330},{406,-330},{406,-302}},            color={0,127,255}));
    connect(sitting_is_Occ.y, sitting_Tset.u) annotation (Line(points={{176.6,
            -233},{183.3,-233},{183.3,-230},{190,-230}},
                                      color={255,0,255}));
    connect(Sitting.TAir, sitting_conP.u_m) annotation (Line(points={{101,
            -270},{184,-270},{184,-304},{232,-304},{232,-284.4}},
                                                       color={0,0,127}));
    connect(sitting_Tset.y, sitting_conP.u_s) annotation (Line(points={{214,
            -230},{214,-250},{217.6,-250},{217.6,-270}},
                                                 color={0,0,127}));
    connect(water_out2.y,coo2. TSet) annotation (Line(points={{465,-246},{465,
            -270},{474,-270},{474,-290}},                 color={0,0,127}));
    connect(CpdeltaT2.y, sitting_MCdeltaT.u1) annotation (Line(points={{329,-196},
            {329,-198},{282,-198}}, color={0,0,127}));
    connect(sitting_MCdeltaT.y, sitting_Qrad.Q_flow)
      annotation (Line(points={{259,-204},{206,-204}}, color={0,0,127}));
    connect(sitting_Qrad.port, Sitting.heaPorAir) annotation (Line(points={{186,-204},
            {80,-204},{80,-288}}, color={191,0,0}));
    connect(sitting_pump.port_b, coo2.port_a) annotation (Line(points={{426,
            -302},{426,-298},{476,-298}},      color={0,127,255}));
    connect(coo2.port_b, sitting_out.ports[1]) annotation (Line(points={{496,
            -298},{496,-302},{550,-302}},
                                    color={0,127,255}));
    connect(pAtm3.ports[1],duc3. port_b)
      annotation (Line(points={{-4,-516},{26,-516}}, color={0,127,255}));
    connect(duc3.port_a, Study.ports[1]) annotation (Line(points={{46,-516},{69,-516},
            {69,-497.1}}, color={0,127,255}));
    connect(freshAir3.ports[1], Study.ports[2]) annotation (Line(points={{34,-546},
            {71,-546},{71,-497.1}}, color={0,127,255}));
    connect(building.weaBus,freshAir3. weaBus) annotation (Line(
        points={{-276,-632},{-122,-632},{-122,-552},{-54,-552},{-54,-545.8},{
            14,-545.8}},
        color={255,204,51},
        thickness=0.5));
    connect(qIntGai3.y, Study.qGai_flow)
      annotation (Line(points={{23,-468},{48,-468}}, color={0,0,127}));
    connect(study_occ.y, study_is_Occ.u)
      annotation (Line(points={{123.3,-441},{139.4,-441}}, color={0,0,127}));
    connect(study_in.ports[1], study_pump.port_a) annotation (Line(points={{462,
            -528},{462,-518},{504,-518}},      color={0,127,255}));
    connect(study_is_Occ.y, study_Tset.u) annotation (Line(points={{170.6,-441},{170.6,
            -442},{180,-442}}, color={255,0,255}));
    connect(Study.TAir, study_conP.u_m) annotation (Line(points={{91,-460},{186,-460},
            {186,-496},{240,-496},{240,-490.4}}, color={0,0,127}));
    connect(study_Tset.y, study_conP.u_s) annotation (Line(points={{204,-442},{220,
            -442},{220,-476},{225.6,-476}}, color={0,0,127}));
    connect(water_out3.y,coo3. TSet) annotation (Line(points={{563,-462},{563,
            -480},{572,-480},{572,-506}},                 color={0,0,127}));
    connect(CpdeltaT3.y, study_MCdeltaT.u1) annotation (Line(points={{319,-386},{319,
            -388},{272,-388}}, color={0,0,127}));
    connect(study_MCdeltaT.y, study_Qrad.Q_flow)
      annotation (Line(points={{249,-394},{196,-394}}, color={0,0,127}));
    connect(study_Qrad.port, Study.heaPorAir) annotation (Line(points={{176,-394},
            {70,-394},{70,-478}}, color={191,0,0}));
    connect(study_pump.port_b, coo3.port_a) annotation (Line(points={{524,
            -518},{524,-514},{574,-514}}, color={0,127,255}));
    connect(coo3.port_b, study_out.ports[1]) annotation (Line(points={{594,
            -514},{594,-518},{648,-518}},
                                   color={0,127,255}));
    connect(pAtm4.ports[1],duc4. port_b)
      annotation (Line(points={{6,-706},{36,-706}},  color={0,127,255}));
    connect(duc4.port_a, BR1.ports[1]) annotation (Line(points={{56,-706},{81,-706},
            {81,-687.1}}, color={0,127,255}));
    connect(freshAir4.ports[1], BR1.ports[2]) annotation (Line(points={{44,-736},{
            83,-736},{83,-687.1}}, color={0,127,255}));
    connect(building.weaBus,freshAir4. weaBus) annotation (Line(
        points={{-276,-632},{-120,-632},{-120,-735.8},{24,-735.8}},
        color={255,204,51},
        thickness=0.5));
    connect(qIntGai4.y, BR1.qGai_flow)
      annotation (Line(points={{33,-658},{60,-658}}, color={0,0,127}));
    connect(BR1_occ.y, BR1_is_Occ.u)
      annotation (Line(points={{133.3,-631},{149.4,-631}}, color={0,0,127}));
    connect(BR1_in.ports[1], BR1_pump.port_a) annotation (Line(points={{468,
            -724},{468,-712},{510,-712}},      color={0,127,255}));
    connect(BR1_is_Occ.y, BR1_Tset.u) annotation (Line(points={{180.6,-631},{180.6,
            -632},{190,-632}}, color={255,0,255}));
    connect(BR1.TAir, BR1_conP.u_m) annotation (Line(points={{103,-650},{196,-650},
            {196,-686},{250,-686},{250,-680.4}}, color={0,0,127}));
    connect(BR1_Tset.y, BR1_conP.u_s) annotation (Line(points={{214,-632},{230,-632},
            {230,-666},{235.6,-666}}, color={0,0,127}));
    connect(water_out4.y,coo4. TSet) annotation (Line(points={{569,-656},{569,
            -680},{578,-680},{578,-700}},                 color={0,0,127}));
    connect(CpdeltaT4.y, BR1_MCdeltaT.u1) annotation (Line(points={{329,-576},{329,
            -578},{282,-578}}, color={0,0,127}));
    connect(BR1_MCdeltaT.y, BR1_Qrad.Q_flow)
      annotation (Line(points={{259,-584},{206,-584}}, color={0,0,127}));
    connect(BR1_Qrad.port, BR1.heaPorAir) annotation (Line(points={{186,-584},{82,
            -584},{82,-668}}, color={191,0,0}));
    connect(BR1_pump.port_b, coo4.port_a) annotation (Line(points={{530,-712},
            {530,-708},{580,-708}},       color={0,127,255}));
    connect(coo4.port_b, BR1_out.ports[1]) annotation (Line(points={{600,-708},
            {600,-712},{654,-712}},
                               color={0,127,255}));
    connect(pAtm5.ports[1],duc5. port_b)
      annotation (Line(points={{6,-898},{36,-898}},  color={0,127,255}));
    connect(duc5.port_a, BR2.ports[1]) annotation (Line(points={{56,-898},{81,-898},
            {81,-879.1}}, color={0,127,255}));
    connect(freshAir5.ports[1], BR2.ports[2]) annotation (Line(points={{44,-928},{
            83,-928},{83,-879.1}}, color={0,127,255}));
    connect(building.weaBus,freshAir5. weaBus) annotation (Line(
        points={{-276,-632},{-120,-632},{-120,-927.8},{24,-927.8}},
        color={255,204,51},
        thickness=0.5));
    connect(qIntGai5.y, BR2.qGai_flow)
      annotation (Line(points={{33,-850},{60,-850}}, color={0,0,127}));
    connect(BR2_occ.y, BR2_is_Occ.u)
      annotation (Line(points={{133.3,-823},{149.4,-823}}, color={0,0,127}));
    connect(BR2_in.ports[1], BR2_pump.port_a) annotation (Line(points={{458,
            -920},{480,-920},{480,-908},{500,-908}},
                                               color={0,127,255}));
    connect(BR2_is_Occ.y, BR2_Tset.u) annotation (Line(points={{180.6,-823},{
            180.6,-822},{190,-822}}, color={255,0,255}));
    connect(BR2.TAir, BR2_conP.u_m) annotation (Line(points={{103,-842},{196,
            -842},{196,-878},{250,-878},{250,-872.4}}, color={0,0,127}));
    connect(BR2_Tset.y, BR2_conP.u_s) annotation (Line(points={{214,-822},{
            230,-822},{230,-858},{235.6,-858}}, color={0,0,127}));
    connect(water_out5.y,coo5. TSet) annotation (Line(points={{559,-852},{559,
            -880},{568,-880},{568,-896}},                 color={0,0,127}));
    connect(CpdeltaT5.y, BR2_MCdeltaT.u1) annotation (Line(points={{329,-768},
            {329,-770},{282,-770}}, color={0,0,127}));
    connect(BR2_MCdeltaT.y, BR2_Qrad.Q_flow)
      annotation (Line(points={{259,-776},{206,-776}}, color={0,0,127}));
    connect(BR2_Qrad.port, BR2.heaPorAir) annotation (Line(points={{186,-776},
            {82,-776},{82,-860}}, color={191,0,0}));
    connect(BR2_pump.port_b, coo5.port_a) annotation (Line(points={{520,-908},
            {545,-908},{545,-904},{570,-904}}, color={0,127,255}));
    connect(coo5.port_b, BR2_out.ports[1]) annotation (Line(points={{590,-904},
            {617,-904},{617,-908},{644,-908}},
                                    color={0,127,255}));
    connect(pAtm6.ports[1],duc6. port_b)
      annotation (Line(points={{6,-1084},{36,-1084}},color={0,127,255}));
    connect(duc6.port_a, BR3.ports[1]) annotation (Line(points={{56,-1084},{81,-1084},
            {81,-1065.1}}, color={0,127,255}));
    connect(freshAir6.ports[1], BR3.ports[2]) annotation (Line(points={{44,-1114},
            {83,-1114},{83,-1065.1}}, color={0,127,255}));
    connect(building.weaBus,freshAir6. weaBus) annotation (Line(
        points={{-276,-632},{-120,-632},{-120,-1136},{24,-1136},{24,-1113.8}},
        color={255,204,51},
        thickness=0.5));
    connect(qIntGai6.y, BR3.qGai_flow)
      annotation (Line(points={{33,-1036},{60,-1036}}, color={0,0,127}));
    connect(BR3_occ.y, BR3_is_Occ.u) annotation (Line(points={{133.3,-1009},{
            149.4,-1009}}, color={0,0,127}));
    connect(BR3_in.ports[1], BR3_pump.port_a) annotation (Line(points={{468,
            -1094},{496,-1094},{496,-1082},{510,-1082}},
                                                  color={0,127,255}));
    connect(BR3_is_Occ.y, BR3_Tset.u) annotation (Line(points={{180.6,-1009},
            {180.6,-1010},{190,-1010}}, color={255,0,255}));
    connect(BR3.TAir, BR3_conP.u_m) annotation (Line(points={{103,-1028},{196,
            -1028},{196,-1064},{250,-1064},{250,-1058.4}}, color={0,0,127}));
    connect(BR3_Tset.y, BR3_conP.u_s) annotation (Line(points={{214,-1010},{
            230,-1010},{230,-1044},{235.6,-1044}}, color={0,0,127}));
    connect(water_out6.y,coo6. TSet) annotation (Line(points={{569,-1026},{
            569,-1056},{578,-1056},{578,-1070}},          color={0,0,127}));
    connect(CpdeltaT6.y, BR3_MCdeltaT.u1) annotation (Line(points={{329,-954},
            {329,-956},{282,-956}}, color={0,0,127}));
    connect(BR3_MCdeltaT.y, BR3_Qrad.Q_flow)
      annotation (Line(points={{259,-962},{206,-962}}, color={0,0,127}));
    connect(BR3_Qrad.port, BR3.heaPorAir) annotation (Line(points={{186,-962},
            {82,-962},{82,-1046}}, color={191,0,0}));
    connect(BR3_pump.port_b, coo6.port_a) annotation (Line(points={{530,-1082},
            {555,-1082},{555,-1078},{580,-1078}}, color={0,127,255}));
    connect(coo6.port_b, BR3_out.ports[1]) annotation (Line(points={{600,
            -1078},{627,-1078},{627,-1082},{654,-1082}},
                                      color={0,127,255}));
    connect(pAtm7.ports[1],duc7. port_b)
      annotation (Line(points={{6,-1264},{36,-1264}},color={0,127,255}));
    connect(duc7.port_a, BR4.ports[1]) annotation (Line(points={{56,-1264},{
            81,-1264},{81,-1245.1}}, color={0,127,255}));
    connect(freshAir7.ports[1], BR4.ports[2]) annotation (Line(points={{44,
            -1294},{83,-1294},{83,-1245.1}}, color={0,127,255}));
    connect(building.weaBus,freshAir7. weaBus) annotation (Line(
        points={{-276,-632},{-120,-632},{-120,-1293.8},{24,-1293.8}},
        color={255,204,51},
        thickness=0.5));
    connect(qIntGai7.y, BR4.qGai_flow)
      annotation (Line(points={{33,-1216},{60,-1216}}, color={0,0,127}));
    connect(BR4_occ.y, BR4_is_Occ.u) annotation (Line(points={{133.3,-1189},{
            149.4,-1189}}, color={0,0,127}));
    connect(BR4_in.ports[1], BR4_pump.port_a) annotation (Line(points={{470,
            -1270},{496,-1270},{496,-1258},{512,-1258}}, color={0,127,255}));
    connect(BR4_is_Occ.y, BR4_Tset.u) annotation (Line(points={{180.6,-1189},
            {180.6,-1190},{190,-1190}}, color={255,0,255}));
    connect(BR4.TAir, BR4_conP.u_m) annotation (Line(points={{103,-1208},{196,
            -1208},{196,-1244},{250,-1244},{250,-1238.4}}, color={0,0,127}));
    connect(BR4_Tset.y, BR4_conP.u_s) annotation (Line(points={{214,-1190},{
            230,-1190},{230,-1224},{235.6,-1224}}, color={0,0,127}));
    connect(water_out7.y,coo7. TSet) annotation (Line(points={{571,-1202},{
            571,-1224},{582,-1224},{582,-1246}},          color={0,0,127}));
    connect(CpdeltaT7.y, BR4_MCdeltaT.u1) annotation (Line(points={{329,-1134},
            {329,-1136},{282,-1136}}, color={0,0,127}));
    connect(BR4_MCdeltaT.y, BR4_Qrad.Q_flow)
      annotation (Line(points={{259,-1142},{206,-1142}}, color={0,0,127}));
    connect(BR4_Qrad.port, BR4.heaPorAir) annotation (Line(points={{186,-1142},
            {82,-1142},{82,-1226}}, color={191,0,0}));
    connect(BR4_pump.port_b, coo7.port_a) annotation (Line(points={{532,-1258},
            {558,-1258},{558,-1254},{584,-1254}}, color={0,127,255}));
    connect(coo7.port_b, BR4_out.ports[1]) annotation (Line(points={{604,
            -1254},{630,-1254},{630,-1258},{656,-1258}},
                                             color={0,127,255}));
    connect(pAtm8.ports[1],duc8. port_b)
      annotation (Line(points={{6,-1466},{36,-1466}},color={0,127,255}));
    connect(duc8.port_a, bathroom.ports[1]) annotation (Line(points={{56,
            -1466},{81,-1466},{81,-1447.1}}, color={0,127,255}));
    connect(freshAir8.ports[1], bathroom.ports[2]) annotation (Line(points={{
            44,-1496},{83,-1496},{83,-1447.1}}, color={0,127,255}));
    connect(building.weaBus,freshAir8. weaBus) annotation (Line(
        points={{-276,-632},{-120,-632},{-120,-1262},{-32,-1262},{-32,-1495.8},
            {24,-1495.8}},
        color={255,204,51},
        thickness=0.5));
    connect(qIntGai8.y, bathroom.qGai_flow)
      annotation (Line(points={{33,-1418},{60,-1418}}, color={0,0,127}));
    connect(bathroom_occ.y, bathroom_is_Occ.u) annotation (Line(points={{
            133.3,-1391},{149.4,-1391}}, color={0,0,127}));
    connect(bathroom_in.ports[1], bathroom_pump.port_a) annotation (Line(
          points={{464,-1494},{488,-1494},{488,-1482},{506,-1482}}, color={0,
            127,255}));
    connect(bathroom_is_Occ.y, bathroom_Tset.u) annotation (Line(points={{
            180.6,-1391},{180.6,-1392},{190,-1392}}, color={255,0,255}));
    connect(bathroom.TAir, bathroom_conP.u_m) annotation (Line(points={{103,
            -1410},{196,-1410},{196,-1446},{250,-1446},{250,-1440.4}}, color=
            {0,0,127}));
    connect(bathroom_Tset.y, bathroom_conP.u_s) annotation (Line(points={{214,
            -1392},{230,-1392},{230,-1426},{235.6,-1426}}, color={0,0,127}));
    connect(water_out8.y,coo8. TSet) annotation (Line(points={{565,-1426},{
            565,-1448},{574,-1448},{574,-1468}},          color={0,0,127}));
    connect(CpdeltaT8.y, bathroom_MCdeltaT.u1) annotation (Line(points={{329,
            -1336},{329,-1338},{282,-1338}}, color={0,0,127}));
    connect(bathroom_MCdeltaT.y, bathroom_Qrad.Q_flow)
      annotation (Line(points={{259,-1344},{206,-1344}}, color={0,0,127}));
    connect(bathroom_Qrad.port, bathroom.heaPorAir) annotation (Line(points={
            {186,-1344},{82,-1344},{82,-1428}}, color={191,0,0}));
    connect(bathroom_pump.port_b, coo8.port_a) annotation (Line(points={{526,
            -1482},{526,-1476},{576,-1476}},             color={0,127,255}));
    connect(coo8.port_b, bathroom_out.ports[1]) annotation (Line(points={{596,
            -1476},{600,-1476},{600,-1482},{650,-1482}},
                                             color={0,127,255}));
    connect(kitchen_mflow.u, abs1.y) annotation (Line(points={{290,70},{288,
            70},{288,70},{284,70}}, color={0,0,127}));
    connect(kitchen_conP.y, abs1.u)
      annotation (Line(points={{256.4,70},{260,70}}, color={0,0,127}));
    connect(dining_conP.y, abs2.u)
      annotation (Line(points={{270.4,-112},{278,-112}}, color={0,0,127}));
    connect(dining_mflow.u, abs2.y)
      annotation (Line(points={{310,-112},{302,-112}}, color={0,0,127}));
    connect(sitting_conP.y, abs3.u)
      annotation (Line(points={{246.4,-270},{256,-270}}, color={0,0,127}));
    connect(sitting_mflow.u, abs3.y)
      annotation (Line(points={{292,-270},{280,-270}}, color={0,0,127}));
    connect(study_conP.y, abs4.u)
      annotation (Line(points={{254.4,-476},{262,-476}}, color={0,0,127}));
    connect(study_mflow.u, abs4.y) annotation (Line(points={{298,-478},{286,
            -478},{286,-476}}, color={0,0,127}));
    connect(BR1_conP.y, abs5.u) annotation (Line(points={{264.4,-666},{268.2,
            -666},{268.2,-668},{272,-668}}, color={0,0,127}));
    connect(BR1_mflow.u, abs5.y)
      annotation (Line(points={{306,-668},{296,-668}}, color={0,0,127}));
    connect(BR2_conP.y, abs6.u) annotation (Line(points={{264.4,-858},{269.2,
            -858},{269.2,-860},{274,-860}}, color={0,0,127}));
    connect(BR2_mflow.u, abs6.y)
      annotation (Line(points={{306,-860},{298,-860}}, color={0,0,127}));
    connect(BR3_conP.y, abs7.u)
      annotation (Line(points={{264.4,-1044},{276,-1044}}, color={0,0,127}));
    connect(BR3_mflow.u, abs7.y) annotation (Line(points={{306,-1042},{304,
            -1042},{304,-1044},{300,-1044}}, color={0,0,127}));
    connect(BR4_conP.y, abs8.u)
      annotation (Line(points={{264.4,-1224},{274,-1224}}, color={0,0,127}));
    connect(BR4_mflow.u, abs8.y)
      annotation (Line(points={{306,-1224},{298,-1224}}, color={0,0,127}));
    connect(bathroom_conP.y, abs9.u)
      annotation (Line(points={{264.4,-1426},{270,-1426}}, color={0,0,127}));
    connect(bathroom_mflow.u, abs9.y)
      annotation (Line(points={{306,-1426},{294,-1426}}, color={0,0,127}));
    connect(building.weaBus, weaBus) annotation (Line(
        points={{-276,-632},{-276,-640},{-234,-640},{-234,-580}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sitting_mflow.y, sittingSwitch.u1) annotation (Line(points={{315,
            -270},{315,-282},{334,-282}}, color={0,0,127}));
    connect(sittingSwitch.y, sitting_pump.m_flow_in)
      annotation (Line(points={{358,-290},{416,-290}}, color={0,0,127}));
    connect(sittingSwitch.y, sitting_MCdeltaT.u2) annotation (Line(points={{
            358,-290},{378,-290},{378,-222},{318,-222},{318,-210},{282,-210}},
          color={0,0,127}));
    connect(const.y, sittingSwitch.u3) annotation (Line(points={{317,-322},{
            317,-312},{334,-312},{334,-298}}, color={0,0,127}));
    connect(const1.y, studySwitch.u3) annotation (Line(points={{323,-530},{
            346,-530},{346,-514}}, color={0,0,127}));
    connect(study_mflow.y, studySwitch.u1) annotation (Line(points={{321,-478},
            {321,-498},{346,-498}}, color={0,0,127}));
    connect(studySwitch.y, study_MCdeltaT.u2) annotation (Line(points={{370,
            -506},{384,-506},{384,-406},{296,-406},{296,-400},{272,-400}},
          color={0,0,127}));
    connect(studySwitch.y, study_pump.m_flow_in) annotation (Line(points={{
            370,-506},{384,-506},{384,-480},{514,-480},{514,-506}}, color={0,
            0,127}));
    connect(BR1Switch.y, BR1_pump.m_flow_in) annotation (Line(points={{380,
            -698},{486,-698},{486,-700},{520,-700}}, color={0,0,127}));
    connect(BR1Switch.y, BR1_MCdeltaT.u2) annotation (Line(points={{380,-698},
            {400,-698},{400,-606},{304,-606},{304,-590},{282,-590}}, color={0,
            0,127}));
    connect(const2.y, BR1Switch.u3) annotation (Line(points={{333,-722},{344,
            -722},{344,-706},{356,-706}}, color={0,0,127}));
    connect(BR1_mflow.y, BR1Switch.u1) annotation (Line(points={{329,-668},{
            329,-690},{356,-690}}, color={0,0,127}));
    connect(BR2Switch.y, BR2_pump.m_flow_in) annotation (Line(points={{380,
            -886},{488,-886},{488,-872},{510,-872},{510,-896}}, color={0,0,
            127}));
    connect(BR2Switch.y, BR2_MCdeltaT.u2) annotation (Line(points={{380,-886},
            {392,-886},{392,-800},{304,-800},{304,-782},{282,-782}}, color={0,
            0,127}));
    connect(BR2_mflow.y, BR2Switch.u1) annotation (Line(points={{329,-860},{
            329,-878},{356,-878}}, color={0,0,127}));
    connect(const3.y, BR2Switch.u3) annotation (Line(points={{333,-910},{344,
            -910},{344,-894},{356,-894}}, color={0,0,127}));
    connect(BR3Switch.y, BR3_MCdeltaT.u2) annotation (Line(points={{382,-1068},
            {396,-1068},{396,-978},{320,-978},{320,-968},{282,-968}}, color={
            0,0,127}));
    connect(BR3Switch.y, BR3_pump.m_flow_in) annotation (Line(points={{382,
            -1068},{416,-1068},{416,-1046},{520,-1046},{520,-1070}}, color={0,
            0,127}));
    connect(const4.y, BR3Switch.u3) annotation (Line(points={{335,-1092},{344,
            -1092},{344,-1076},{358,-1076}}, color={0,0,127}));
    connect(BR3_mflow.y, BR3Switch.u1) annotation (Line(points={{329,-1042},{
            336,-1042},{336,-1060},{358,-1060}}, color={0,0,127}));
    connect(const5.y, BR4Switch.u3) annotation (Line(points={{335,-1278},{368,
            -1278},{368,-1256}}, color={0,0,127}));
    connect(BR4_mflow.y, BR4Switch.u1) annotation (Line(points={{329,-1224},{
            344,-1224},{344,-1240},{368,-1240}}, color={0,0,127}));
    connect(BR4Switch.y, BR4_pump.m_flow_in) annotation (Line(points={{392,
            -1248},{432,-1248},{432,-1224},{522,-1224},{522,-1246}}, color={0,
            0,127}));
    connect(BR4Switch.y, BR4_MCdeltaT.u2) annotation (Line(points={{392,-1248},
            {432,-1248},{432,-1160},{304,-1160},{304,-1148},{282,-1148}},
          color={0,0,127}));
    connect(diningSwitch.y, dining_MCdeltaT.u2) annotation (Line(points={{386,
            -126},{386,-120},{396,-120},{396,-46},{312,-46},{312,-34},{290,
            -34}}, color={0,0,127}));
    connect(diningSwitch.y, dining_pump.m_flow_in) annotation (Line(points={{
            386,-126},{386,-120},{392,-120},{392,-104},{520,-104},{520,-132}},
          color={0,0,127}));
    connect(diningSwitch.u3, const7.y) annotation (Line(points={{362,-134},{
            344,-134},{344,-160},{327,-160}}, color={0,0,127}));
    connect(diningSwitch.u1, dining_mflow.y) annotation (Line(points={{362,
            -118},{362,-112},{333,-112}}, color={0,0,127}));
    connect(kitchenSwitch.y, kitchen_MCdeltaT.u2) annotation (Line(points={{
            378,58},{392,58},{392,128},{288,128},{288,148}}, color={0,0,127}));
    connect(kitchenSwitch.y, kitchen_pump.m_flow_in) annotation (Line(points=
            {{378,58},{392,58},{392,60},{516,60}}, color={0,0,127}));
    connect(const8.y, kitchenSwitch.u3) annotation (Line(points={{319,24},{
            354,24},{354,50}}, color={0,0,127}));
    connect(kitchen_mflow.y, kitchenSwitch.u1) annotation (Line(points={{313,
            70},{313,66},{354,66}}, color={0,0,127}));
    connect(continuousClock.y,May27. u) annotation (Line(points={{-307,-468},
            {-288,-468},{-288,-446}}, color={0,0,127}));
    connect(continuousClock.y, Oct10.u) annotation (Line(points={{-307,-468},
            {-296,-468},{-296,-480},{-284,-480}}, color={0,0,127}));
    connect(Oct10.y, summertrue.u2) annotation (Line(points={{-260,-480},{
            -260,-464},{-246,-464}}, color={255,0,255}));
    connect(May27.y, summertrue.u1) annotation (Line(points={{-264,-446},{
            -264,-456},{-246,-456}}, color={255,0,255}));
    connect(summertrue.y, summerFalse.u)
      annotation (Line(points={{-222,-456},{-216,-456}}, color={255,0,255}));
    connect(summerFalse.y, sittingSwitch.u2) annotation (Line(points={{-192,
            -456},{-16,-456},{-16,-392},{56,-392},{56,-352},{262,-352},{262,
            -292},{334,-292},{334,-290}}, color={255,0,255}));
    connect(summerFalse.y, studySwitch.u2) annotation (Line(points={{-192,
            -456},{-112,-456},{-112,-584},{-24,-584},{-24,-564},{162,-564},{
            162,-506},{346,-506}}, color={255,0,255}));
    connect(summerFalse.y, BR1Switch.u2) annotation (Line(points={{-192,-456},
            {-166,-456},{-166,-762},{144,-762},{144,-700},{356,-700},{356,
            -698}}, color={255,0,255}));
    connect(summerFalse.y, BR2Switch.u2) annotation (Line(points={{-192,-456},
            {-186,-456},{-186,-950},{156,-950},{156,-886},{356,-886}}, color=
            {255,0,255}));
    connect(summerFalse.y, BR3Switch.u2) annotation (Line(points={{-192,-456},
            {-186,-456},{-186,-1152},{60,-1152},{60,-1124},{158,-1124},{158,
            -1068},{358,-1068}}, color={255,0,255}));
    connect(summerFalse.y, BR4Switch.u2) annotation (Line(points={{-192,-456},
            {-190,-456},{-190,-732},{-180,-732},{-180,-1318},{236,-1318},{236,
            -1248},{368,-1248}}, color={255,0,255}));
    connect(summerFalse.y, bathSwitch.u2) annotation (Line(points={{-192,-456},
            {-192,-1534},{210,-1534},{210,-1452},{368,-1452}}, color={255,0,
            255}));
    connect(summerFalse.y, diningSwitch.u2) annotation (Line(points={{-192,
            -456},{-194,-456},{-194,-204},{66,-204},{66,-192},{174,-192},{174,
            -142},{310,-142},{310,-126},{362,-126}}, color={255,0,255}));
    connect(summerFalse.y, kitchenSwitch.u2) annotation (Line(points={{-192,
            -456},{-190,-456},{-190,-22},{138,-22},{138,24},{288,24},{288,48},
            {322,48},{322,58},{354,58}}, color={255,0,255}));
    connect(bathroom_mflow.y, bathSwitch.u1) annotation (Line(points={{329,
            -1426},{344,-1426},{344,-1444},{368,-1444}}, color={0,0,127}));
    connect(bathSwitch.y, bathroom_pump.m_flow_in) annotation (Line(points={{
            392,-1452},{516,-1452},{516,-1470}}, color={0,0,127}));
    connect(bathSwitch.y, bathroom_MCdeltaT.u2) annotation (Line(points={{392,
            -1452},{392,-1368},{304,-1368},{304,-1350},{282,-1350}}, color={0,
            0,127}));
    connect(const6.y, bathSwitch.u3) annotation (Line(points={{319,-1516},{
            368,-1516},{368,-1460}}, color={0,0,127}));
    connect(pAtm9.ports[1],duc9. port_b)
      annotation (Line(points={{42,-1702},{72,-1702}},
                                                     color={0,127,255}));
    connect(duc9.port_a, toilet.ports[1]) annotation (Line(points={{92,-1702},
            {117,-1702},{117,-1683.1}}, color={0,127,255}));
    connect(freshAir9.ports[1], toilet.ports[2]) annotation (Line(points={{80,
            -1732},{119,-1732},{119,-1683.1}}, color={0,127,255}));
    connect(building.weaBus,freshAir9. weaBus) annotation (Line(
        points={{-276,-632},{-84,-632},{-84,-1498},{4,-1498},{4,-1731.8},{60,
            -1731.8}},
        color={255,204,51},
        thickness=0.5));
    connect(qIntGai9.y, toilet.qGai_flow)
      annotation (Line(points={{69,-1654},{96,-1654}}, color={0,0,127}));
    connect(toilet_occ.y, toilet_is_Occ.u) annotation (Line(points={{169.3,
            -1627},{185.4,-1627}}, color={0,0,127}));
    connect(toilet_in.ports[1], toilet_pump.port_a) annotation (Line(points={
            {500,-1730},{524,-1730},{524,-1718},{542,-1718}}, color={0,127,
            255}));
    connect(toilet_is_Occ.y, toilet_Tset.u) annotation (Line(points={{216.6,
            -1627},{216.6,-1628},{226,-1628}}, color={255,0,255}));
    connect(toilet.TAir, toilet_conP.u_m) annotation (Line(points={{139,-1646},
            {232,-1646},{232,-1682},{286,-1682},{286,-1676.4}}, color={0,0,
            127}));
    connect(toilet_Tset.y, toilet_conP.u_s) annotation (Line(points={{250,
            -1628},{266,-1628},{266,-1662},{271.6,-1662}}, color={0,0,127}));
    connect(water_out9.y,coo9. TSet) annotation (Line(points={{601,-1662},{
            601,-1684},{610,-1684},{610,-1704}},          color={0,0,127}));
    connect(CpdeltaT9.y, bathroom_MCdeltaT1.u1) annotation (Line(points={{365,
            -1572},{365,-1574},{318,-1574}}, color={0,0,127}));
    connect(bathroom_MCdeltaT1.y, bathroom_Qrad1.Q_flow)
      annotation (Line(points={{295,-1580},{242,-1580}}, color={0,0,127}));
    connect(bathroom_Qrad1.port, toilet.heaPorAir) annotation (Line(points={{
            222,-1580},{118,-1580},{118,-1664}}, color={191,0,0}));
    connect(toilet_pump.port_b, coo9.port_a) annotation (Line(points={{562,
            -1718},{562,-1712},{612,-1712}}, color={0,127,255}));
    connect(coo9.port_b, toilet_out.ports[1]) annotation (Line(points={{632,
            -1712},{636,-1712},{636,-1718},{684,-1718}}, color={0,127,255}));
    connect(toilet_conP.y, abs10.u)
      annotation (Line(points={{300.4,-1662},{306,-1662}}, color={0,0,127}));
    connect(toilet_mflow.u, abs10.y)
      annotation (Line(points={{342,-1662},{330,-1662}}, color={0,0,127}));
    connect(summerFalse.y, bathSwitch1.u2) annotation (Line(points={{-192,
            -456},{-192,-1770},{246,-1770},{246,-1688},{404,-1688}}, color={
            255,0,255}));
    connect(toilet_mflow.y, bathSwitch1.u1) annotation (Line(points={{365,
            -1662},{380,-1662},{380,-1680},{404,-1680}}, color={0,0,127}));
    connect(bathSwitch1.y, toilet_pump.m_flow_in) annotation (Line(points={{
            428,-1688},{552,-1688},{552,-1706}}, color={0,0,127}));
    connect(bathSwitch1.y, bathroom_MCdeltaT1.u2) annotation (Line(points={{
            428,-1688},{428,-1604},{340,-1604},{340,-1586},{318,-1586}},
          color={0,0,127}));
    connect(const9.y, bathSwitch1.u3) annotation (Line(points={{355,-1752},{
            404,-1752},{404,-1696}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-340,
              -1800},{680,200}})),                                 Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-340,-1800},{
              680,200}})),
      experiment(StopTime=31536000, __Dymola_Algorithm="Dassl"));
  end Interim_heating;

  model rad_test
    package Medium=Buildings.Media.Air
      "Medium model";
      parameter Real air_density(unit="kg/m3")=1.2 "average air density in kg/m3";

      parameter Real kitchen_volume(unit="m3")=29.61 "volume of kitchen";
      parameter Real kitchen_area(unit="m2")=11.387 "area of kitchen";
      parameter Real kitchen_infil(unit="kg/s")=0.007155*air_density "kitchen infiltration in kg/s";

      parameter Real dining_volume(unit="m3")=40.01 "volume of dining room";
      parameter Real dining_infil(unit="kg/s")=0.00967*air_density "dining infiltration in kg/s";
      parameter Real dining_area(unit="m2")=15.3901 "area of dining room";

      parameter Real sitting_volume(unit="m3")=40.01 "volume of sitting room";
      parameter Real sitting_infil(unit="kg/s")=0.00967*air_density "sitting infiltration in kg/s";
      parameter Real sitting_area(unit="m2")=15.3901 "area of sitting room";

      parameter Real study_volume(unit="m3")=21.94 "volume of study room";
      parameter Real study_infil(unit="kg/s")=0.005301*air_density "study infiltration in kg/s";
      parameter Real study_area(unit="m2")=8.4371 "area of study";

      parameter Real BR1_volume(unit="m3")=32.42 "volume of BR1";
      parameter Real BR1_infil(unit="kg/s")=0.007834*air_density "BR1 infiltration in kg/s";
      parameter Real BR1_area(unit="m2")=13.1515 "area of BR1";

      parameter Real BR2_volume(unit="m3")=32.42 "volume of BR2";
      parameter Real BR2_infil(unit="kg/s")=0.007834*air_density "BR2 infiltration in kg/s";
      parameter Real BR2_area(unit="m2")=13.1515 "area of BR2";

      parameter Real BR3_volume(unit="m3")=18.34 "volume of BR3";
      parameter Real BR3_infil(unit="kg/s")=0.004431*air_density "BR3 infiltration in kg/s";
      parameter Real BR3_area(unit="m2")=7.4382 "area of BR3";

      parameter Real BR4_volume(unit="m3")=21.7 "volume of BR4";
      parameter Real BR4_infil(unit="kg/s")=0.005244*air_density "BR4 infiltration in kg/s";
      parameter Real BR4_area(unit="m2")=8.8028 "area of BR4";

      parameter Real bathroom_volume(unit="m3")=10.53 "volume of bathroom";
      parameter Real bathroom_infil(unit="kg/s")=0.002545*air_density "bathroom infiltration in kg/s";
      parameter Real bathroom_area(unit="m2")=4.272 "area of bathroom";

      parameter Real toilet_volume(unit="m3")=7.36 "volume of toilet";
      parameter Real toilet_infil(unit="kg/s")=0.001778*air_density "toilet infiltration in kg/s";
      parameter Real toilet_area(unit="m2")=2.9851 "area of toilet";

      parameter Real water_out_temp=273.15+50 "rad outlet water temp";
    inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
      idfName=Modelica.Utilities.Files.loadResource(
          "modelica://CCC_test/Resources/Data/energyPlusFiles/X1-2021-V8_v2_correctedInternalGain.idf"),
      epwName=Modelica.Utilities.Files.loadResource(
          "modelica://CCC_test/Resources/weatherdata/US_Berkeley_20210913.epw"),
      weaName=Modelica.Utilities.Files.loadResource(
          "modelica://CCC_test/Resources/weatherdata/US_Berkeley_20210913.mos"))
      annotation (Placement(transformation(extent={{-84,-102},{-64,-82}})));

    Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone Study(
      redeclare package Medium = Medium,
      zoneName="FlexLab-X3-ZoneA-South-Zone Thermal Zone",
      nPorts=2) "Thermal zone"
      annotation (Placement(transformation(extent={{50,-34},{90,6}})));
    Buildings.Fluid.FixedResistances.PressureDrop duc3(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      linearized=true,
      from_dp=true,
      dp_nominal=100,
      m_flow_nominal=study_infil)
      "Duct resistance (to decouple room and outside pressure)"
      annotation (Placement(transformation(extent={{48,-68},{28,-48}})));
    Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir3(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=study_infil)       "Boundary condition"
      annotation (Placement(transformation(extent={{16,-98},{36,-78}})));
    Buildings.Fluid.Sources.Boundary_pT pAtm3(redeclare package Medium = Medium,
        nPorts=1) "Boundary condition"
      annotation (Placement(transformation(extent={{-22,-68},{-2,-48}})));
    Modelica.Blocks.Sources.Constant qIntGai3(each k=0)
      "Internal heat gains, set to zero because these are modeled in EnergyPlus"
      annotation (Placement(transformation(extent={{-30,-14},{-10,6}})));
    Buildings.Fluid.Sources.Boundary_pT study_in(
      redeclare package Medium = Buildings.Media.Water,
      T=333.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{268,-70},{288,-50}})));
    Buildings.Fluid.Sources.Boundary_pT study_out(
      redeclare package Medium = Buildings.Media.Water,
      T=323.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{494,-60},{474,-40}})));
    Buildings.Fluid.Movers.Preconfigured.FlowControlled_m_flow study_pump(
      redeclare package Medium = Buildings.Media.Water,
      addPowerToMedium=false,
      m_flow_nominal=0.850/(4.184*10))
      annotation (Placement(transformation(extent={{330,-60},{350,-40}})));
    Buildings.Controls.OBC.CDL.Reals.PID study_conP(
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
      k=0.5,
      Ti=100,
      yMax=1,
      yMin=0)
      annotation (Placement(transformation(extent={{168,-28},{192,-4}})));
    Modelica.Blocks.Math.Gain study_mflow(k=0.850/(4.184*10))
      annotation (Placement(transformation(extent={{250,-28},{270,-8}})));
    Buildings.Controls.OBC.CDL.Reals.Abs abs4
      annotation (Placement(transformation(extent={{202,-28},{222,-8}})));
    Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
          transformation(extent={{-58,-182},{-18,-142}}),
          iconTransformation(extent={{-158,-266},{-138,-246}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature zone_rad_temp
      annotation (Placement(transformation(extent={{244,10},{264,30}})));
    Modelica.Blocks.Sources.Constant area(k=-1*study_area)
      annotation (Placement(transformation(extent={{336,86},{316,106}})));
    Buildings.Controls.OBC.CDL.Reals.Divide div_rad
      annotation (Placement(transformation(extent={{290,108},{270,128}})));
    Modelica.Blocks.Sources.Constant T_set(k=273.15 + 20)
      annotation (Placement(transformation(extent={{120,-18},{140,2}})));
    Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
      redeclare package Medium = Buildings.Media.Water,
      Q_flow_nominal=850,
      T_a_nominal=333.15,
      T_b_nominal=323.15)
      annotation (Placement(transformation(extent={{410,-56},{430,-36}})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
      annotation (Placement(transformation(extent={{334,26},{354,6}})));
  equation
    connect(pAtm3.ports[1],duc3. port_b)
      annotation (Line(points={{-2,-58},{28,-58}},   color={0,127,255}));
    connect(duc3.port_a,Study. ports[1]) annotation (Line(points={{48,-58},{
            69,-58},{69,-33.1}},
                          color={0,127,255}));
    connect(freshAir3.ports[1],Study. ports[2]) annotation (Line(points={{36,-88},
            {71,-88},{71,-33.1}},   color={0,127,255}));
    connect(building.weaBus,freshAir3. weaBus) annotation (Line(
        points={{-64,-92},{10,-92},{10,-87.8},{16,-87.8}},
        color={255,204,51},
        thickness=0.5));
    connect(study_in.ports[1],study_pump. port_a) annotation (Line(points={{288,-60},
            {288,-50},{330,-50}},              color={0,127,255}));
    connect(Study.TAir,study_conP. u_m) annotation (Line(points={{91,4},{102,
            4},{102,-36},{180,-36},{180,-30.4}}, color={0,0,127}));
    connect(study_conP.y,abs4. u)
      annotation (Line(points={{194.4,-16},{194.4,-18},{200,-18}},
                                                         color={0,0,127}));
    connect(study_mflow.u,abs4. y) annotation (Line(points={{248,-18},{224,
            -18}},             color={0,0,127}));
    connect(building.weaBus,weaBus)  annotation (Line(
        points={{-64,-92},{-38,-92},{-38,-162}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(Study.TRad, zone_rad_temp.T) annotation (Line(points={{91,0},{114,
            0},{114,20},{242,20}},              color={0,0,127}));
    connect(area.y, div_rad.u2) annotation (Line(points={{315,96},{298,96},{
            298,112},{292,112}}, color={0,0,127}));
    connect(T_set.y, study_conP.u_s) annotation (Line(points={{141,-8},{156,
            -8},{156,-16},{165.6,-16}}, color={0,0,127}));
    connect(study_mflow.y, study_pump.m_flow_in) annotation (Line(points={{
            271,-18},{340,-18},{340,-38}}, color={0,0,127}));
    connect(study_pump.port_b, rad.port_a) annotation (Line(points={{350,-50},
            {404,-50},{404,-46},{410,-46}}, color={0,127,255}));
    connect(rad.port_b, study_out.ports[1]) annotation (Line(points={{430,-46},
            {430,-50},{474,-50}}, color={0,127,255}));
    connect(rad.heatPortCon, Study.heaPorAir) annotation (Line(points={{418,
            -38.8},{418,-30},{276,-30},{276,-40},{82,-40},{82,-14},{70,-14}},
          color={191,0,0}));
    connect(zone_rad_temp.port, heatFlowSensor.port_a) annotation (Line(
          points={{264,20},{328,20},{328,16},{334,16}}, color={191,0,0}));
    connect(heatFlowSensor.port_b, rad.heatPortRad) annotation (Line(points={
            {354,16},{422,16},{422,-38.8}}, color={191,0,0}));
    connect(heatFlowSensor.Q_flow, div_rad.u1) annotation (Line(points={{344,
            27},{344,124},{292,124}}, color={0,0,127}));
    connect(qIntGai3.y, Study.qGai_flow[3]) annotation (Line(points={{-9,-4},
            {20,-4},{20,-3.33333},{48,-3.33333}}, color={0,0,127}));
    connect(qIntGai3.y, Study.qGai_flow[2])
      annotation (Line(points={{-9,-4},{48,-4}}, color={0,0,127}));
    connect(div_rad.y, Study.qGai_flow[1]) annotation (Line(points={{268,118},
            {42,118},{42,-4.66667},{48,-4.66667}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -180},{500,140}})),                                  Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-180},{
              500,140}})),
      experiment(StopTime=172800, __Dymola_Algorithm="Dassl"));
  end rad_test;

  model RadiatorEN442_2_edited "Dynamic radiator for space heating"
     extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
     show_T=true,
     m_flow_nominal=abs(Q_flow_nominal/cp_nominal/(T_a_nominal-T_b_nominal)));
     extends Buildings.Fluid.Interfaces.LumpedVolumeDeclarations(
       final X_start = Medium.X_default,
       final C_start = fill(0, Medium.nC),
       final C_nominal = fill(1E-2, Medium.nC),
       final mSenFac = 1 + 500*mDry/(VWat*cp_nominal*Medium.density(
          Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))),
       final massDynamics=energyDynamics);

    constant Boolean homotopyInitialization = true "= true, use homotopy method"
      annotation(HideResult=true);

    parameter Integer nEle(min=1) = 5
      "Number of elements used in the discretization";
    parameter Real fraRad(min=0, max=1) = 0.35 "Fraction radiant heat transfer";
    // Assumptions

    parameter Modelica.Units.SI.Power Q_flow_nominal
      "Nominal heating power (positive for heating)"
      annotation (Dialog(group="Nominal condition"));
    parameter Modelica.Units.SI.Temperature T_a_nominal
      "Water inlet temperature at nominal condition"
      annotation (Dialog(group="Nominal condition"));
    parameter Modelica.Units.SI.Temperature T_b_nominal
      "Water outlet temperature at nominal condition"
      annotation (Dialog(group="Nominal condition"));
    parameter Modelica.Units.SI.Temperature TAir_nominal=293.15
      "Air temperature at nominal condition"
      annotation (Dialog(group="Nominal condition"));
    parameter Modelica.Units.SI.Temperature TRad_nominal=TAir_nominal
      "Radiative temperature at nominal condition"
      annotation (Dialog(group="Nominal condition"));

    parameter Real n = 1.24 "Exponent for heat transfer";
    parameter Modelica.Units.SI.Volume VWat=5.8E-6*abs(Q_flow_nominal)
      "Water volume of radiator" annotation (Dialog(tab="Dynamics", enable=not (
            energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)));
    parameter Modelica.Units.SI.Mass mDry=0.0263*abs(Q_flow_nominal)
      "Dry mass of radiator that will be lumped to water heat capacity"
      annotation (Dialog(tab="Dynamics", enable=not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)));
    parameter Real deltaM(min=0.01) = 0.3
      "Fraction of nominal mass flow rate where transition to turbulent occurs"
         annotation(Evaluate=true,
                    Dialog(group = "Transition to laminar",
                           enable = not linearized));

    parameter Boolean from_dp = false
      "= true, use m_flow = f(dp) else dp = f(m_flow)"
      annotation (Evaluate=true, Dialog(tab="Advanced"));

    parameter Modelica.Units.SI.PressureDifference dp_nominal(displayUnit="Pa")=
         0 "Pressure drop at nominal mass flow rate"
      annotation (Dialog(group="Nominal condition"));
    parameter Boolean linearized = false
      "= true, use linear relation between m_flow and dp for any flow rate"
      annotation(Evaluate=true, Dialog(tab="Advanced"));

    // Heat flow rates
    Modelica.Units.SI.HeatFlowRate QCon_flow=heatPortCon.Q_flow
      "Heat input into the water due to convective heat transfer with room air";
    Modelica.Units.SI.HeatFlowRate QRad_flow=heatPortRad.Q_flow
      "Heat input into the water due to radiative heat transfer with room";
    Modelica.Units.SI.HeatFlowRate Q_flow=QCon_flow + QRad_flow
      "Heat input into the water";

    // Heat ports
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCon
      "Heat port for convective heat transfer with room air temperature"
      annotation (Placement(transformation(extent={{-30,62},{-10,82}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortRad
      "Heat port for radiative heat transfer with room radiation temperature"
      annotation (Placement(transformation(extent={{10,62},{30,82}})));

    Buildings.Fluid.MixingVolumes.MixingVolume[nEle] vol(
      redeclare each package Medium = Medium,
      each nPorts=2,
      each V=VWat/nEle,
      each final m_flow_nominal = m_flow_nominal,
      each final energyDynamics=energyDynamics,
      each final massDynamics=energyDynamics,
      each final p_start=p_start,
      each final T_start=T_start,
      each final X_start=X_start,
      each final C_start=C_start,
      each final mSenFac=mSenFac) "Volume for fluid stream"
      annotation (Placement(transformation(extent={{-9,0},{11,-20}})));
    Modelica.Blocks.Interfaces.RealOutput rad_out annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={56,72}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={56,72})));
    Modelica.Blocks.Interfaces.RealOutput con_out annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-54,72}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-54,72})));
  protected
    parameter Modelica.Units.SI.SpecificHeatCapacity cp_nominal=
        Medium.specificHeatCapacityCp(Medium.setState_pTX(
        Medium.p_default,
        T_a_nominal,
        Medium.X_default)) "Specific heat capacity at nominal conditions";
    parameter Modelica.Units.SI.HeatFlowRate QEle_flow_nominal[nEle](each fixed=
          false, each start=Q_flow_nominal/nEle)
      "Nominal heating power of each element";
    parameter Modelica.Units.SI.Temperature TWat_nominal[nEle](each fixed=false,
        start={T_a_nominal - i/nEle*(T_a_nominal - T_b_nominal) for i in 1:nEle})
      "Water temperature in each element at nominal conditions";
    parameter Modelica.Units.SI.TemperatureDifference[nEle] dTRad_nominal(each
        fixed=false, start={T_a_nominal - i/nEle*(T_a_nominal - T_b_nominal) -
          TRad_nominal for i in 1:nEle})
      "Temperature difference for radiative heat transfer at nominal conditions";
    parameter Modelica.Units.SI.TemperatureDifference[nEle] dTCon_nominal(each
        fixed=false, start={T_a_nominal - i/nEle*(T_a_nominal - T_b_nominal) -
          TAir_nominal for i in 1:nEle})
      "Temperature difference for convective heat transfer at nominal conditions";

    parameter Modelica.Units.SI.ThermalConductance UAEle(
      fixed=false,
      min=0,
      start=Q_flow_nominal/((T_a_nominal + T_b_nominal)/2 - ((1 - fraRad)*
          TAir_nominal + fraRad*TRad_nominal))/nEle)
      "UA value at nominal condition for each element";

     final parameter Real k = if T_b_nominal > TAir_nominal then 1 else -1
      "Parameter that is used to compute QEle_flow_nominal for heating or cooling mode";

     Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[nEle] preCon(
      each final alpha=0)
      "Heat input into radiator from convective heat transfer"
       annotation (Placement(transformation(extent={{-48,-48},{-28,-28}})));
     Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[nEle] preRad(
      each final alpha=0)
      "Heat input into radiator from radiative heat transfer"
       annotation (Placement(transformation(extent={{-48,-80},{-28,-60}})));

    Modelica.Units.SI.TemperatureDifference dTCon[nEle]={heatPortCon.T - vol[i].T
        for i in 1:nEle} "Temperature difference for convective heat transfer";
    Modelica.Units.SI.TemperatureDifference dTRad[nEle]={heatPortRad.T - vol[i].T
        for i in 1:nEle} "Temperature difference for radiative heat transfer";

    Modelica.Blocks.Sources.RealExpression QCon[nEle](y={if homotopyInitialization
           then homotopy(actual=(1 - fraRad) * UAEle * (heatPortCon.T - vol[i].T) *
          Buildings.Utilities.Math.Functions.regNonZeroPower(
          x=(heatPortCon.T - vol[i].T),
          n=n - 1,
          delta=0.05), simplified=(1 - fraRad) * UAEle .* abs(dTCon_nominal[i]) ^ (
          n - 1) * (heatPortCon.T - vol[i].T)) else (1 - fraRad) * UAEle * (heatPortCon.T - vol[i].T) *
          Buildings.Utilities.Math.Functions.regNonZeroPower(
          x=(heatPortCon.T - vol[i].T),
          n=n - 1,
          delta=0.05) for i in 1:nEle}) "Convective heat flow rate"
      annotation (Placement(transformation(extent={{-100,-48},{-80,-28}})));

    Modelica.Blocks.Sources.RealExpression QRad[nEle](y={if homotopyInitialization
           then homotopy(actual=fraRad * UAEle * (heatPortRad.T - vol[i].T) *
          Buildings.Utilities.Math.Functions.regNonZeroPower(
          x=(heatPortRad.T - vol[i].T),
          n=n - 1,
          delta=0.05), simplified=fraRad * UAEle * abs(dTRad_nominal[i]) ^ (n - 1)
           * (heatPortRad.T - vol[i].T)) else fraRad * UAEle * (heatPortRad.T - vol[i].T) *
          Buildings.Utilities.Math.Functions.regNonZeroPower(
          x=(heatPortRad.T - vol[i].T),
          n=n - 1,
          delta=0.05) for i in 1:nEle}) "Radiative heat flow rate"
      annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));

    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preSumCon(
      final alpha=0)
      "Heat input into radiator from convective heat transfer"
      annotation (Placement(transformation(extent={{52,-60},{72,-40}})));
    Modelica.Blocks.Math.Sum sumCon(nin=nEle, k=-ones(nEle))
      "Sum of convective heat flow rate"
      annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
    Modelica.Blocks.Math.Sum sumRad(nin=nEle, k=-ones(nEle))
      "Sum of radiative heat flow rate"
      annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preSumRad(
      final alpha=0)
      "Heat input into radiator from radiative heat transfer"
      annotation (Placement(transformation(extent={{52,-90},{72,-70}})));

    Buildings.Fluid.FixedResistances.PressureDrop res(
      redeclare final package Medium = Medium,
      final allowFlowReversal=allowFlowReversal,
      final m_flow_nominal=m_flow_nominal,
      final from_dp=from_dp,
      final dp_nominal=dp_nominal,
      final homotopyInitialization=homotopyInitialization,
      final linearized=linearized,
      final deltaM=deltaM,
      final show_T=false) "Pressure drop component"
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  initial equation
    if T_b_nominal > TAir_nominal then
       assert(T_a_nominal > T_b_nominal,
         "In RadiatorEN442_2, T_a_nominal must be higher than T_b_nominal.");
       assert(Q_flow_nominal > 0,
         "In RadiatorEN442_2, nominal power must be bigger than zero if T_b_nominal > TAir_nominal.");
    else
       assert(T_a_nominal < T_b_nominal,
         "In RadiatorEN442_2, T_a_nominal must be lower than T_b_nominal.");
       assert(Q_flow_nominal < 0,
         "In RadiatorEN442_2, nominal power must be smaller than zero if T_b_nominal < TAir_nominal.");
    end if;
    TWat_nominal[1] = T_a_nominal - QEle_flow_nominal[1]/m_flow_nominal/
    Medium.specificHeatCapacityCp(
          Medium.setState_pTX(Medium.p_default, T_a_nominal, Medium.X_default));
    for i in 2:nEle loop
      TWat_nominal[i] = TWat_nominal[i-1] - QEle_flow_nominal[i]/m_flow_nominal/
      Medium.specificHeatCapacityCp(
          Medium.setState_pTX(Medium.p_default, TWat_nominal[i-1], Medium.X_default));
    end for;
    dTRad_nominal = TWat_nominal .- TRad_nominal;
    dTCon_nominal = TWat_nominal .- TAir_nominal;
    Q_flow_nominal = sum(QEle_flow_nominal);

    for i in 1:nEle loop
      // Use difference, TWat_nominal[i] - TRad/Air_nominal, to avoid larger system of equations
      QEle_flow_nominal[i] = k * UAEle * (fraRad *
        Buildings.Utilities.Math.Functions.powerLinearized(
          x=k*TWat_nominal[i] - TRad_nominal,
          n=n,
          x0=0.1*k*(T_b_nominal-TRad_nominal)) + (1-fraRad) *
        Buildings.Utilities.Math.Functions.powerLinearized(
          x=k*TWat_nominal[i] - TAir_nominal,
          n=n,
          x0=0.1*k*(T_b_nominal-TAir_nominal)));
     end for;

    assert(homotopyInitialization, "In " + getInstanceName() +
      ": The constant homotopyInitialization has been modified from its default value. This constant will be removed in future releases.",
      level = AssertionLevel.warning);

  equation
    connect(preCon.port, vol.heatPort)       annotation (Line(
        points={{-28,-38},{-20,-38},{-20,-10},{-9,-10}},
        color={191,0,0}));
    connect(preRad.port, vol.heatPort)       annotation (Line(
        points={{-28,-70},{-20,-70},{-20,-10},{-9,-10}},
        color={191,0,0}));
    connect(vol[nEle].ports[2], port_b) annotation (Line(
        points={{2,5.55112e-16},{27.25,5.55112e-16},{27.25,1.11022e-15},{51.5,
            1.11022e-15},{51.5,5.55112e-16},{100,5.55112e-16}},
        color={0,127,255}));
    for i in 1:nEle-1 loop
      connect(vol[i].ports[2], vol[i+1].ports[1]) annotation (Line(
          points={{2,5.55112e-16},{2,5.55112e-16},{2,1.11022e-15},{1,1.11022e-15},
              {1,5.55112e-16},{0,5.55112e-16}},
          color={0,127,255}));
    end for;
    connect(QCon.y, preCon.Q_flow)                  annotation (Line(
        points={{-79,-38},{-48,-38}},
        color={0,0,127}));
    connect(sumCon.u, QCon.y)          annotation (Line(
        points={{18,-50},{-60,-50},{-60,-38},{-79,-38}},
        color={0,0,127}));
    connect(sumCon.y, preSumCon.Q_flow)     annotation (Line(
        points={{41,-50},{52,-50}},
        color={0,0,127}));
    connect(preSumCon.port, heatPortCon)       annotation (Line(
        points={{72,-50},{80,-50},{80,40},{-20,40},{-20,72}},
        color={191,0,0}));
    connect(QRad.y, preRad.Q_flow)       annotation (Line(
        points={{-79,-70},{-48,-70}},
        color={0,0,127}));
    connect(QRad.y, sumRad.u) annotation (Line(
        points={{-79,-70},{-60,-70},{-60,-80},{18,-80}},
        color={0,0,127}));
    connect(sumRad.y, preSumRad.Q_flow)        annotation (Line(
        points={{41,-80},{52,-80}},
        color={0,0,127}));
    connect(preSumRad.port, heatPortRad)        annotation (Line(
        points={{72,-80},{86,-80},{86,50},{20,50},{20,72}},
        color={191,0,0}));
    connect(res.port_a, port_a) annotation (Line(points={{-60,0},{-80,0},{-100,0}},
                      color={0,127,255}));
    connect(res.port_b, vol[1].ports[1])
      annotation (Line(points={{-40,0},{0,0}},       color={0,127,255}));
    connect(sumCon.y, con_out) annotation (Line(points={{41,-50},{46,-50},{46,
            72},{-54,72}}, color={0,0,127}));
    connect(sumRad.y, rad_out) annotation (Line(points={{41,-80},{46,-80},{46,
            -102},{56,-102},{56,72}}, color={0,0,127}));
    annotation ( Icon(graphics={
          Ellipse(
            extent={{-20,22},{20,-20}},
            fillColor={127,0,0},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Rectangle(
            extent={{-95,6},{106,-4}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-102,-4},{-2,6}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-20,22},{20,-20}},
            fillColor={127,0,0},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Rectangle(
            extent={{-80,60},{80,-60}},
            lineColor={0,0,0},
            fillColor=DynamicSelect({95,95,95},
            max(0, min(1, -Q_flow/Q_flow_nominal))*{255,0,0}+(1-max(0, min(1, -Q_flow/Q_flow_nominal)))*{95,95,95}),
            fillPattern=FillPattern.Solid),
          Line(
            points={{-66,30},{66,30}}),
          Line(
            points={{-66,2},{66,2}}),
          Line(
            points={{-66,-30},{66,-30}}),
          Line(
            points={{-66,60},{-66,-60}}),
          Line(
            points={{66,60},{66,-60}})}),
      defaultComponentName="rad",
      Documentation(info="<html>
<p>
This is a model of a radiator that can be used as a dynamic or steady-state model.
The required parameters are data that are typically available from
manufacturers that follow the European Norm EN 442-2.
</p>
<p>
However, to allow for varying mass flow rates, the transferred heat is computed
using a discretization along the water flow path, and heat is exchanged between
each compartment and a uniform room air and radiation temperature.
This discretization is different from the computation in EN 442-2, which
may yield water outlet temperatures that are below
the room temperature at low mass flow rates.
Furthermore, rather than using only one room temperature, this model uses
a room air and room radiation temperature.
</p>
<p>
The transferred heat is modeled as follows:
Let <i>N</i> denote the number of elements used to discretize the radiator model.
For each element <i>i &isin; {1, &hellip; , N}</i>,
the convective and radiative heat transfer
<i>Q<sup>i</sup><sub>c</sub></i> and
<i>Q<sup>i</sup><sub>r</sub></i>
from the radiator to the room is
</p>
<p align=\"center\" style=\"font-style:italic;\">
  Q<sup>i</sup><sub>c</sub> = sign(T<sup>i</sup>-T<sub>a</sub>)
     (1-f<sub>r</sub>) UA &frasl; N |T<sup>i</sup>-T<sub>a</sub>|<sup>n</sup>
  <br/> <br/>
  Q<sup>i</sup><sub>r</sub> = sign(T<sup>i</sup>-T<sub>r</sub>)
     f<sub>r</sub> UA &frasl; N |T<sup>i</sup>-T<sub>r</sub>|<sup>n</sup>
</p>
<p>
where
<i>T<sup>i</sup></i> is the water temperature of the element,
<i>T<sub>a</sub></i> is the temperature of the room air,
<i>T<sub>r</sub></i> is the radiative temperature,
<i>0 &lt; f<sub>r</sub> &lt; 1</i> is the fraction of radiant to total heat transfer,
<i>UA</i> is the UA-value of the radiator,
and
<i>n</i> is an exponent for the heat transfer.
The model computes the UA-value by numerically solving the above equations
for given
nominal heating power, nominal temperatures, fraction radiant to total heat transfer
and exponent for heat transfer.
</p>
<p>
The parameter <code>energyDynamics</code> (in the Assumptions tab),
determines whether the model computes the dynamic or the steady-state response.
For the transient response, heat storage is computed using a
finite volume approach for the
water and the metal mass, which are both assumed to be at the same
temperature.
</p>
<p>
The default parameters for the heat capacities are valid for a flat plate radiator without fins,
with one plate of water carying fluid, and a height of 0.42 meters.
</p>
</html>",   revisions="<html>
<ul>
<li>
March 7, 2022, by Michael Wetter:<br/>
Set <code>final massDynamics=energyDynamics</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1542\">#1542</a>.
</li>
<li>
April 14, 2020, by Michael Wetter:<br/>
Changed <code>homotopyInitialization</code> to a constant.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1341\">IBPSA, #1341</a>.
</li>
<li>
February 21, 2020, by Michael Wetter:<br/>
Changed icon to display its operating state.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1294\">#1294</a>.
</li>
<li>
November 17, 2016, by Filip Jorissen:<br/>
Added pressure drop equations and parameters.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/586\">#586</a>.
</li>
<li>
November 3, 2016, by Michael Wetter:<br/>
Set <code>preHea(final alpha=0)</code> as this allows to simplify the
system of equations.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/570\">#570</a>.
</li>
<li>
March 17, 2016, by Michael Wetter:<br/>
Reformulated model to reduce the dimension of the nonlinear system of equations.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/435\">#435</a>.
</li>
<li>
November 19, 2015, by Michael Wetter:<br/>
Removed assignment of parameter
<code>showDesignFlowDirection</code> in <code>extends</code> statement.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/349\">#349</a>.
</li>
<li>
April 11, 2015, by Filip Jorissen:<br/>
Propagated <code>vol.massDynamics</code> to
top level parameter <code>massDynamics</code> instead of <code>energyDynamics</code>.
</li>
<li>
November 25, 2014, by Carles Ribas Tugores:<br/>
Interchange position of <code>fraRad</code> parameter and the complementary <code>(1-fraRad)</code>
in the equation used to calculate the nominal heating power of each element, <code>QEle_flow_nominal[i]</code>.
</li>
<li>
October 29, 2014, by Michael Wetter:<br/>
Made assignment of <code>mFactor</code> final, and changed computation of
density to use default medium states as are also used to compute the
specific heat capacity.
</li>
<li>
October 21, 2014, by Filip Jorissen:<br/>
Added parameter <code>mFactor</code> and removed thermal capacity
which can lead to an index reduction.
</li>
<li>
May 29, 2014, by Michael Wetter:<br/>
Removed undesirable annotation <code>Evaluate=true</code>.
</li>
<li>
October 8, 2013 by Michael Wetter:<br/>
Removed conditional statement in the declaration of the parameter
<code>mDry</code>, as this is incorrect syntax.
</li>
<li>
September 26, 2013 by Michael Wetter:<br/>
Reformulated implementation to avoid mixing textual and graphical
declarations in the <code>equation</code> section.
</li>
<li>
April 4, 2011 by Michael Wetter:<br/>
Changed the implementation to use
<a href=\"modelica://Buildings.Utilities.Math.Functions.regNonZeroPower\">
Buildings.Utilities.Math.Functions.regNonZeroPower</a>.
This allows formulating the model without any non-differentiable function
inside the equation section.
</li>
<li>
April 2, 2011 by Michael Wetter:<br/>
Added <code>homotopy</code> operator.
</li>
<li>
February 11, 2011 by Michael Wetter:<br/>
Revised the initialization to ensure that at the nominal conditions, the
amount of transferred heat is excatly the same as the specified nominal power.
In the previous implementation, the UA-value was computed using a simplified
expression for the temperature difference, leading to a slightly different amount
of heat transfer.
</li>
<li>
February 4, 2011 by Michael Wetter:<br/>
Simplified implementation.
</li>
<li>
January 30, 2009 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
      Diagram(graphics={Rectangle(extent={{-62,78},{-46,50}}, lineColor={28,108,200})}));
  end RadiatorEN442_2_edited;

  model rad_floor_test
    package Medium=Buildings.Media.Air
      "Medium model";
      parameter Real air_density(unit="kg/m3")=1.2 "average air density in kg/m3";

      parameter Real kitchen_volume(unit="m3")=29.61 "volume of kitchen";
      parameter Real kitchen_area(unit="m2")=11.387 "area of kitchen";
      parameter Real kitchen_infil(unit="kg/s")=0.007155*air_density "kitchen infiltration in kg/s";

      parameter Real dining_volume(unit="m3")=40.01 "volume of dining room";
      parameter Real dining_infil(unit="kg/s")=0.00967*air_density "dining infiltration in kg/s";
      parameter Real dining_area(unit="m2")=15.3901 "area of dining room";

      parameter Real sitting_volume(unit="m3")=40.01 "volume of sitting room";
      parameter Real sitting_infil(unit="kg/s")=0.00967*air_density "sitting infiltration in kg/s";
      parameter Real sitting_area(unit="m2")=15.3901 "area of sitting room";

      parameter Real study_volume(unit="m3")=21.94 "volume of study room";
      parameter Real study_infil(unit="kg/s")=0.005301*air_density "study infiltration in kg/s";
      parameter Real study_area(unit="m2")=8.4371 "area of study";

      parameter Real BR1_volume(unit="m3")=32.42 "volume of BR1";
      parameter Real BR1_infil(unit="kg/s")=0.007834*air_density "BR1 infiltration in kg/s";
      parameter Real BR1_area(unit="m2")=13.1515 "area of BR1";

      parameter Real BR2_volume(unit="m3")=32.42 "volume of BR2";
      parameter Real BR2_infil(unit="kg/s")=0.007834*air_density "BR2 infiltration in kg/s";
      parameter Real BR2_area(unit="m2")=13.1515 "area of BR2";

      parameter Real BR3_volume(unit="m3")=18.34 "volume of BR3";
      parameter Real BR3_infil(unit="kg/s")=0.004431*air_density "BR3 infiltration in kg/s";
      parameter Real BR3_area(unit="m2")=7.4382 "area of BR3";

      parameter Real BR4_volume(unit="m3")=21.7 "volume of BR4";
      parameter Real BR4_infil(unit="kg/s")=0.005244*air_density "BR4 infiltration in kg/s";
      parameter Real BR4_area(unit="m2")=8.8028 "area of BR4";

      parameter Real bathroom_volume(unit="m3")=10.53 "volume of bathroom";
      parameter Real bathroom_infil(unit="kg/s")=0.002545*air_density "bathroom infiltration in kg/s";
      parameter Real bathroom_area(unit="m2")=4.272 "area of bathroom";

      parameter Real toilet_volume(unit="m3")=7.36 "volume of toilet";
      parameter Real toilet_infil(unit="kg/s")=0.001778*air_density "toilet infiltration in kg/s";
      parameter Real toilet_area(unit="m2")=2.9851 "area of toilet";

      parameter Real water_out_temp=273.15+50 "rad outlet water temp";
    inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
      idfName="C:/Users/User/OneDrive/Documents/School/Thesis/Thesis_Dymola/Ireland_Detached_Original/Detached Original_V960.idf",
      epwName="C:/Users/User/OneDrive/Documents/School/Thesis/Thesis_Dymola/Weather/IRL_Dublin.039690_IWEC.epw",
      weaName="C:/Users/User/OneDrive/Documents/School/Thesis/Thesis_Dymola/Weather/IRL_Dublin.039690_IWEC.mos")
      annotation (Placement(transformation(extent={{-84,-102},{-64,-82}})));

    Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone Study(
      redeclare package Medium = Medium,
      zoneName="GroundXfloor:Study",
      nPorts=2) "Thermal zone"
      annotation (Placement(transformation(extent={{50,-34},{90,6}})));
    Buildings.Fluid.FixedResistances.PressureDrop duc3(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      linearized=true,
      from_dp=true,
      dp_nominal=100,
      m_flow_nominal=study_infil)
      "Duct resistance (to decouple room and outside pressure)"
      annotation (Placement(transformation(extent={{48,-68},{28,-48}})));
    Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir3(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=study_infil)       "Boundary condition"
      annotation (Placement(transformation(extent={{16,-98},{36,-78}})));
    Buildings.Fluid.Sources.Boundary_pT pAtm3(redeclare package Medium = Medium,
        nPorts=1) "Boundary condition"
      annotation (Placement(transformation(extent={{-22,-68},{-2,-48}})));
    Modelica.Blocks.Sources.Constant qIntGai3(each k=0)
      "Internal heat gains, set to zero because these are modeled in EnergyPlus"
      annotation (Placement(transformation(extent={{-30,-14},{-10,6}})));
    Buildings.Fluid.Sources.Boundary_pT study_in(
      redeclare package Medium = Buildings.Media.Water,
      T=333.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{268,-70},{288,-50}})));
    Buildings.Fluid.Sources.Boundary_pT study_out(
      redeclare package Medium = Buildings.Media.Water,
      T=323.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{494,-60},{474,-40}})));
    Buildings.Fluid.Movers.Preconfigured.FlowControlled_m_flow study_pump(
      redeclare package Medium = Buildings.Media.Water,
      addPowerToMedium=false,
      m_flow_nominal=0.850/(4.184*10))
      annotation (Placement(transformation(extent={{330,-60},{350,-40}})));
    Buildings.Controls.OBC.CDL.Reals.PID study_conP(
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
      k=0.5,
      Ti=100,
      yMax=1,
      yMin=0)
      annotation (Placement(transformation(extent={{168,-28},{192,-4}})));
    Modelica.Blocks.Math.Gain study_mflow(k=0.850/(4.184*10))
      annotation (Placement(transformation(extent={{250,-28},{270,-8}})));
    Buildings.Controls.OBC.CDL.Reals.Abs abs4
      annotation (Placement(transformation(extent={{202,-28},{222,-8}})));
    Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
          transformation(extent={{-58,-182},{-18,-142}}),
          iconTransformation(extent={{-158,-266},{-138,-246}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature zone_rad_temp
      annotation (Placement(transformation(extent={{244,10},{264,30}})));
    Modelica.Blocks.Sources.Constant area(k=-1*study_area)
      annotation (Placement(transformation(extent={{336,86},{316,106}})));
    Buildings.Controls.OBC.CDL.Reals.Divide div_rad
      annotation (Placement(transformation(extent={{290,108},{270,128}})));
    Modelica.Blocks.Sources.Constant T_set(k=273.15 + 20)
      annotation (Placement(transformation(extent={{120,-18},{140,2}})));
    Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
      redeclare package Medium = Buildings.Media.Water,
      Q_flow_nominal=850,
      T_a_nominal=333.15,
      T_b_nominal=323.15)
      annotation (Placement(transformation(extent={{410,-56},{430,-36}})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
      annotation (Placement(transformation(extent={{334,26},{354,6}})));
  equation
    connect(pAtm3.ports[1],duc3. port_b)
      annotation (Line(points={{-2,-58},{28,-58}},   color={0,127,255}));
    connect(duc3.port_a,Study. ports[1]) annotation (Line(points={{48,-58},{
            69,-58},{69,-33.1}},
                          color={0,127,255}));
    connect(freshAir3.ports[1],Study. ports[2]) annotation (Line(points={{36,-88},
            {71,-88},{71,-33.1}},   color={0,127,255}));
    connect(building.weaBus,freshAir3. weaBus) annotation (Line(
        points={{-64,-92},{10,-92},{10,-87.8},{16,-87.8}},
        color={255,204,51},
        thickness=0.5));
    connect(study_in.ports[1],study_pump. port_a) annotation (Line(points={{288,-60},
            {288,-50},{330,-50}},              color={0,127,255}));
    connect(Study.TAir,study_conP. u_m) annotation (Line(points={{91,4},{102,
            4},{102,-36},{180,-36},{180,-30.4}}, color={0,0,127}));
    connect(study_conP.y,abs4. u)
      annotation (Line(points={{194.4,-16},{194.4,-18},{200,-18}},
                                                         color={0,0,127}));
    connect(study_mflow.u,abs4. y) annotation (Line(points={{248,-18},{224,
            -18}},             color={0,0,127}));
    connect(building.weaBus,weaBus)  annotation (Line(
        points={{-64,-92},{-38,-92},{-38,-162}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(Study.TRad, zone_rad_temp.T) annotation (Line(points={{91,0},{114,
            0},{114,20},{242,20}},              color={0,0,127}));
    connect(area.y, div_rad.u2) annotation (Line(points={{315,96},{298,96},{
            298,112},{292,112}}, color={0,0,127}));
    connect(T_set.y, study_conP.u_s) annotation (Line(points={{141,-8},{156,
            -8},{156,-16},{165.6,-16}}, color={0,0,127}));
    connect(study_mflow.y, study_pump.m_flow_in) annotation (Line(points={{
            271,-18},{340,-18},{340,-38}}, color={0,0,127}));
    connect(study_pump.port_b, rad.port_a) annotation (Line(points={{350,-50},
            {404,-50},{404,-46},{410,-46}}, color={0,127,255}));
    connect(rad.port_b, study_out.ports[1]) annotation (Line(points={{430,-46},
            {430,-50},{474,-50}}, color={0,127,255}));
    connect(rad.heatPortCon, Study.heaPorAir) annotation (Line(points={{418,
            -38.8},{418,-30},{276,-30},{276,-40},{82,-40},{82,-14},{70,-14}},
          color={191,0,0}));
    connect(zone_rad_temp.port, heatFlowSensor.port_a) annotation (Line(
          points={{264,20},{328,20},{328,16},{334,16}}, color={191,0,0}));
    connect(heatFlowSensor.port_b, rad.heatPortRad) annotation (Line(points={
            {354,16},{422,16},{422,-38.8}}, color={191,0,0}));
    connect(heatFlowSensor.Q_flow, div_rad.u1) annotation (Line(points={{344,
            27},{344,124},{292,124}}, color={0,0,127}));
    connect(qIntGai3.y, Study.qGai_flow[3]) annotation (Line(points={{-9,-4},
            {20,-4},{20,-3.33333},{48,-3.33333}}, color={0,0,127}));
    connect(qIntGai3.y, Study.qGai_flow[2])
      annotation (Line(points={{-9,-4},{48,-4}}, color={0,0,127}));
    connect(div_rad.y, Study.qGai_flow[1]) annotation (Line(points={{268,118},
            {42,118},{42,-4.66667},{48,-4.66667}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -180},{500,140}})),                                  Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-180},{
              500,140}})),
      experiment(StopTime=172800, __Dymola_Algorithm="Dassl"));
  end rad_floor_test;
end Updated_Heating_System;
