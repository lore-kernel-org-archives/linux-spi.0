From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: SPI: dw-mmio: spidev with devicetree on 3.16.
Date: Fri, 29 Aug 2014 11:27:46 -0500
Message-ID: <5400AA02.3070201@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

I'm having problems getting spidev to show up in /dev. I'm using the 
device tree on the 3.16 kernel using spi-dw-mmio.

Without the of_node addition shown below, spidev doesn't show up in 
/sys/class or in the /dev directory. Unfortunately, adding this line 
causes a slowpath_null warning. The 2nd probe of spidev causes the 
warning [line 286 of drivers/base/dd.c] because the linked list is not 
empty (it was created in the initial spidev probe).


       master->max_speed_hz = dws->max_freq;    (line 669 of spi-dw.c)
+    master->dev.of_node = dev->of_node;

The spi0.0 device shows up under 
/sys/devices/fff00000.spi/spi_master/spi0/ whether the of_node is 
defined or undefined, so I believe the issue is with spidev.

I have also tried compiling spidev as a module without the above of_node 
addition and then doing an insmod but it still doesn't show up under /dev.

I noticed that Leroy Christophe mentioned a similar warning issue with 
this line but his Warning log is significantly different and a different 
driver.

Any thoughts on how to debug this or what to look for?

Thanks,

Thor

~~~~~My device tree entry ~~~~~~~~~~~~~~~~~~~~~~~~

         spi0: spi@fff00000 {
             compatible = "snps,dw-apb-ssi";
             #address-cells = <1>;
             #size-cells = <0>;
             reg = <0xfff00000 0x1000>;
             interrupts = <0 154 4>;
             num-chipselect = <4>;
             bus-num = <0>;
             tx-dma-channel = <&pdma 16>;
             rx-dma-channel = <&pdma 17>;
             clocks = <&per_base_clk>;

             spidev@0 {
                 compatible = "spidev";
                 reg = <0>;    /* chip select */
                 spi-max-frequency = <100000000>;
                 enable-dma = <1>;
             };
         };

~~~~~~~startup log ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Booting Linux on physical CPU 0x0
Initializing cgroup subsys cpuset
Linux version 3.16.0-10474-g835c90b-dirty (tthayer@dinh-ubuntu) (gcc 
version 4.7.3 20121106 (prerelease) (crosstool-NG 
linaro-1.13.1-4.7-2012.11-20121123 - Linaro GCC 2012.11) ) #160 SMP Thu 
Aug 28 18:21:10 CDT 2014
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: Altera SOCFPGA Cyclone V SoC Development Kit
Truncating RAM at 0x00000000-0x40000000 to -0x2f800000
Memory policy: Data cache writealloc
<snip>
bus: 'spi': registered
device class 'spi_master': registering
bus: 'i2c': registered
<snip>
bus: 'spi': registered
device class 'spi_master': registering
PM: Adding info for platform:fffec600.timer
<snip>
bus: 'platform': add driver denali-nand-dt
device class 'spidev': registering
bus: 'spi': add driver spidev
bus: 'platform': add driver dw_spi_mmio
bus: 'platform': driver_probe_device: matched device fff00000.spi with 
driver dw_spi_mmio
bus: 'platform': really_probe: probing driver dw_spi_mmio with device 
fff00000.spi
device: 'spi0': device_add
PM: Adding info for No Bus:spi0
dw_spi_mmio fff00000.spi: registered master spi0
spi spi0.0: setup mode 0, 8 bits/w, 100000000 Hz max --> 0
device: 'spi0.0': device_add
bus: 'spi': add device spi0.0
PM: Adding info for spi:spi0.0
bus: 'spi': driver_probe_device: matched device spi0.0 with driver spidev
bus: 'spi': really_probe: probing driver spidev with device spi0.0
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1 at drivers/base/dd.c:286 
driver_probe_device+0x2b4/0x2f4()
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 3.16.0-10474-g835c90b-dirty #160
[<c0016364>] (unwind_backtrace) from [<c001251c>] (show_stack+0x20/0x24)
[<c001251c>] (show_stack) from [<c04eaefc>] (dump_stack+0x7c/0x98)
[<c04eaefc>] (dump_stack) from [<c0023d4c>] (warn_slowpath_common+0x78/0x9c)
[<c0023d4c>] (warn_slowpath_common) from [<c0023d9c>] 
(warn_slowpath_null+0x2c/0x34)
[<c0023d9c>] (warn_slowpath_null) from [<c0302c60>] 
(driver_probe_device+0x2b4/0x2f4)
[<c0302c60>] (driver_probe_device) from [<c0302d90>] 
(__device_attach+0x50/0x54)
[<c0302d90>] (__device_attach) from [<c0300e60>] 
(bus_for_each_drv+0x54/0x9c)
[<c0300e60>] (bus_for_each_drv) from [<c0302958>] (device_attach+0x84/0x90)
[<c0302958>] (device_attach) from [<c0301f10>] (bus_probe_device+0x94/0xb8)
[<c0301f10>] (bus_probe_device) from [<c03000c0>] (device_add+0x434/0x4fc)
[<c03000c0>] (device_add) from [<c0342dd4>] (spi_add_device+0x98/0x164)
[<c0342dd4>] (spi_add_device) from [<c03444a4>] 
(spi_register_master+0x598/0x768)
[<c03444a4>] (spi_register_master) from [<c03446b4>] 
(devm_spi_register_master+0x40/0x80)
[<c03446b4>] (devm_spi_register_master) from [<c0346214>] 
(dw_spi_add_host+0x1a8/0x258)
[<c0346214>] (dw_spi_add_host) from [<c0346920>] 
(dw_spi_mmio_probe+0x1d4/0x294)
[<c0346920>] (dw_spi_mmio_probe) from [<c0304560>] 
(platform_drv_probe+0x3c/0x6c)
[<c0304560>] (platform_drv_probe) from [<c0302a98>] 
(driver_probe_device+0xec/0x2f4)
[<c0302a98>] (driver_probe_device) from [<c0302d3c>] 
(__driver_attach+0x9c/0xa0)
[<c0302d3c>] (__driver_attach) from [<c0300f0c>] 
(bus_for_each_dev+0x64/0x98)
[<c0300f0c>] (bus_for_each_dev) from [<c0302518>] (driver_attach+0x2c/0x30)
[<c0302518>] (driver_attach) from [<c0302134>] (bus_add_driver+0xdc/0x1f4)
[<c0302134>] (bus_add_driver) from [<c03035c8>] (driver_register+0x88/0x104)
[<c03035c8>] (driver_register) from [<c030445c>] 
(__platform_driver_register+0x58/0x6c)
[<c030445c>] (__platform_driver_register) from [<c0700f00>] 
(dw_spi_mmio_driver_init+0x18/0x20)
[<c0700f00>] (dw_spi_mmio_driver_init) from [<c0008914>] 
(do_one_initcall+0x90/0x1d4)
[<c0008914>] (do_one_initcall) from [<c06d7d90>] 
(kernel_init_freeable+0x178/0x248)
[<c06d7d90>] (kernel_init_freeable) from [<c04e687c>] 
(kernel_init+0x18/0xfc)
[<c04e687c>] (kernel_init) from [<c000ecd8>] (ret_from_fork+0x14/0x20)
---[ end trace f9c390ec7153bfd3 ]---
device: 'spidev0.0': device_add
PM: Adding info for No Bus:spidev0.0
driver: 'spidev': driver_bound: bound to device 'spi0.0'
bus: 'spi': really_probe: bound device spi0.0 to driver spidev
dw_spi_mmio fff00000.spi: registered child spi0.0
driver: 'dw_spi_mmio': driver_bound: bound to device 'fff00000.spi'
bus: 'platform': really_probe: bound device fff00000.spi to driver 
dw_spi_mmio
bus: 'mdio_bus': add driver Micrel KS8737


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
