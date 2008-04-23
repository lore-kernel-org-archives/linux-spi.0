From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] spi_mpc83xx: test below 0 on
	unsigned irq in mpc83xx_spi_probe()
Date: Wed, 23 Apr 2008 15:39:32 -0500
Message-ID: <7C711FFF-E1C5-4286-93A8-382055C6760C@kernel.crashing.org>
References: <480F99D5.7070300@tiscali.nl>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org list" <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>,
	lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Roel Kluin <12o3l-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <480F99D5.7070300-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
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


On Apr 23, 2008, at 3:19 PM, Roel Kluin wrote:
> mpc83xx_spi->irq is unsigned, so the test fails
>
> Signed-off-by: Roel Kluin <12o3l-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>

you should copy the linux-spi list on such patches.

- k

>
> ---
> diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
> index be15a62..033fd51 100644
> --- a/drivers/spi/spi_mpc83xx.c
> +++ b/drivers/spi/spi_mpc83xx.c
> @@ -454,12 +454,12 @@ static int __init mpc83xx_spi_probe(struct  
> platform_device *dev)
> 		goto put_master;
> 	}
>
> -	mpc83xx_spi->irq = platform_get_irq(dev, 0);
> -
> -	if (mpc83xx_spi->irq < 0) {
> -		ret = -ENXIO;
> +	ret = platform_get_irq(dev, 0);
> +	if (ret < 0)
> 		goto unmap_io;
> -	}
> +
> +	mpc83xx_spi->irq = ret;
> +	ret = 0;
>
> 	/* Register for SPI Interrupt */
> 	ret = request_irq(mpc83xx_spi->irq, mpc83xx_spi_irq,


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
