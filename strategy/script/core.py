#!/usr/bin/env python
import rospy
import sys
import math
import time
from statemachine import StateMachine, State
from robot.robot import Robot
from std_msgs.msg import String
from my_sys import log, SysCheck, logInOne
from methods.chase import Chase
from methods.attack import Attack
from dynamic_reconfigure.server import Server
from strategy.cfg import GameStateConfig

class Core(Robot, StateMachine):
  def __init__(self, robot_num, sim = False):
    self.CC  = Chase()
    self.AC  = Attack()
    self.sim = sim
    super(Core, self).__init__(robot_num, sim)
    StateMachine.__init__(self)

  idle   = State('Idle', initial = True)
  chase  = State('Chase')
  attack = State('Attack')
  shoot  = State('Shoot')

  toChase  = idle.to(chase) | attack.to(chase) | chase.to.itself()
  toIdle   = chase.to(idle) | attack.to(idle)
  toAttack = chase.to(attack) | attack.to.itself() | shoot.to(attack)
  toShoot  = attack.to(shoot)

  def on_toChase(self, t, side):
    o = self.CC.ClassicRounding(t[side]['ang'],\
                                t['ball']['dis'],\
                                t['ball']['ang'])
    self.RobotCtrl(o['v_x'], o['v_y'], o['v_yaw'])

    if self.RobotBallHandle():
      self.toAttack(t, side)
    else:
      pass

  def on_toIdle(self):
    log("To Idle")

  def on_toAttack(self, t, side):
    o = self.AC.ClassicAttacking(t[side]['dis'], t[side]['ang'])
    self.RobotCtrl(o['v_x'], o['v_y'], o['v_yaw'])

  def on_toShoot(self, power, pos):
    if self.RobotBallHandle():
      self.RobotShoot(power, pos)
    else:
      print("NOT YET")

  def PubCurrentState(self):
    self.RobotStatePub(self.current_state.identifier)

  def CheckBallHandle(self):
    return self.RobotBallHandle()

class Strategy(object):
  def __init__(self):
    gains = rospy.get_param("/core")
    self.game_start = gains['game_start']
    self.game_state = gains['game_state']
    self.side       = gains['side']
    self.opp_side   = 'Cyan' if gains['side'] == 'Magenta' else 'Magenta'

  def Callback(self, config, level):
    self.game_start = config['game_start']
    self.game_state = config['game_state']
    self.side       = config['side']
    self.opp_side   = 'Cyan' if config['side'] == 'Magenta' else 'Magenta'
    return config

  def main(self, argv):
    rospy.init_node('core', anonymous=True)
    rate = rospy.Rate(1000)

    dsrv = Server(GameStateConfig, self.Callback)

    if SysCheck(argv) == "Native Mode":
      log("Start Native")
      robot = Core(1)
    elif SysCheck(argv) == "Simulative Mode":
      log("Start Sim")
      robot = Core(1, True)

    while not rospy.is_shutdown():

      robot.PubCurrentState()
      targets = robot.GetObjectInfo()

      if targets is not None:
        if not robot.is_idle and not self.game_start:
          robot.toIdle()
        elif robot.is_idle and self.game_start:
          robot.toChase(targets, self.side)
        elif robot.is_chase:
          robot.toChase(targets, self.side)

        if robot.is_chase and abs(targets['ball']['ang']) <= 20 \
                          and targets['ball']['dis'] <= 50:
          robot.toAttack(targets, self.side)
        elif robot.is_attack:
          robot.toAttack(targets, self.side)

        if robot.is_attack and abs(targets['ball']['ang']) > 20 \
                           and targets['ball']['dis'] > 50:
          robot.toChase(targets, self.side)

        if robot.is_attack and abs(targets[self.side]['ang']) < 10:
          robot.toShoot(3, 1)

        if robot.is_shoot:
          robot.toAttack(targets, self.side)

      if rospy.is_shutdown():
        log('shutdown')
        break

      rate.sleep()

if __name__ == '__main__':
  try:
    s = Strategy()
    s.main(sys.argv[1:])
  except rospy.ROSInterruptException:
    pass