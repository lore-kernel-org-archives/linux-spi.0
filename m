From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/sirf: fix error propagation in spi_sirfsoc_probe()
Date: Thu, 6 Jun 2013 09:36:43 +0800
Message-ID: <CAGsJ_4w6o9aSRDrH-nZRk77bRMxLUHDY5auePz_NzPC0pH1cjw@mail.gmail.com>
References: <1370467796-4641-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: ldv-project-tpLiQldItUH5n4uC9ZG1Ww@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Alexey Khoroshilov <khoroshilov-ufN2psIa012HXe+LvDLADg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1370467796-4641-1-git-send-email-khoroshilov-ufN2psIa012HXe+LvDLADg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2013/6/6 Alexey Khoroshilov <khoroshilov-ufN2psIa012HXe+LvDLADg@public.gmane.org>:
> If pinctrl_get_select_default() fails, spi_sirfsoc_probe()
> returns IS_ERR(sspi->p) instead of PTR_ERR(sspi->p).
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov-ufN2psIa012HXe+LvDLADg@public.gmane.org>

Acked-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>

> ---
>  drivers/spi/spi-sirf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
> index 0808cd5..94c3920 100644
> --- a/drivers/spi/spi-sirf.c
> +++ b/drivers/spi/spi-sirf.c
> @@ -559,9 +559,10 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
>         sspi->bitbang.master->dev.of_node = pdev->dev.of_node;
>
>         sspi->p = pinctrl_get_select_default(&pdev->dev);
> -       ret = IS_ERR(sspi->p);
> -       if (ret)
> +       if (IS_ERR(sspi->p)) {
> +               ret = PTR_ERR(sspi->p);
>                 goto free_master;
> +       }
>
>         sspi->clk = clk_get(&pdev->dev, NULL);
>         if (IS_ERR(sspi->clk)) {
> --
> 1.8.1.2

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
