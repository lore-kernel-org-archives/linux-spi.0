From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 1/7] spi/imx: do not make copy of spi_imx_devtype_data
Date: Thu, 14 Jul 2011 20:53:40 -0600
Message-ID: <20110715025340.GP2927@ponder.secretlab.ca>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
	<1310231801-18761-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1310231801-18761-2-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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

On Sun, Jul 10, 2011 at 01:16:35AM +0800, Shawn Guo wrote:
> spi_imx_devtype_data has already been driver private data.  There is
> really no need to make a copy in spi_imx_data.  Instead, a reference
> pointer works perfectly fine.
> =

> Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-imx.c |   24 ++++++++++++------------
>  1 files changed, 12 insertions(+), 12 deletions(-)
> =

> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 69d6dba..1c55dc9 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -96,7 +96,7 @@ struct spi_imx_data {
>  	const void *tx_buf;
>  	unsigned int txfifo; /* number of words pushed in tx FIFO */
>  =

> -	struct spi_imx_devtype_data devtype_data;
> +	struct spi_imx_devtype_data *devtype_data;
>  };
>  =

>  #define MXC_SPI_BUF_RX(type)						\
> @@ -539,7 +539,7 @@ static void __maybe_unused mx1_reset(struct spi_imx_d=
ata *spi_imx)
>   * These version numbers are taken from the Freescale driver.  Unfortuna=
tely it
>   * doesn't support i.MX1, so this entry doesn't match the scheme. :-(
>   */
> -static struct spi_imx_devtype_data spi_imx_devtype_data[] __devinitdata =
=3D {
> +static struct spi_imx_devtype_data spi_imx_devtype_data[] =3D {
>  #ifdef CONFIG_SPI_IMX_VER_IMX1
>  	[SPI_IMX_VER_IMX1] =3D {
>  		.intctrl =3D mx1_intctrl,
> @@ -607,21 +607,21 @@ static void spi_imx_chipselect(struct spi_device *s=
pi, int is_active)
>  =

>  static void spi_imx_push(struct spi_imx_data *spi_imx)
>  {
> -	while (spi_imx->txfifo < spi_imx->devtype_data.fifosize) {
> +	while (spi_imx->txfifo < spi_imx->devtype_data->fifosize) {
>  		if (!spi_imx->count)
>  			break;
>  		spi_imx->tx(spi_imx);
>  		spi_imx->txfifo++;
>  	}
>  =

> -	spi_imx->devtype_data.trigger(spi_imx);
> +	spi_imx->devtype_data->trigger(spi_imx);
>  }
>  =

>  static irqreturn_t spi_imx_isr(int irq, void *dev_id)
>  {
>  	struct spi_imx_data *spi_imx =3D dev_id;
>  =

> -	while (spi_imx->devtype_data.rx_available(spi_imx)) {
> +	while (spi_imx->devtype_data->rx_available(spi_imx)) {
>  		spi_imx->rx(spi_imx);
>  		spi_imx->txfifo--;
>  	}
> @@ -635,12 +635,12 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_i=
d)
>  		/* No data left to push, but still waiting for rx data,
>  		 * enable receive data available interrupt.
>  		 */
> -		spi_imx->devtype_data.intctrl(
> +		spi_imx->devtype_data->intctrl(
>  				spi_imx, MXC_INT_RR);
>  		return IRQ_HANDLED;
>  	}
>  =

> -	spi_imx->devtype_data.intctrl(spi_imx, 0);
> +	spi_imx->devtype_data->intctrl(spi_imx, 0);
>  	complete(&spi_imx->xfer_done);
>  =

>  	return IRQ_HANDLED;
> @@ -677,7 +677,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>  	} else
>  		BUG();
>  =

> -	spi_imx->devtype_data.config(spi_imx, &config);
> +	spi_imx->devtype_data->config(spi_imx, &config);
>  =

>  	return 0;
>  }
> @@ -696,7 +696,7 @@ static int spi_imx_transfer(struct spi_device *spi,
>  =

>  	spi_imx_push(spi_imx);
>  =

> -	spi_imx->devtype_data.intctrl(spi_imx, MXC_INT_TE);
> +	spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE);
>  =

>  	wait_for_completion(&spi_imx->xfer_done);
>  =

> @@ -811,7 +811,7 @@ static int __devinit spi_imx_probe(struct platform_de=
vice *pdev)
>  	init_completion(&spi_imx->xfer_done);
>  =

>  	spi_imx->devtype_data =3D
> -		spi_imx_devtype_data[pdev->id_entry->driver_data];
> +		&spi_imx_devtype_data[pdev->id_entry->driver_data];
>  =

>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
> @@ -854,9 +854,9 @@ static int __devinit spi_imx_probe(struct platform_de=
vice *pdev)
>  	clk_enable(spi_imx->clk);
>  	spi_imx->spi_clk =3D clk_get_rate(spi_imx->clk);
>  =

> -	spi_imx->devtype_data.reset(spi_imx);
> +	spi_imx->devtype_data->reset(spi_imx);
>  =

> -	spi_imx->devtype_data.intctrl(spi_imx, 0);
> +	spi_imx->devtype_data->intctrl(spi_imx, 0);
>  =

>  	ret =3D spi_bitbang_start(&spi_imx->bitbang);
>  	if (ret) {
> -- =

> 1.7.4.1
> =
