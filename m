From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/imx: prevent NULL pointer dereference in
	spi_imx_probe()
Date: Tue, 03 Apr 2012 16:27:00 -0700
Message-ID: <20120403232701.0A50A3E03F3@localhost>
References: <1333458224-7602-1-git-send-email-LW@KARO-electronics.de>
Content-Type: multipart/mixed; boundary="===============0440756192788007715=="
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Juergen Beisert <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lothar Waßmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
To: Lothar Waßmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1333458224-7602-1-git-send-email-LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============0440756192788007715==

On Tue,  3 Apr 2012 15:03:44 +0200, Lothar Waßmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org> wrote:
> When no platform_data is present and either 'spi-num-chipselects' is
> not defined in the DT or 'cs-gpios' has less entries than
> 'spi-num-chipselects' specifies, the NULL platform_data pointer is
> being dereferenced.
> 
> Signed-off-by: Lothar Waßmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-imx.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 373f4ff..570f220 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -766,8 +766,12 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = of_property_read_u32(np, "fsl,spi-num-chipselects", &num_cs);
> -	if (ret < 0)
> -		num_cs = mxc_platform_info->num_chipselect;
> +	if (ret < 0) {
> +		if (mxc_platform_info)
> +			num_cs = mxc_platform_info->num_chipselect;
> +		else
> +			return ret;
> +	}
>  
>  	master = spi_alloc_master(&pdev->dev,
>  			sizeof(struct spi_imx_data) + sizeof(int) * num_cs);
> @@ -784,7 +788,7 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < master->num_chipselect; i++) {
>  		int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
> -		if (cs_gpio < 0)
> +		if (cs_gpio < 0 && mxc_platform_info)
>  			cs_gpio = mxc_platform_info->chipselect[i];
>  
>  		spi_imx->chipselect[i] = cs_gpio;
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.


--===============0440756192788007715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--===============0440756192788007715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0440756192788007715==--
