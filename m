From: Andrei Konovalov <akonovalov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [patch 2.6.23-rc3-git] SPI driver
	hotplug/coldplug fixes
Date: Fri, 24 Aug 2007 18:50:20 +0400
Message-ID: <46CEF02C.2010505@ru.mvista.com>
References: <200708221315.12184.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Wolfgang Reissnegger <wolfgang.reissnegger-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org, ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200708221315.12184.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David Brownell wrote:
> Update various SPI drivers so they properly support
> 
>   - coldplug through "modprobe $(cat /sys/devices/.../modalias)"
> 
>   - hotplug through "modprobe $(MODALIAS)"
> 
> The basic rule for platform, SPI, and (new style) I2C drivers is just
> to make sure that modprobing the driver name works.  In this case, all
> the relevant drivers are platform drivers, and this patch either
> 
>   (a)	Changes the driver name, if no in-tree code would break;
> 	this is simpler and thus preferable in the long term.
> 
>   (b)	Adds MODULE_ALIAS directives, when in-tree platforms declare
> 	devices using the current driver name; less desirable.
> 
> Most systems will link SPI controller drivers statically, but
> there's no point in being needlessly broken.
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
> Build-tested for the ARM drivers.
> 
>  drivers/spi/spi_bfin5xx.c      |    3 ++-
>  drivers/spi/spi_imx.c          |    2 +-
>  drivers/spi/spi_mpc83xx.c      |    1 +
>  drivers/spi/spi_s3c24xx.c      |    1 +
>  drivers/spi/spi_s3c24xx_gpio.c |    2 +-
>  drivers/spi/spi_txx9.c         |    1 +
>  drivers/spi/xilinx_spi.c       |    2 +-
>  7 files changed, 8 insertions(+), 4 deletions(-)

<snip>
> --- g26.orig/drivers/spi/xilinx_spi.c	2007-08-11 11:48:09.000000000 -0700
> +++ g26/drivers/spi/xilinx_spi.c	2007-08-11 12:13:19.000000000 -0700
> @@ -21,7 +21,7 @@
>  
>  #include <syslib/virtex_devices.h>
>  
> -#define XILINX_SPI_NAME "xspi"
> +#define XILINX_SPI_NAME "xilinx_spi"
>  
>  /* Register definitions as per "OPB Serial Peripheral Interface (SPI) (v1.00e)
>   * Product Specification", DS464

Acked-by: Andrei Konovalov <akonovalov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>

I'll add the corresponding modifications to the device registration stuff
for the Xilinx boards to git://source.mvista.com/git/linux-xilinx-26.git shortly.

Thanks,
Andrei

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
