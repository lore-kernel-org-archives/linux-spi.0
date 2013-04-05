From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH] spi: hspi: fixup long delay time
Date: Fri, 5 Apr 2013 15:07:18 +0900
Message-ID: <20130405060716.GA18557@verge.net.au>
References: <87hajlk0oh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, goda <yusuke.goda.sx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87hajlk0oh.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Apr 04, 2013 at 10:26:42PM -0700, Kuninori Morimoto wrote:
> Current HSPI driver is using msleep(20) on hspi_status_check_timeout(),
> but it was too long delay for SPI device.
> Bock-W board SPI access was too slow without this patch.
> This patch uses udelay(10) for it.
> 
> Tested-by: Yusuke Goda <yusuke.goda.sx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

Acked-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Grant, can you take this patch?

> ---
>  drivers/spi/spi-sh-hspi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
> index 60cfae5..eab593e 100644
> --- a/drivers/spi/spi-sh-hspi.c
> +++ b/drivers/spi/spi-sh-hspi.c
> @@ -89,7 +89,7 @@ static int hspi_status_check_timeout(struct hspi_priv *hspi, u32 mask, u32 val)
>  		if ((mask & hspi_read(hspi, SPSR)) == val)
>  			return 0;
>  
> -		msleep(20);
> +		udelay(10);
>  	}
>  
>  	dev_err(hspi->dev, "timeout\n");
> -- 
> 1.7.9.5
> 

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
