within CCC_test.Examples;
model ArisMultiFamily2
    extends Modelica.Icons.Example;
    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;


  parameter Modelica.Units.SI.MassFlowRate mOccupant_flow_nominal=0.126
    "Occupant hot water usage nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mFcu_flow_nominal=0.06111
    "Fan coil units total glycol nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mTankHx_flow_nominal=0.92
    "Water tank heat exchanger glycol nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mHp_flow_nominal=mFcu_flow_nominal+mTankHx_flow_nominal
    "Heat pump glycol nominal mass flow rate";
  CCC.Fluid.HeatPumps.BaseClasses.CCC_HP_wTSup_ctr_withPowerData_3D
    cCC_HP_wTSup_ctr_withPowerData_3D(
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumPropyleneGlycol (property_T=293.15, X_a
          =0.4),
    datTabHea=CCC.Fluid.HeatPumps.Data.LG_DATA_Heating(),
    datTabCoo=CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling(),
    Q_flow_nominal=18500,
    TCon_nominal=308.15,
    TEva_nominal=280.15,
    mCon_flow_nominal=0.92,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{-82,72},{-62,88}})));
  CCC.Fluid.HeatPumps.BaseClasses.CCC_HP_wTSup_ctr_withPowerData_3D
    cCC_HP_wTSup_ctr_withPowerData_3D1(
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumPropyleneGlycol (property_T=293.15, X_a
          =0.4),
    datTabHea=CCC.Fluid.HeatPumps.Data.LG_DATA_Heating(),
    datTabCoo=CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling(),
    Q_flow_nominal=18500,
    TCon_nominal=308.15,
    TEva_nominal=280.15,
    mCon_flow_nominal=0.92,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{-30,72},{-10,88}})));
  CCC.Fluid.HeatPumps.BaseClasses.CCC_HP_wTSup_ctr_withPowerData_3D
    cCC_HP_wTSup_ctr_withPowerData_3D2(
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumPropyleneGlycol (property_T=293.15, X_a
          =0.4),
    datTabHea=CCC.Fluid.HeatPumps.Data.LG_DATA_Heating(),
    datTabCoo=CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling(),
    Q_flow_nominal=18500,
    TCon_nominal=308.15,
    TEva_nominal=280.15,
    mCon_flow_nominal=0.92,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{26,74},{46,90}})));
  Buildings.Fluid.Interfaces.ConservationEquation conservationEquation(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    T_start=303.15,
    fluidVolume=0.1,
    nPorts=2)
    annotation (Placement(transformation(extent={{-80,12},{-60,32}})));
  Buildings.Fluid.Interfaces.ConservationEquation conservationEquation1(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    T_start=303.15,
    fluidVolume=0.1,
    nPorts=2)
    annotation (Placement(transformation(extent={{-80,-24},{-60,-4}})));
  Buildings.Fluid.Interfaces.ConservationEquation conservationEquation2(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    T_start=303.15,
    fluidVolume=0.1,
    nPorts=2)
    annotation (Placement(transformation(extent={{-74,-56},{-54,-36}})));
  Buildings.Fluid.Interfaces.ConservationEquation conservationEquation3(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    T_start=303.15,
    fluidVolume=0.1,
    nPorts=2)
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=mOccupant_flow_nominal,
    VTan=0.3,
    hTan=1.2,
    dIns=0.050,
    nSeg=5,
    T_start=318.15,
    redeclare package MediumHex = MediumWater,
    hHex_a=1.199,
    hHex_b=0,
    Q_flow_nominal=18500,
    TTan_nominal=313.15,
    THex_nominal=328.15,
    mHex_flow_nominal=mTankHx_flow_nominal)
                annotation (Placement(transformation(
        extent={{10,-9},{-10,9}},
        rotation=0,
        origin={44,15})));
  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=mOccupant_flow_nominal,
    VTan=0.3,
    hTan=1.2,
    dIns=0.050,
    nSeg=5,
    T_start=318.15,
    redeclare package MediumHex = MediumWater,
    hHex_a=1.199,
    hHex_b=0,
    Q_flow_nominal=18500,
    TTan_nominal=313.15,
    THex_nominal=328.15,
    mHex_flow_nominal=mTankHx_flow_nominal)
                annotation (Placement(transformation(
        extent={{10,-9},{-10,9}},
        rotation=0,
        origin={46,-17})));
  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan2(
    redeclare package Medium = MediumWater,
    m_flow_nominal=mOccupant_flow_nominal,
    VTan=0.3,
    hTan=1.2,
    dIns=0.050,
    nSeg=5,
    T_start=318.15,
    redeclare package MediumHex = MediumWater,
    hHex_a=1.199,
    hHex_b=0,
    Q_flow_nominal=18500,
    TTan_nominal=313.15,
    THex_nominal=328.15,
    mHex_flow_nominal=mTankHx_flow_nominal)
                annotation (Placement(transformation(
        extent={{10,-9},{-10,9}},
        rotation=0,
        origin={24,-39})));
  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan3(
    redeclare package Medium = MediumWater,
    m_flow_nominal=mOccupant_flow_nominal,
    VTan=0.3,
    hTan=1.2,
    dIns=0.050,
    nSeg=5,
    T_start=318.15,
    redeclare package MediumHex = MediumWater,
    hHex_a=1.199,
    hHex_b=0,
    Q_flow_nominal=18500,
    TTan_nominal=313.15,
    THex_nominal=328.15,
    mHex_flow_nominal=mTankHx_flow_nominal)
                annotation (Placement(transformation(
        extent={{10,-9},{-10,9}},
        rotation=0,
        origin={20,-93})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val
    annotation (Placement(transformation(extent={{-18,46},{2,66}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ArisMultiFamily2;
