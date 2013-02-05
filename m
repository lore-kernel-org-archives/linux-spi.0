From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/6] spi/ath79: remove superfluous chip select code
Date: Tue, 05 Feb 2013 12:58:28 +0000
Message-ID: <20130205125828.140AA3E0E27@localhost>
References: <1356601349-23617-1-git-send-email-juhosg@openwrt.org>
	<1356601349-23617-4-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1356601349-23617-4-git-send-email-juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 27 Dec 2012 10:42:26 +0100, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wrote:
> The spi_bitbang driver calls the chipselect function
> of the driver from spi_bitbang_setup in order to
> deselect the given SPI chip, so we don't have to
> initialize the CS line here.
> 
> Signed-off-by: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>

Applied, thanks.

g.
> ---
>  drivers/spi/spi-ath79.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
> index d4b8e12..a725e62 100644
> --- a/drivers/spi/spi-ath79.c
> +++ b/drivers/spi/spi-ath79.c
> @@ -128,12 +128,6 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
>  			gpio_free(cdata->gpio);
>  			return status;
>  		}
> -	} else {
> -		if (spi->mode & SPI_CS_HIGH)
> -			sp->ioc_base |= AR71XX_SPI_IOC_CS0;
> -		else
> -			sp->ioc_base &= ~AR71XX_SPI_IOC_CS0;
> -		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
>  	}
>  
>  	return 0;
> -- 
> 1.7.10
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
