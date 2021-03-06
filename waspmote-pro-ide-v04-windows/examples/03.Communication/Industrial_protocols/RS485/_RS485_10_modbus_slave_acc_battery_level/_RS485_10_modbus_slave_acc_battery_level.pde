/*   
 *  ------ [RS-485_10] Modbus Slave ACC and Battery level -------- 
 *   
 *  This sketch shows the use of the Modbus communication protocol over 
 *  RS-485 standard, and the use of the main functions of the library.
 *. Modbus allows for communication between many devices connected
 *  to the same network. There are many variants of Modbus protocols, 
 *  but Waspmote implements the RTU format. Modbus RTU is the most 
 *  common implementation available for Modbus. 
 *  
 *  This example shows how to configure the Waspmote as a Modbus 
 *  slave  device. The Waspmote stores the ACC values and the battery
 *  level in  the Modbus register, and sends these values to the 
 *  Master when  a request is received. 
 *
 *  Note: See the example RS-485_11_modbus_master_acc_battery_level
 * 
 *  Copyright (C) 2014 Libelium Comunicaciones Distribuidas S.L. 
 *  http://www.libelium.com 
 *   
 *  This program is free software: you can redistribute it and/or modify 
 *  it under the terms of the GNU General Public License as published by 
 *  the Free Software Foundation, either version 2 of the License, or 
 *  (at your option) any later version. 
 *   
 *  This program is distributed in the hope that it will be useful, 
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of 
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 *  GNU General Public License for more details. 
 *   
 *  You should have received a copy of the GNU General Public License 
 *  along with this program. If not, see <http://www.gnu.org/licenses/>. 
 *   
 *  Version:          0.1 
 *  Implementation:   Ahmad Saad
 */

// Include these libraries for using the RS-485 and Modbus functions
#include <Wasp485.h>
#include <ModbusSlave485.h>

// Create new mbs instance
ModbusSlave485 mbs;

// Slave registers
enum {        
  MB_0,   // Register 0 
  MB_1,   // Register 1 
  MB_2,   // Register 2 
  MB_3,   // Register 3  
  MB_4,   // Register 4 
  MB_REGS // Dummy register. using 0 offset to keep size of array 
};

int regs[MB_REGS];

void setup(){

  // Power on the USB for viewing data in the serial monitor 
  USB.ON();  

  // Power ON the ACC  
  ACC.ON();

  // Modbus slave configuration parameters 
  // SlaveId 
  const unsigned char SLAVE = 1;
  // Baud rate
  const long BAUD = 9600;   
  // Configure msb
  mbs.configure(SLAVE, BAUD);

}

void loop()
{
  // Pass current register values to mbs
  mbs.update(regs, MB_REGS);

  // Read and store the values in the Modbus registers   
  regs[MB_0] = ACC.getX();  // X Value
  regs[MB_1] = ACC.getY();  // Y Value
  regs[MB_2] = ACC.getZ();  // Z Value
  regs[MB_3] = PWR.getBatteryLevel(); // Battery level

  delay(10);
}

