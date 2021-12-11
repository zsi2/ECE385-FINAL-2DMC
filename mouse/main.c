#include "altera_up_avalon_usb.h"
#include "altera_up_avalon_usb_ptd.h"
#include "altera_up_avalon_usb_regs.h"
#include "altera_up_avalon_usb_low_level_driver.h"
#include "altera_up_avalon_usb_high_level_driver.h"

typedef struct alt_up_usb_mouse_packet {
    signed char x_movement;
    signed char y_movement;
    signed char buttons;
} alt_up_usb_mouse_packet;

typedef struct alt_up_usb_dev {
    alt_dev dev;
    unsigned int base;
    unsigned int irq_base;
    unsigned int irq_id;
} alt_up_usb_dev;

unsigned int alt_up_usb_setup(alt_up_usb_dev* usb_device, int* addr_ptr, int* port_ptr)
{
    unsigned int rbuf[128];
    unsigned int mycode;
    unsigned int iManufacturer, iProduct;
    unsigned int status;
    unsigned int new_port1_addr, new_port2_addr, print_port_info;
    unsigned int extra, HID;
    // 1 means port1 is connected; 2 means port2 is connected;
    *port_ptr = -1;
    HID = -1;
    while(1)
    {
        // Configure and Set up the controls of the ATL buffer
        alt_up_usb_reset(usb_device);
        alt_up_usb_hc_initialize_defaults(usb_device);
        // Change the HC to operational state and Enable the port
        alt_up_usb_hc_set_operational(usb_device);
        alt_up_usb_enable_ports(usb_device);
        // Suspend the host controller, if the system doesn’t need it
        alt_up_usb_hc_reg_write_16(usb_device, ALT_UP_USB_HcControl, 0x6c0);
        alt_up_usb_hc_reg_write_16(usb_device, ALT_UP_USB_HcuPInterrupt, 0x1a9);
        // Assign new addresses for port 1 and port 2, maximum addr number is 7
        new_port1_addr = 1;
        new_port2_addr = 2;
        print_port_info = 0;
        status = alt_up_usb_assign_address(usb_device, new_port1_addr, new_port2_addr, print_port_info);
        // Enable ALT_IRQ and HC suspended
        alt_up_usb_hc_reg_write_16(usb_device, ALT_UP_USB_HcuPInterruptEnable,0x120);
        *port_ptr = -1;
        extra = 0;
        if((status & 0x0001) != 0)
        {
            //port 2 active* port_ptr = 2;
            *addr_ptr = new_port2_addr;
        }
        else if((status & 0x0100) != 0)
        {
            //port 1 active
            *port_ptr = 1;
            *addr_ptr = new_port1_addr;
        }
        if(*port_ptr != -1)
        {
            // Check port for device
            mycode = alt_up_usb_get_control(usb_device, rbuf, *addr_ptr, 'D', extra, *port_ptr);
            if(mycode == 0x0300)
            {
                iManufacturer = rbuf[7] & 0xFF;
                iProduct = (rbuf[7]&0xFF00) >> 8;
                alt_up_usb_addr_info(*addr_ptr, 'W', 'O', iManufacturer);
                alt_up_usb_addr_info(*addr_ptr, 'W', 'P', iProduct);
                mycode = alt_up_usb_get_control(usb_device, rbuf, *addr_ptr, 'H', alt_up_usb_addr_info(*addr_ptr, 'R', 'P', 0), *port_ptr);
                HID =* (rbuf + 1);
                if (HID == 0x0209)
                { //it must be 0x0209, if connected device is a mouse
                    printf("\nMouse Detected...\n");
                }
                else if(HID == 0x0609)
                { //it must be 0x0609, if connecteddevice is a keyboard
                    printf("\nKeyboard Detected...\n");
                }
                else
                {
                    printf("\nUSB Device with HID 0x%04x Detected...\n", HID);
                }
                return HID;
            }
        }
        {
            volatile int usleep;
            for (usleep = 0; usleep < 20000; usleep++);
        }
    }
}

unsigned int alt_up_usb_play_mouse(alt_up_usb_dev* usb_device, int addr, int port)
{
    printf("ISP1362 USB Mouse Demo.....\n");
    alt_up_usb_mouse_setup(usb_device, addr, port);
    alt_up_usb_mouse_packet usb_mouse_packet;
    usb_mouse_packet.x_movement = 0;
    usb_mouse_packet.y_movement = 0;
    usb_mouse_packet.buttons = 0;
    unsigned int pX = 320, pY = 240;
    do
    {
        pX = pX + usb_mouse_packet.x_movement;
        pY = pY + usb_mouse_packet.y_movement;
        if(pX > 639)
        {
            pX = 639;
        }
        if(pX < 0)
        {
            pX = 0;
        }
        if(pY > 479)
        {
            pY = 479;
        }
        if(pY < 0)
        {
            pY = 0;
        }

        alt_up_parallel_port_dev* Green_LEDs_dev;
        alt_up_parallel_port_dev* Red_LEDs_dev;
        alt_up_parallel_port_dev* HEX3_HEX0_dev;

        Green_LEDs_dev = alt_up_parallel_port_open_dev("/dev/Green_LEDs");
        Red_LEDs_dev = alt_up_parallel_port_open_dev("/dev/Red_LEDs");
        HEX3_HEX0_dev = alt_up_parallel_port_open_dev("/dev/HEX3_HEX0");
        alt_up_parallel_port_write_data(Red_LEDs_dev, pX);
        alt_up_parallel_port_write_data(Green_LEDs_dev, pY);
        if ((usb_mouse_packet.buttons & 0x1) == 1)
        {
            //left button
            alt_up_parallel_port_write_data(HEX3_HEX0_dev, 0x3f0000);
        }
        if (((usb_mouse_packet.buttons & 0x2) >> 1) == 1)
        {
            //right button
            alt_up_parallel_port_write_data(HEX3_HEX0_dev, 0x3f);
        }
        if (((usb_mouse_packet.buttons & 0x4) >> 2) == 1)
        {
            //center button
            alt_up_parallel_port_write_data(HEX3_HEX0_dev, 0x3f00);
        }
        usb_mouse_packet.x_movement = 0;
        usb_mouse_packet.y_movement = 0;
        usb_mouse_packet.buttons = 0;
    } while (alt_up_usb_retrieve_mouse_packet(usb_device, &usb_mouse_packet) !=ALT_UP_USB_MOUSE_NOT_CONNECTED);
    printf("Mouse Not Detected\n");
    return 0;
}

int main(void)
{
    // 1.Open the USB device
    alt_up_usb_dev* usb_device;
    usb_device = alt_up_usb_open_dev("/dev/USB");
    if (usb_device != NULL)
    {
        printf("usb_device->base %08x, please check if this matches the USB’s baseaddress in Qsys\n", usb_device->base);
        unsigned int mycode;
        int port = -1;
        int addr = -1;
        int config = -1;
        int HID = -1;
        //Human Interface Device Descriptor number.
        while (1)
        {
            port = -1;
            addr = -1;
            // 2. Set up the USB and get the connected port number and its address
            HID = alt_up_usb_setup(usb_device, &addr, &port);
            if (port != -1 && HID == 0x0209)
            {
                // 3. After confirming that the device is connected is a mouse, thehost must choose a configuration on the device
                config = 1;
                mycode = alt_up_usb_set_config(usb_device, addr, port, config);
                if (mycode == 0)
                {
                    // 4. Set up and play mouse
                    alt_up_usb_play_mouse(usb_device, addr, port);
                }
            }
        }
    }
    else
    {
        printf("Error: could not open USB device\n");
    }
    return 0;
}