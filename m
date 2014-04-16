From: Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: spi: spi-dw: Add support DT support
Date: Wed, 16 Apr 2014 09:26:26 -0500
Message-ID: <534E9312.5030107@gmail.com>
References: <534DE55D.10002@gmail.com> <20140416034312.GA4849@sapphire.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org,
	"dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org" <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140416034312.GA4849-MwjkAAnuF3khR1HGirfZ1z4kX+cae0hd@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Baruch Siach,

On 04/15/2014 10:43 PM, Baruch Siach wrote:
> Hi Dinh Nguyen,
>
> On Tue, Apr 15, 2014 at 09:05:17PM -0500, Dinh Nguyen wrote:
>> I saw from this spi-dw thread that you have a patch to enable DT on the
>> spi-dw driver?
>>
>> http://marc.info/?l=linux-spi&m=138862906031338&w=2
>>
>> Would you care to post the DT patch? I can test the MMIO driver on the
>> SOCFPGA platform.
>
> I posted the latest version of this series to the list, archived at
> http://thread.gmane.org/gmane.linux.kernel.spi.devel/16141 . I can send them
> to you again directly if this is more convenient to you.
>
> Thanks for testing.

Thanks for sharing. I think we have a similar patch downstream and has 
been working fine up to 3.14. For 3.14, we had to add apply this in 
order for the driver to probe properly:


diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index bf98d63..29a1f4c 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -809,6 +809,7 @@ int dw_spi_add_host(struct device *dev, struct 
dw_spi *dws)
         master->cleanup = dw_spi_cleanup;
         master->setup = dw_spi_setup;
         master->transfer = dw_spi_transfer;
+       master->dev.of_node = dev->of_node;

But even this, we're triggering a WARN_ON() in drivers/base/dd.c, 
really_probe().

WARNING: CPU: 0 PID: 1 at drivers/base/dd.c:272 
driver_probe_device+0x194/0x218)
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.14.0-00586-gee68b9b-dirty #2
[<80016328>] (unwind_backtrace) from [<80012a54>] (show_stack+0x20/0x24)
[<80012a54>] (show_stack) from [<804ed934>] (dump_stack+0x78/0x94)
[<804ed934>] (dump_stack) from [<8002302c>] 
(warn_slowpath_common+0x78/0x9c)
[<8002302c>] (warn_slowpath_common) from [<8002307c>] 
(warn_slowpath_null+0x2c/)
[<8002307c>] (warn_slowpath_null) from [<80301b48>] 
(driver_probe_device+0x194/)
[<80301b48>] (driver_probe_device) from [<80301cbc>] 
(__device_attach+0x50/0x54)
[<80301cbc>] (__device_attach) from [<802ffec4>] 
(bus_for_each_drv+0x54/0x9c)
[<802ffec4>] (bus_for_each_drv) from [<80301974>] (device_attach+0x84/0x90)
[<80301974>] (device_attach) from [<80300f64>] (bus_probe_device+0x94/0xb8)
[<80300f64>] (bus_probe_device) from [<802ff14c>] (device_add+0x3f8/0x4fc)
[<802ff14c>] (device_add) from [<80342088>] (spi_add_device+0x94/0x13c)
[<80342088>] (spi_add_device) from [<80342b6c>] 
(spi_register_master+0x56c/0x6d)
[<80342b6c>] (spi_register_master) from [<80342d10>] 
(devm_spi_register_master+)
[<80342d10>] (devm_spi_register_master) from [<80346c58>] 
(dw_spi_add_host+0x21)
[<80346c58>] (dw_spi_add_host) from [<803473d8>] 
(dw_spi_mmio_probe+0x180/0x214)
[<803473d8>] (dw_spi_mmio_probe) from [<80303224>] 
(platform_drv_probe+0x28/0x5)
[<80303224>] (platform_drv_probe) from [<80301a38>] 
(driver_probe_device+0x84/0)
[<80301a38>] (driver_probe_device) from [<80301c68>] 
(__driver_attach+0x9c/0xa0)
[<80301c68>] (__driver_attach) from [<802fff70>] 
(bus_for_each_dev+0x64/0x98)
[<802fff70>] (bus_for_each_dev) from [<80301594>] (driver_attach+0x2c/0x30)
[<80301594>] (driver_attach) from [<80301174>] (bus_add_driver+0xe8/0x1e4)
[<80301174>] (bus_add_driver) from [<8030239c>] 
(driver_register+0x88/0x104)
[<8030239c>] (driver_register) from [<80303134>] 
(__platform_driver_register+0x)
[<80303134>] (__platform_driver_register) from [<806fd110>] 
(dw_spi_mmio_driver)
[<806fd110>] (dw_spi_mmio_driver_init) from [<80008900>] 
(do_one_initcall+0xfc/)
[<80008900>] (do_one_initcall) from [<806d4cac>] 
(kernel_init_freeable+0x178/0x)
[<806d4cac>] (kernel_init_freeable) from [<804e99cc>] 
(kernel_init+0x18/0xfc)
[<804e99cc>] (kernel_init) from [<8000eb58>] (ret_from_fork+0x14/0x20)
---[ end trace 5f30c55d17fdf7a0 ]---


Our DTS entry for SPI looks like this:

spi0: spi@fff00000 {
	compatible = "snps,dw-spi-mmio";
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
		reg = <0>;      /* chip select */
   		spi-max-frequency = <100000000>;
		enable-dma = <1>;
  	};
};

I think the driver is not happy with our spidev child node here, because 
if I take out the spidev node, then everything is fine. Except I don't 
have a user-space method to test the SPI.

I'm not as familiar with this subsystem, so will take more time to 
debug. Do you any anything obviously wrong?

Thanks,
Dinh
>
> baruch
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
