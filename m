From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH] spi/mpc5121: register spi child
 devices of spi node
Date: Tue, 27 Jul 2010 09:17:44 +0300
Message-ID: <20100727061744.GB22765@jasper.tkos.co.il>
References: <1280185178-5002-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1280185178-5002-1-git-send-email-agust-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Anatolij,

On Tue, Jul 27, 2010 at 12:59:38AM +0200, Anatolij Gustschin wrote:
> Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
> ---
>  drivers/spi/mpc512x_psc_spi.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)

You should CC Grant Likely on this. He is now the de-facto maintainer of the 
SPI subsystem.

baruch

> diff --git a/drivers/spi/mpc512x_psc_spi.c b/drivers/spi/mpc512x_psc_spi.c
> index c8d69fc..39e5faf 100644
> --- a/drivers/spi/mpc512x_psc_spi.c
> +++ b/drivers/spi/mpc512x_psc_spi.c
> @@ -27,6 +27,7 @@
>  #include <linux/clk.h>
>  #include <linux/spi/spi.h>
>  #include <linux/fsl_devices.h>
> +#include <linux/of_spi.h>
>  #include <asm/mpc52xx_psc.h>
>  
>  struct mpc512x_psc_spi {
> @@ -511,6 +512,7 @@ static int __devinit mpc512x_psc_spi_of_probe(struct of_device *op,
>  	const u32 *regaddr_p;
>  	u64 regaddr64, size64;
>  	s16 id = -1;
> +	int ret;
>  
>  	regaddr_p = of_get_address(op->dev.of_node, 0, &size64, NULL);
>  	if (!regaddr_p) {
> @@ -533,8 +535,14 @@ static int __devinit mpc512x_psc_spi_of_probe(struct of_device *op,
>  		id = *psc_nump;
>  	}
>  
> -	return mpc512x_psc_spi_do_probe(&op->dev, (u32) regaddr64, (u32) size64,
> +	ret = mpc512x_psc_spi_do_probe(&op->dev, (u32) regaddr64, (u32) size64,
>  				irq_of_parse_and_map(op->dev.of_node, 0), id);
> +
> +	if (!ret)
> +		of_register_spi_devices(dev_get_drvdata(&op->dev),
> +					op->dev.of_node);
> +
> +	return ret;
>  }
>  
>  static int __devexit mpc512x_psc_spi_of_remove(struct of_device *op)
> -- 
> 1.7.0.4
> 
> 
> ------------------------------------------------------------------------------
> The Palm PDK Hot Apps Program offers developers who use the
> Plug-In Development Kit to bring their C/C++ apps to Palm for a share 
> of $1 Million in cash or HP Products. Visit us here for more details:
> http://ad.doubleclick.net/clk;226879339;13503038;l?
> http://clk.atdmt.com/CRS/go/247765532/direct/01/
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share 
of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
