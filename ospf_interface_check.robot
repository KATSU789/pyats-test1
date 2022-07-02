*** Settings ***
Library        ats.robot.pyATSRobot
Library        genie.libs.robot.GenieRobot
Library        genie.libs.robot.GenieRobotApis

*** Variables ***
${testbed}     testbed.yaml
@{interfaces}  GigabitEthernet0/0/0/2
${interface}   GigabitEthernet0/0/0/2
${device1}     core-rtr01

*** Test Cases ***
デバイスへ接続する
    use testbed "${testbed}"
    connect to device "${device1}"
    

テスト前のConfig、IF状態、ログの保存  
    Profile the system for "config;interface" on devices "${device1}" as "before"
    health logging    device=${device1}  keywords=
  
事前のOSPF IF状態の保存
    ${parse}   parse "show ospf interface brief" on device "${device1}" 
    @{before}  dq query  data=${parse}   filters=contains('Gi0/0/0/2').get_values('state')    
  
IFのダウンと確認
    Configure interfaces shutdown  interfaces=@{interfaces}  device=${device1}
    ${result}   verify interface state down  interface=${interface}  device=${device1}  max_time=${6}  check_interval=${3}
    Should Not Be True  ${result}
    Log                 ${result}

OSPFのIF状態がダウンしているか確認
    ${parse}  parse "show ospf interface brief" on device "${device1}" 
    @{after}  dq query  data=${parse}   filters=contains('Gi0/0/0/2').get_values('state')
    Should Be Equal As Strings  @{after}  DOWN
    Log                         @{after}

IFをアップ状態へ戻す
    configure interfaces unshutdown  device=${device1}  interfaces=@{interfaces}
    ${result}   verify interface state up  interface=${interface}  device=${device1}  max_time=${6}  check_interval=${3}
    Should Be True  ${result}
    Log             ${result}

OSPFのIF状態がアップしているか確認
    Sleep  10
    ${parse}  parse "show ospf interface brief" on device "${device1}" 
    @{after}  dq query  data=${parse}   filters=contains('Gi0/0/0/2').get_values('state')
    Should Be Equal As Strings  @{after}  BDR
    Log                         @{after}
  
テスト後のConfig、IF状態、ログの保存  
    Profile the system for "config;interface" on devices "${device1}" as "after_conf"
    health_logging    device=${device1}  keywords=

切断
    disconnect from device "${device1}"

