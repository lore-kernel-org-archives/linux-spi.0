From: Michal Ludvig <mludvig-FYrFmKP0dZ69koe0gwxAeg@public.gmane.org>
Subject: bitbanging driver for my gpio board
Date: Wed, 23 Sep 2009 09:52:02 +1200
Message-ID: <4AB94702.2010608@logix.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi all,

I've got a digital IO board sitting on a ISA bus in an industrial x86
computer. And I've got a simple driver with ioctl interface for toggling
the IO pins Hi and Low and it works fine.

Now I'm about to develop a bitbanging SPI driver with the help of
drivers/spi/spi_bitbang.c. Unfortunately I don't understand how to glue
it with my GPIO driver, more precisely - how to register a new SPI
driver.

The other modules in drivers/spi seem to use platform_driver_register()
or spi_register_driver() to get their blah_probe() called and then they
go from there. However, whatever I tried, my _probe() method never gets
called. The module is as simple as this (remove/exit methods omitted
from this email):

	static int inro_spi_probe(struct spi_device *dev)
	{
	    printk(KERN_INFO PFX "inro_spi_probe() called\n");
	    return -ENODEV;
	}
	static struct spi_driver inro_spi_drv = {
	    .probe   = inro_spi_probe,
	    .driver  = { .name   = "inro_spi", .owner  = THIS_MODULE, },
	};
	static int __init inro_spi_init(void)
	{
	    printk(KERN_INFO PFX "inro_spi_init() called\n");
	    return spi_register_driver(&inro_spi_drv);
	}
	module_init(inro_spi_init);

I tried spi_register_driver() as well as platform_driver_register() both
to no avail. I assume I would need some support in xxx_platform_data for
platform_driver_register() to work but since we're running an unmodified
Debian kernel on x86 I can't do that. What needs to be done for
spi_register_driver() to call my _probe() I have no idea.


So my question is how to register/init the module and make it available
to the SPI subsystem? I somehow can't figure it out :-(

Thanks for any hints!

Michal

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
