From: Orjan Friberg <of-Gxjboj7dVqxWk0Htik3J/w@public.gmane.org>
Subject: Bitbanged SPI over GPIO probe fail
Date: Mon, 9 Aug 2010 17:35:55 +0200
Message-ID: <4C60205B.9090202@flatfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi list,

I'm trying to use the bitbanged spi_gpio.c driver on a Beagleboard, 
using the inlined approach (defining gpio pin numbers and cs).

When modprobing the driver platform_driver_probe returns -ENODEV but 
spi_gpio_probe is not being called, which seems odd to me.  Any suggestions?

This is on a 2.6.32 TI PSP kernel.

There is in fact no device attached on the pins, but as the driver's 
probe function isn't called I don't think it should matter.  Also, I 
have checked that I can manually control the pins through /sys/class/gpio.

Thanks,
Orjan


-- 
Orjan Friberg
FlatFrog Laboratories AB

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
