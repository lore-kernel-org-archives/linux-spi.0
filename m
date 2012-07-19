From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: spi/omap2: mark omap2_mcspi_master_setup as __devinit
Date: Thu, 19 Jul 2012 22:13:30 +0530
Message-ID: <50083932.8090209@ti.com>
References: <201207191452.56549.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201207191452.56549.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

+Mark
Since Grant is moving to a new house.

On Thursday 19 July 2012 08:22 PM, Arnd Bergmann wrote:
> This warning recently appeared with omap2plus_defconfig:
>
> WARNING: drivers/spi/built-in.o(.devinit.text+0x3c4): Section mismatch in reference from the function omap2_mcspi_probe() to the function .init.text:omap2_mcspi_master_setup()
> The function __devinit omap2_mcspi_probe() references
> a function __init omap2_mcspi_master_setup().
> If omap2_mcspi_master_setup is only used by omap2_mcspi_probe then
> annotate omap2_mcspi_master_setup with a matching annotation.
>
> The fix is obviously to mark the omap2_mcspi_master_setup function as
> __devinit, rather than __init.
Acked-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org <mailto:shubhrajyoti-l0cyMroinI0@public.gmane.org>>

Thanks for the patch.
Apologies for breaking in one  my patch series.
>
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 0c73dd4..dc02f2f 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -1032,7 +1032,7 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
>  	return 0;
>  }
>  
> -static int __init omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
> +static int __devinit omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
>  {
>  	struct spi_master	*master = mcspi->master;
>  	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
