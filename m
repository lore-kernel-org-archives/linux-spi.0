From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: sirf: use clk_prepare_enable and
	clk_disable_unprepare
Date: Tue, 05 Feb 2013 12:43:42 +0000
Message-ID: <20130205124342.EB5AC3E0E27@localhost>
References: <1356490114-18022-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1356490114-18022-1-git-send-email-Barry.Song-kQvG35nSl+M@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 26 Dec 2012 10:48:33 +0800, Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org> wrote:
> From: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
> 
> Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
> calls as required by common clock framework.
> 
> Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-sirf.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
> index e0f43a5..38a191c 100644
> --- a/drivers/spi/spi-sirf.c
> +++ b/drivers/spi/spi-sirf.c
> @@ -570,7 +570,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
>  		ret = -EINVAL;
>  		goto free_pin;
>  	}
> -	clk_enable(sspi->clk);
> +	clk_prepare_enable(sspi->clk);
>  	sspi->ctrl_freq = clk_get_rate(sspi->clk);
>  
>  	init_completion(&sspi->done);
> @@ -594,7 +594,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  free_clk:
> -	clk_disable(sspi->clk);
> +	clk_disable_unprepare(sspi->clk);
>  	clk_put(sspi->clk);
>  free_pin:
>  	pinctrl_put(sspi->p);
> @@ -618,7 +618,7 @@ static int  spi_sirfsoc_remove(struct platform_device *pdev)
>  		if (sspi->chipselect[i] > 0)
>  			gpio_free(sspi->chipselect[i]);
>  	}
> -	clk_disable(sspi->clk);
> +	clk_disable_unprepare(sspi->clk);
>  	clk_put(sspi->clk);
>  	pinctrl_put(sspi->p);
>  	spi_master_put(master);
> -- 
> 1.7.5.4
> 
> 
> 
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
