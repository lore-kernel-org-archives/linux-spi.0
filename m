From: Alexander Kurz <akurz-3EoFODjbY6Q@public.gmane.org>
Subject: Re: Applied "spi: imx: wait_for_completion_timeout(..) for PIO
 transfers" to the spi tree
Date: Sun, 9 Oct 2016 22:39:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1610092225030.19531@blala.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,
regarding upstream commit ff1ba3dac08e ("spi: imx: wait_for_completion_timeout(..) for 
PIO transfers")
this commit introduces some timeout calculation with struct spi_imx_data 
spi_bus_clk as denominator. Please note, this variable is assigned 
exclusively when the driver is used for imx51-ecspi. (IMX5 ecspi/IMX6/...)

All earlier variants (IMX5 cspi / IMX3* / IMX2* ...) will run into
pretty ugly kernel div by zero faults like

>[    2.620552] Division by zero in kernel.
>[    2.622489] CPU: 0 PID: 1 Comm: swapper Not tainted 4.8.0-00001-g98e97b9 #7
>[    2.625974] Hardware name: Freescale i.MX50 (Device Tree Support)
>[    2.629058] Backtrace: 
>[    2.630313] [<c010ae48>] (dump_backtrace) from [<c010aff4>] (show_stack+0x18/0x1c)
>[    2.634102]  r7:ceac9000 r6:ceac9000 r5:ce855a98 r4:ce8aa4a0
>[    2.636998] [<c010afdc>] (show_stack) from [<c02d1744>] (dump_stack+0x20/0x28)
>[    2.640619] [<c02d1724>] (dump_stack) from [<c010b994>] (__div0+0x18/0x20)
>[    2.644064] [<c010b97c>] (__div0) from [<c02d07d4>] (Ldiv0+0x8/0x14)
>[    2.647267] [<c037e950>] (spi_imx_calculate_timeout) from [<c037eb9c>] (spi_imx_transfer+0x218/0x270)
>[    2.651886] [<c037e984>] (spi_imx_transfer) from [<c037db90>] (spi_bitbang_transfer_one+0x58/0x84)

Regards, Alexander
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
