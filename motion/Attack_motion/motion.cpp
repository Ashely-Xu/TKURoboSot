/********************************
 *	Include system
 ********************************/
#include <iostream>
#include <cmath>
#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <signal.h>
/********************************
 *	Include libraries
 ********************************/
#include "motor_data.h"

/********************************
 *	Include header files
 ********************************/
#include "motion_nodeHandle.h"
#include "base_control.h"
//#include "CTest.h"
/********************************
 *	Define	
 ********************************/
//typedef void * (*THREADFUNCPTR)(void *);
//#define DEBUG 
bool flag = 0;
void inturrupt(int signal)
{
    printf("get SIGINT %d\n", signal);
    flag = 1;
}
int main(int argc, char **argv)
{
	Motion_nodeHandle Node(argc, argv);
//    ros::init(argc, argv, "Test");
//    ros::NodeHandle n;
	BaseControl Base;

//    pthread_t tid1, tid2;
//    int p1= pthread_create(&tid1, NULL, &Node.pThreadRun, &Node);
//    int p2= pthread_create(&tid2, NULL, &Base->run, Base);
////    int p2 = pthread_create(&tid, NULL, &nodeHandle->run, NULL);
//    if(p1 != 0){
//        printf("p1 error");
//    }
//    if(p2 != 0){
//        printf("p2 error");
//    }
//	BaseControl main_Base_Control;

	robot_command robotCMD;
    serial_rx* RX;
//	robot_command main_robotFB;
//	int count = 0;
	//while(ros::ok()){
	//	if(Global_Motor_Control.mcssl_init()){
	//		break;
	//	}else{
	//		exit(EXIT_FAILURE);
	//	}
	//}
    signal(SIGINT, inturrupt);
	std::cout << "ATTACK MOTION IS RUNNING!\n";
	ros::Rate loop_rate(100);
    int count = 0;
	while(true){
        if(flag){
            break;
        }
//		main_robotCMD = nodeHandle.getMotion();
//		main_Base_Control.send(main_robotCMD);
//		if(*main_robotCMD->shoot_power > 0){
//			count++;
//			if(count>10){
//				main_nodeHandle.clear();
//				count = 0;
//			}
//		}else{
//			main_nodeHandle.clear();
//			count = 0;
//		}
//		main_robotFB = main_Base_Control.get_feedback();
//		main_nodeHandle.pub_robotFB(main_robotFB);
        if(Node.getMotionFlag()){
            printf("\n*****get motion******\n");
            robotCMD = Node.getMotion();
            std::cout << "x: " << robotCMD.x_speed << "\t";
            std::cout << "y: " << robotCMD.y_speed << "\t";
            std::cout << "yaw: " << robotCMD.yaw_speed << "\t";
            std::cout << "\nshoot power: " << robotCMD.shoot_power << "\t";
            std::cout << "hold: " << robotCMD.hold_ball << "\t";
            std::cout << "remote: " << robotCMD.remote;
            std::cout << std::endl;
            Base.send(robotCMD);
        }
//        Base.send(robotCMD);
//        printf("main\n");
        if(Base.getBaseFlag()){
            printf("\n*****get feedback******\n");
//            printf("get rx data: ");
            RX = Base.getPack();
            printf("head1: %x\t", RX->head1);
            printf("head2: %x\t", RX->head2);
            printf("w1: %d\t", RX->w1 * 600/2000);
            printf("w2: %d\t", RX->w2);
            printf("w3: %d\t", RX->w3);
            printf("shoot: %x\t", RX->shoot);
            printf("batery: %x\n", RX->batery);
        }
//		ros::spinOnce();
//		loop_rate.sleep();
	}
//	delete main_robotCMD;
	ros::shutdown();
	std::cout << "Close Attack Motion\n";
//#ifdef DEBUG
//#else
//#endif
	return 0;
}


