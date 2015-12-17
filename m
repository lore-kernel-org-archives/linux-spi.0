From: Stanislau Arkhipenka <dise.logo-JGs/UdohzUI@public.gmane.org>
Subject: SPI-CAN mcp2515
Date: Thu, 17 Dec 2015 23:51:55 +0300
Message-ID: <1450385515.3635.1.camel@mail.ru>
Reply-To: dise.logo-JGs/UdohzUI@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Dear Colleagues, Hello.
Currently i'm working on building fully functional real size humanoid
robot.
One of major points of my work is connecting peripheral devices through
CAN bus to cubieboard.
During this activities i have read tonnes of manuals, related to Device
Tree Source, but still have alot of problems with connecting mcp2515 to
Cubieboard (v1).
Would you be so kind to help my in this field? I'm trying to configure
it more that month and have no success.

My changes in DTS file sun4i-a10-cubieboard.dts represented in following
diff:

54a55,59
> 	can0_oscillator =   <&can0_osc>,"oscillator-frequency";
> 	can0_speed =      <&can0>,"spi-max-frequency:0";
> 	can0_interrupt =
<&can0_pins>,"allwinner,pins:PB11",<&can0>,"interrupts:0";
> 
> 
77a83,90
> 
> /* ************************************************** */
> 	clocks {
> 		can0_osc: can0_osc {
> 			compatible = "fixed-clock";
> 			#clock-cells = <0>;
> 			clock-frequency  = <16000000>;
> 			};
78a92
> /* ************************************************* */
179a194,199
> /* ****************************************************** */ 
> 	can0_pins: can0_pins {
> 		allwinner,pins = "PI10", "PI11", "PI12", "PI13"; /* SPI0 */
> 		allwinner,function = "spi0"; /* input */
> 	};
> /* ****************************************************** */
220a241
> /* ***************************************** */
226c247,258
< };
---
> 	can0: mcp2515@0 {
> 		reg= <0>;
> 		compatible = "microchip,mcp2515";
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&can0_pins>;
> 		spi-max-frequency = <10000000>;
> 		interrupt-parent = <&pio>;
> 		interrupts = <25 0x2>;
> 		clocks = <&can0_osc>;
> 		};
> 	};
> /* **************************************** */

Original file can be found here
https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/sun4i-a10-cubieboard.dts

my CAN controller
http://www.amazon.com/gp/product/B0152VCIA6?psc=1&redirect=true&ref_=ox_sc_act_title_1&smid=A1792RTTLO6S27


During compile i've used following settings:
Linux Kernel Configuration
      Device Drivers
         SPI support
            Utilites for Bitbanging SPI masters
            GPIO-based bitbanging SPI Master
            Allwinner A10
            Allwinner A31
      Networking support
         CAN bus subsystem support
            CAN device drivers
                Virtual Local CAN Interface (vcan)
                Platform CAN drivers with Netlink support
                  CAN bit-timing calculation
                  #?? Enable LED triggers for Netlink based drivers
                  TI High End CAN controller (HECC)
                  Allwinner A10 CAN controller
                  CAN SPI Interface
                     Microchip MCP251x SPI CAN controller


During startup dmesg shows following:

[    5.178360] CAN device driver interface
[    5.201827] pinconfig core: failed to register map default (1): no
configs given
[    5.364882] mcp251x spi32766.0: CANCTRL 0x87
[    5.365508] mcp251x spi32766.0 can0: set_features() failed (-1);
wanted 0x0000000000004008, left 0x0000000000004808
[    7.047499] mcp251x spi32766.0: failed to acquire irq 0

#  ip -s -d link show can0
3: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group
default qlen 10
     link/can  promiscuity 0
     can <TRIPLE-SAMPLING> state STOPPED restart-ms 0
       bitrate 125000 sample-point 0.875
       tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
       mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
       clock 8000000
       re-started bus-errors arbit-lost error-warn error-pass bus-off
       0          0          0          0          0          0
     RX: bytes  packets  errors  dropped overrun mcast
     0          0        0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     0          0        0       0       0       0

Your help will be really helpful.
Thank you in advance, SA.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
