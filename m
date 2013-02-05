From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 6/6] spi/ath79: add shutdown handler
Date: Tue, 05 Feb 2013 13:02:07 +0000
Message-ID: <20130205130207.39E9F3E0E30@localhost>
References: <1356601349-23617-1-git-send-email-juhosg@openwrt.org>
	<1356601349-23617-7-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1356601349-23617-7-git-send-email-juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 27 Dec 2012 10:42:29 +0100, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wrote:
> The SPI controller of the AR7xxx/AR9xxx SoCs
> have a special mode which allows the SoC to
> directly read data from SPI flash chips. In
> this mode, the content of the SPI flash chip
> can be accessed via a memory mapped region.
> 
> During early init time, the kernel expects
> that the flash chip is accessible through
> that memory region because it reads board
> specific values (e.g. MAC address, WiFi
> calibration data) from the flash on various
> boards.
> 
> This is working if the kernel is loaded
> directly by the bootloader because that
> leaves the SPI controller in the special
> mode. However it is not working in a kexec'd
> kernel because the SPI driver does not restore
> the special mode during shutdown.
> 
> The patch adds a shutdown handler to fix this
> issue.
> 
> Signed-off-by: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> ---
>  drivers/spi/spi-ath79.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
> index 842acd8..73e491e 100644
> --- a/drivers/spi/spi-ath79.c
> +++ b/drivers/spi/spi-ath79.c
> @@ -293,7 +293,7 @@ err_put_master:
>  	return ret;
>  }
>  
> -static int ath79_spi_remove(struct platform_device *pdev)
> +static void __ath79_spi_remove(struct platform_device *pdev)
>  {
>  	struct ath79_spi *sp = platform_get_drvdata(pdev);
>  
> @@ -304,13 +304,23 @@ static int ath79_spi_remove(struct platform_device *pdev)
>  	iounmap(sp->base);
>  	platform_set_drvdata(pdev, NULL);
>  	spi_master_put(sp->bitbang.master);
> +}
>  
> +static int ath79_spi_remove(struct platform_device *pdev)
> +{
> +	__ath79_spi_remove(pdev);
>  	return 0;
>  }
>  
> +static void ath79_spi_shutdown(struct platform_device *pdev)
> +{
> +	__ath79_spi_remove(pdev);
> +}

Just call ath79_spi_remote(pdev) directly from ath79_spi_shutdown(). No
need for the extra hook and __ version of the original function.

g.


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
