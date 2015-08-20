From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 4/9] spi: sun4i: add DMA support
Date: Thu, 20 Aug 2015 16:56:56 +0200
Message-ID: <20150820145656.GW30520@lukather>
References: <cover.1440080122.git.hramrach@gmail.com>
 <ccf776869b0d7fe2c78bcc41d6cd1896bf732296.1440080122.git.hramrach@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pEAjBjStGYT6H+Py"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBOOV26XAKGQEBI7KBGY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ccf776869b0d7fe2c78bcc41d6cd1896bf732296.1440080122.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--pEAjBjStGYT6H+Py
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2015 at 02:19:46PM -0000, Emilio L=C3=B3pez wrote:
> From: Emilio L=C3=B3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
>=20
> This patch adds support for 64 byte or bigger transfers on the
> sun4i SPI controller. Said transfers will be performed via DMA.
>=20
> Signed-off-by: Emilio L=C3=B3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
> Tested-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This should have your SoB.

> ---
>  drivers/spi/spi-sun4i.c | 145 ++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 130 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 4dda366..63242a7 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -14,6 +14,8 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -34,6 +36,7 @@
>  #define SUN4I_CTL_CPHA				BIT(2)
>  #define SUN4I_CTL_CPOL				BIT(3)
>  #define SUN4I_CTL_CS_ACTIVE_LOW			BIT(4)
> +#define SUN4I_CTL_DMAMC_DEDICATED		BIT(5)
>  #define SUN4I_CTL_LMTF				BIT(6)
>  #define SUN4I_CTL_TF_RST			BIT(8)
>  #define SUN4I_CTL_RF_RST			BIT(9)
> @@ -51,6 +54,8 @@
>  #define SUN4I_INT_STA_REG		0x10
> =20
>  #define SUN4I_DMA_CTL_REG		0x14
> +#define SUN4I_DMA_CTL_RF_READY			BIT(0)
> +#define SUN4I_DMA_CTL_TF_NOT_FULL		BIT(10)
> =20
>  #define SUN4I_WAIT_REG			0x18
> =20
> @@ -130,6 +135,13 @@ static inline void sun4i_spi_fill_fifo(struct sun4i_=
spi *sspi, int len)
>  	}
>  }
> =20
> +static bool sun4i_spi_can_dma(struct spi_master *master,
> +			      struct spi_device *spi,
> +			      struct spi_transfer *tfr)
> +{
> +	return tfr->len >=3D SUN4I_FIFO_DEPTH;
> +}
> +
>  static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
>  {
>  	struct sun4i_spi *sspi =3D spi_master_get_devdata(spi->master);
> @@ -169,17 +181,12 @@ static int sun4i_spi_transfer_one(struct spi_master=
 *master,
>  				  struct spi_transfer *tfr)
>  {
>  	struct sun4i_spi *sspi =3D spi_master_get_devdata(master);
> +	struct dma_async_tx_descriptor *desc_tx =3D NULL, *desc_rx =3D NULL;
>  	unsigned int speed, mclk_rate, div, timeout;
>  	unsigned int start, end, tx_time;
>  	unsigned int tx_len =3D 0;
> +	u32 reg, trigger =3D 0;
>  	int ret =3D 0;
> -	u32 reg;
> -
> -	/* We don't support transfer larger than the FIFO */
> -	if (tfr->len > SUN4I_FIFO_DEPTH)
> -		return -EINVAL;
> -	if (tfr->tx_buf && tfr->len =3D> SUN4I_FIFO_DEPTH)
> -		return -EINVAL;
> =20
>  	reinit_completion(&sspi->done);
>  	sspi->tx_buf =3D tfr->tx_buf;
> @@ -277,14 +284,67 @@ static int sun4i_spi_transfer_one(struct spi_master=
 *master,
>  	sun4i_spi_write(sspi, SUN4I_BURST_CNT_REG, SUN4I_BURST_CNT(tfr->len));
>  	sun4i_spi_write(sspi, SUN4I_XMIT_CNT_REG, SUN4I_XMIT_CNT(tx_len));
> =20
> -	/* Fill the TX FIFO */
> -	/* Filling the fifo fully causes timeout for some reason
> -	 * at least on spi2 on a10s */
> -	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
> -
>  	/* Enable the interrupts */
>  	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
> =20
> +	if (sun4i_spi_can_dma(master, spi, tfr)) {
> +		dev_dbg(&sspi->master->dev, "Using DMA mode for transfer\n");
> +
> +		if (sspi->tx_buf) {
> +			desc_tx =3D dmaengine_prep_slave_sg(master->dma_tx,
> +					tfr->tx_sg.sgl, tfr->tx_sg.nents,
> +					DMA_TO_DEVICE,
> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +			if (!desc_tx) {
> +				dev_err(&sspi->master->dev,
> +					"Couldn't prepare dma slave\n");
> +				return -EIO;
> +			}
> +
> +			trigger |=3D SUN4I_DMA_CTL_TF_NOT_FULL;
> +
> +			dmaengine_submit(desc_tx);
> +			dma_async_issue_pending(master->dma_tx);
> +
> +		}
> +
> +		if (sspi->rx_buf) {
> +			desc_rx =3D dmaengine_prep_slave_sg(master->dma_rx,
> +					tfr->rx_sg.sgl, tfr->rx_sg.nents,
> +					DMA_FROM_DEVICE,
> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +			if (!desc_rx) {
> +				dev_err(&sspi->master->dev,
> +					"Couldn't prepare dma slave\n");
> +				return -EIO;
> +			}
> +
> +			trigger |=3D SUN4I_DMA_CTL_RF_READY;
> +
> +			dmaengine_submit(desc_rx);
> +			dma_async_issue_pending(master->dma_rx);
> +		}

What happens if the dma driver controller isn't present in your
system? Or that it doesn't have any channels available anymore?

> +		/* Enable Dedicated DMA requests */
> +		reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
> +		reg |=3D SUN4I_CTL_DMAMC_DEDICATED;
> +		sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
> +		sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, trigger);
> +	} else {
> +		dev_dbg(&sspi->master->dev, "Using PIO mode for transfer\n");
> +
> +		/* Disable DMA requests */
> +		reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
> +		sun4i_spi_write(sspi, SUN4I_CTL_REG,
> +				reg & ~SUN4I_CTL_DMAMC_DEDICATED);
> +		sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, 0);
> +
> +		/* Fill the TX FIFO */
> +		/* Filling the fifo fully causes timeout for some reason
> +		 * at least on spi2 on a10s */
> +		sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
> +	}
> +
>  	/* Start the transfer */
>  	reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
>  	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
> @@ -303,7 +363,12 @@ static int sun4i_spi_transfer_one(struct spi_master =
*master,
>  		goto out;
>  	}
> =20
> -	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> +	if (sun4i_spi_can_dma(master, spi, tfr) && desc_rx) {
> +		/* The receive transfer should be the last one to finish */
> +		dma_wait_for_async_tx(desc_rx);

Nope, this is only meant for async_tx. You should register a callback
in your transfer that will mark the completion structure as completed,
and then drain the FIFO only if not using DMA.

> +	} else {
> +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> +	}
> =20
>  out:
>  	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
> @@ -368,6 +433,7 @@ static int sun4i_spi_runtime_suspend(struct device *d=
ev)
> =20
>  static int sun4i_spi_probe(struct platform_device *pdev)
>  {
> +	struct dma_slave_config dma_sconfig;
>  	struct spi_master *master;
>  	struct sun4i_spi *sspi;
>  	struct resource	*res;
> @@ -403,7 +469,9 @@ static int sun4i_spi_probe(struct platform_device *pd=
ev)
>  		goto err_free_master;
>  	}
> =20
> +	init_completion(&sspi->done);
>  	sspi->master =3D master;
> +	master->can_dma =3D sun4i_spi_can_dma;
>  	master->set_cs =3D sun4i_spi_set_cs;
>  	master->transfer_one =3D sun4i_spi_transfer_one;
>  	master->num_chipselect =3D 4;
> @@ -426,7 +494,45 @@ static int sun4i_spi_probe(struct platform_device *p=
dev)
>  		goto err_free_master;
>  	}
> =20
> -	init_completion(&sspi->done);
> +	master->dma_tx =3D dma_request_slave_channel_reason(&pdev->dev, "tx");
> +	if (IS_ERR(master->dma_tx)) {
> +		dev_err(&pdev->dev, "Unable to acquire DMA channel TX\n");
> +		ret =3D PTR_ERR(master->dma_tx);
> +		goto err_free_master;
> +	}
> +
> +	dma_sconfig.direction =3D DMA_MEM_TO_DEV;
> +	dma_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dma_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dma_sconfig.dst_addr =3D res->start + SUN4I_TXDATA_REG;
> +	dma_sconfig.src_maxburst =3D 1;
> +	dma_sconfig.dst_maxburst =3D 1;
> +
> +	ret =3D dmaengine_slave_config(master->dma_tx, &dma_sconfig);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to configure TX DMA slave\n");
> +		goto err_tx_dma_release;
> +	}
> +
> +	master->dma_rx =3D dma_request_slave_channel_reason(&pdev->dev, "rx");
> +	if (IS_ERR(master->dma_rx)) {
> +		dev_err(&pdev->dev, "Unable to acquire DMA channel RX\n");
> +		ret =3D PTR_ERR(master->dma_rx);
> +		goto err_tx_dma_release;
> +	}
> +
> +	dma_sconfig.direction =3D DMA_DEV_TO_MEM;
> +	dma_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dma_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dma_sconfig.src_addr =3D res->start + SUN4I_RXDATA_REG;
> +	dma_sconfig.src_maxburst =3D 1;
> +	dma_sconfig.dst_maxburst =3D 1;

We can't use a higher bust size?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--pEAjBjStGYT6H+Py
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV1eq4AAoJEBx+YmzsjxAgudYP/0owmJz6JZcB67hQHjyXKV0a
a49PTXoGlq3kn1ivW1igkMJ+p+g3ShxFjxBfiH+CJG+iSrEho2OuJN2tzJinvf7v
eucRTAlG9Sedb9OQvJqSsK6RBNcNK4dBsrrZF3wmwe35UH6RTJar9pHfrIvGyLWz
00+lQtJRR3J6QbJ4EsGBtW99+qWfFkWQvawrtIoPc7qw/+Q8rpAXQECLHcj5YwzE
CnJ3/tQboCN1fL5vubBFeYsp4NyFIuQLiySrm/y6MnhIby0Vjz8js1O65mBPtU4A
CNw8SCBY+A90Euc7WZIc73TN94TbA4opMjfxWC0MNcqaL5Unx4+BEoezGRz5bYHY
QuPwQcshOwbEFlBMxCaPBf8U0jO91fc1htR0Wlqwl+dK8oTMuHuTz/kfwWJQ7gM4
JN8m4cfMrpdepfnU+/DixYMAPsoAI0APMDoInDEhhiBgThFxECNWRSKQPxkGNjmz
w1iYrqURpnH+/eo3Eghmwf98hZhcLiFr5ISmDaTVO4pMG/3O/JjKfd1vPCq8PD4C
YenCxIM+ccCDJpXi2ciBRZgEbr+w+7Dtwgz1/AkwYQJrAlUhKyYnaMS/M5XtsMTD
kFqO+ON+swzWTOQaqVveoCepjvgdx1C8gdaanYifEXiYaH+TxO8UQSzf9d6FTxPJ
VFQnsZiyVD30wjIyafh3
=qCNM
-----END PGP SIGNATURE-----

--pEAjBjStGYT6H+Py--
