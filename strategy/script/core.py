#!/usr/bin/env python3
import rospy
import sys
from statemachine import StateMachine, State
from robot.robot import Robot
from std_msgs.msg import String
from my_sys import log, SysCheck

class SoccerMachine(StateMachine):
  wait    = State('Wait', initial=True)
  forward = State('Forward')
  back    = State('Back')

  enter = wait.to(forward)
  go_forward = back.to(forward)
  go_back    = forward.to(back)

  def on_enter(self):
    log("I'm running~")
  def on_go_forward(self):
    log("I'm running~")
  def on_go_back(self):
    log("I'm going back.")

class Core(Robot):
  sm = SoccerMachine()
  def __init__(self, robot_num, sim = False):
    self.sim = sim
    super(Core, self).__init__(robot_num, sim)
  
  def Brain(self):
    obj = self.GetObjectInfo()
    if obj['ball']['dis'] is None:
      log("NONE")
    else:
      print("Ball: {}\tCyan Goal: {}\tMagenta Goal: {}".format(obj['ball'], obj['cyan_goal'], obj['magenta_goal']))

def main(argv):
  rospy.init_node('core', anonymous=True)
  rate = rospy.Rate(50)

  if SysCheck(argv) == "Native Mode":
    log("Start Native")
    robot = Core(1)
  elif SysCheck(argv) == "Simulative Mode":
    log("Start Sim")
    robot = Core(1, True)

  while not rospy.is_shutdown():
    robot.Brain()
    rate.sleep()

if __name__ == '__main__':
  try:
    main(sys.argv[1:])
  except rospy.ROSInterruptException:
    pass