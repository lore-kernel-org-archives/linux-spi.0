From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 6/7] spi/imx: copy gpio number passed by platform data
	into driver private data
Date: Mon, 11 Jul 2011 09:45:29 +0200
Message-ID: <20110711074529.GD13840@pengutronix.de>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
	<1310231801-18761-7-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1310231801-18761-7-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jul 10, 2011 at 01:16:40AM +0800, Shawn Guo wrote:
> It copies gpio number passed via platform data embedded pointer into
> driver private data, so that we do not need to refer to this embedded
> pointer passed by platform data after probe function exits.
> =

> Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> ---
>  drivers/spi/spi-imx.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 2ed9c32..ad61828 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -84,7 +84,6 @@ struct spi_imx_data {
>  	int irq;
>  	struct clk *clk;
>  	unsigned long spi_clk;
> -	int *chipselect;
>  =

>  	unsigned int count;
>  	void (*tx)(struct spi_imx_data *);
> @@ -94,6 +93,7 @@ struct spi_imx_data {
>  	unsigned int txfifo; /* number of words pushed in tx FIFO */
>  =

>  	struct spi_imx_devtype_data *devtype_data;
> +	int chipselect[0];
It's not needed to use a zero-length array here (which is a gcc
extension). A (C99) flexible array member should be fine.
Long words short: s/0//

>  };
>  =

>  static inline int is_imx27_cspi(struct spi_imx_data *d)
> @@ -743,7 +743,7 @@ static int __devinit spi_imx_probe(struct platform_de=
vice *pdev)
>  	struct spi_master *master;
>  	struct spi_imx_data *spi_imx;
>  	struct resource *res;
> -	int i, ret;
> +	int i, ret, num_cs;
>  =

>  	mxc_platform_info =3D dev_get_platdata(&pdev->dev);
>  	if (!mxc_platform_info) {
> @@ -751,20 +751,22 @@ static int __devinit spi_imx_probe(struct platform_=
device *pdev)
>  		return -EINVAL;
>  	}
>  =

> -	master =3D spi_alloc_master(&pdev->dev, sizeof(struct spi_imx_data));
> +	num_cs =3D mxc_platform_info->num_chipselect;
> +	master =3D spi_alloc_master(&pdev->dev,
> +			sizeof(struct spi_imx_data) + sizeof(int) * num_cs);
>  	if (!master)
>  		return -ENOMEM;
>  =

>  	platform_set_drvdata(pdev, master);
>  =

>  	master->bus_num =3D pdev->id;
> -	master->num_chipselect =3D mxc_platform_info->num_chipselect;
> +	master->num_chipselect =3D num_cs;
>  =

>  	spi_imx =3D spi_master_get_devdata(master);
>  	spi_imx->bitbang.master =3D spi_master_get(master);
> -	spi_imx->chipselect =3D mxc_platform_info->chipselect;
>  =

>  	for (i =3D 0; i < master->num_chipselect; i++) {
> +		spi_imx->chipselect[i] =3D mxc_platform_info->chipselect[i];
>  		if (spi_imx->chipselect[i] < 0)
>  			continue;
>  		ret =3D gpio_request(spi_imx->chipselect[i], DRIVER_NAME);
> -- =

> 1.7.4.1
> =

> =


-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
