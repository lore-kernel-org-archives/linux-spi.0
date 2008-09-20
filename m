From: "Cliff Brake" <cliff.brake-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: removal of spidev oops on pxa270
Date: Sat, 20 Sep 2008 11:06:26 -0400
Message-ID: <f96d234e0809200806p7adecdd3hfb29b4e99dc9c83a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

I've not had time to debug yet, but thought I would pass on this information:

pxa270 cpu, kernel 2.6.27-rc6.  Platform file contains:

static struct pxa2xx_spi_master pxa_ssp_master_info = {
	.num_chipselect	= 1,
};

static struct spi_board_info spi_board_info[] __initdata = {
	{
		.modalias	= "spidev",
		.max_speed_hz	= 13000000,
		.bus_num	= 1,
		.chip_select	= 0,
	},
};

.....
	pxa2xx_set_spi_info(1, &pxa_ssp_master_info);
	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));

spidev seems to work fine -- I see activity on the spi bus like I expect.

When I go to remove the spidev module I get:

Backtrace:
[<bf004000>] (spidev_remove+0x0/0x194 [spidev]) from [<c018f6ec>]
(spi_drv_remove+0x20/0x24)
 r6:c2c28000 r5:bf005b78 r4:c2ef2800
[<c018f6cc>] (spi_drv_remove+0x0/0x24) from [<c0166ccc>]
(__device_release_driver+0x78/0x98)
[<c0166c54>] (__device_release_driver+0x0/0x98) from [<c0167190>]
(driver_detach+0xb4/0xe0)
 r5:c2ef2800 r4:c2ef28ac
[<c01670dc>] (driver_detach+0x0/0xe0) from [<c0165f9c>]
(bus_remove_driver+0x90/0xb8)
 r7:00000880 r6:c02d79cc r5:bf005c40 r4:bf005b78
[<c0165f0c>] (bus_remove_driver+0x0/0xb8) from [<c016722c>]
(driver_unregister+0x48/0x4c)
 r6:00000000 r5:bf005c40 r4:bf005b78
[<c01671e4>] (driver_unregister+0x0/0x4c) from [<bf004df0>]
(spidev_exit+0x14/0x90 [spidev])
 r6:bf005d60 r5:bf005c40 r4:00000000
[<bf004ddc>] (spidev_exit+0x0/0x90 [spidev]) from [<c005ea74>]
(sys_delete_module+0x1b8/0x22c)
[<c005e8bc>] (sys_delete_module+0x0/0x22c) from [<c0024d20>]
(ret_fast_syscall+0x0/0x2c)
 r7:00000081 r6:bec10430 r5:bec10450 r4:00000000
Code: eb40ba04 e3a06000 e59f010c eb40d67d (e5856004)
---[ end trace 1f4c46b3904ee652 ]---

Instrumenting spidev_remove a bit:

static int spidev_remove(struct spi_device *spi)
{
	struct spidev_data	*spidev = spi_get_drvdata(spi);

	/* make sure ops on existing fds can abort cleanly */
        spin_lock_irq(&spidev->spi_lock);
        spidev->spi = NULL;    <<<<<< this line is crashing

spidev is NULL, thus the crash.

Have I set everything up correctly?  I plan to debug later when I have
some time, but thought I would check now in case this can be easily
fixed or if I'm doing something wrong.

Thanks,
Cliff


-- 
=======================
Cliff Brake
http://bec-systems.com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
