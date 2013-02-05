From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/6] spi/ath79: add missing HIGH->LOW SCK transition
Date: Tue, 05 Feb 2013 12:57:55 +0000
Message-ID: <20130205125755.B47993E0E27@localhost>
References: <1356601349-23617-1-git-send-email-juhosg@openwrt.org>
	<1356601349-23617-3-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1356601349-23617-3-git-send-email-juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 27 Dec 2012 10:42:25 +0100, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wrote:
> The 'ath79_spi_txrx_mode0' function does not
> set the SCK signal to LOW at the end of a word
> transfer. This causes communications errors with
> certain devices (e.g. the PCF2123 RTC chip).
> 
> The patch ensures that the SCK signal will be LOW.
> 
> Signed-off-by: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-ath79.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
> index e025282..d4b8e12 100644
> --- a/drivers/spi/spi-ath79.c
> +++ b/drivers/spi/spi-ath79.c
> @@ -200,6 +200,8 @@ static u32 ath79_spi_txrx_mode0(struct spi_device *spi, unsigned nsecs,
>  		ath79_spi_delay(sp, nsecs);
>  		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, out | AR71XX_SPI_IOC_CLK);
>  		ath79_spi_delay(sp, nsecs);
> +		if (bits == 1)
> +			ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, out);
>  
>  		word <<= 1;
>  	}
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
