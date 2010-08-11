From: Orjan Friberg <of-Gxjboj7dVqxWk0Htik3J/w@public.gmane.org>
Subject: Re: Bitbanged SPI over GPIO probe fail
Date: Wed, 11 Aug 2010 18:44:45 +0200
Message-ID: <4C62D37D.8020303@flatfrog.com>
References: <4C60205B.9090202@flatfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4C60205B.9090202-Gxjboj7dVqxWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 2010-08-09 17:35, Orjan Friberg wrote:
> When modprobing the driver platform_driver_probe returns -ENODEV but
> spi_gpio_probe is not being called, which seems odd to me.  Any suggestions?

This part I still don't understand, but I can at least insmod the driver 
by changing platform_driver_probe to platform_driver_register; it shows 
up in /sys/bus/platform/drivers now too.

(I get that I need to call platform_driver_register and create a sysfs 
entry etc before I have a device to play with.)

-- 
Orjan Friberg
FlatFrog Laboratories AB

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
