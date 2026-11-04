Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798629;
	b=glL5eThuBA+d7zYgK6lxSiQGPPBsICM1NLkRklR2eFXBaX62+XvQfR6Z3wiXw8Q+31AT
	 NXa5HYqNUI1/kZ0iI7Z+vaWT6BtrXMlKCGB61V+aEpOEJZz9oTMEXjvw4SmUKBn5bPdaI
	 nLhBNSbeVoGm/Lb6DVKa7NVHh/zeHsKezjYakITZTuRvGUCc+1MvaJ1pzg3ob74mFw5sz
	 tM0KwbI/wLwuCyeAOlC4yxmylb7RyIq4KyGCSKqojFuLqCO2kVQjf445qwSZPTJXLlB0x
	 G0kbglWCqe5H7ULruw+l3GPGrXUh0ZpehaaF0aOcQ8prxergX9arqDyC0cWKT99P6UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798629;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oFQnvnnH43Wjq3NYgvbhyicdVMArULRPqgjr7vsX1pw=;
	b=zgeaB1xuQ/sfDYQgX2HxodOtYYDHRYKuGOoNhevG41E1R44YNaCyvs3+hsIkyPluM7uh
	 V7TzqJ2zQOeCmkLpMrWdw8MstiIv4cOJr2jjXa5SFcnENCDCZ1arIoLYIJSbFKy4bBLIl
	 BBbOFDgrvt2DIPiuTxRQCcE/rbtzFQfkCFNFZqWUb87+Sx/pfOLbqORdKO6PzxX2nu5lS
	 0o2eNMZGEGqv85Zv3kVep954etuNm3qHGz1dDqit9DqD8blWL4ZTVaSnQKY+2giq0s3rC
	 qJ5wS/u3AEmAz+4BscX+0ppwSWBgVB1IE5A1Y2sLLkzfpZpaN1zkp7vHl+QKgwvk8TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QcpuR7ET;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8D606A31B;
	Wed,  4 Nov 2026 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QcpuR7ET
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39071F000C1;
	Wed,  4 Nov 2026 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793798628;
	bh=oFQnvnnH43Wjq3NYgvbhyicdVMArULRPqgjr7vsX1pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QcpuR7ET2kcVQW1ILYUtFcGQUEsKGY8ZeaQ18BLfMdpM6Zy6dkppvEbCV6rUBWF+Z
	 Avh461nN5C3d1WxLXpdJfJmRlSx94IWc0WORuZHjgQFVG8AHCMBDHIBB21RFeWNL7c
	 CYfv29sCqv9yv9eKKZCmsvqy/46JQVY9jYhn4wBixP0qFjGg8bGSfVE5wP+9W86Y5x
	 86TU3B/xrwNjStTaH8iRHT9M3mYY+xdVYghtd2X3Xd+x2Sbcg6RdDy1a0wNkaZh/lu
	 rv/Ff6yJHH6uJzZihNSR3BrMSXAfQ0wbr/gGY+M+iePQDMSrsMBvSsPT1SYiR62UgJ
	 Znax0soeaSpHQ==
Date: Wed, 4 Nov 2026 14:23:46 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Mark Brown <broonie@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Radu Pirea <radu_nicolae.pirea@upb.ro>, 
	CL Wang <cl634@andestech.com>, Ryan Wanner <ryan.wanner@microchip.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Heiko Stuebner <heiko@sntech.de>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Yixun Lan <dlan@kernel.org>, Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>, 
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, "open list:FREESCALE DSPI DRIVER" <imx@lists.linux.dev>, 
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	"open list:RENESAS RZ/V2H(P) RSPI DRIVER" <linux-renesas-soc@vger.kernel.org>, 
	"open list:SAMSUNG SPI DRIVERS" <linux-samsung-soc@vger.kernel.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, vkoul@kernel.org
Subject: Re: [PATCH 1/1] spi: use dmaengine_desc_set_callback()
Message-ID: <aust2fUAFSsAXK9g@orome>
References: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="unoy3twvi5fxh2md"
Content-Disposition: inline
In-Reply-To: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>


--unoy3twvi5fxh2md
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] spi: use dmaengine_desc_set_callback()
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 12:39:58PM -0500, Frank.Li@oss.nxp.com wrote:
[...]
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index 087735ed9c80c..b115daf2c76f3 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -703,10 +703,8 @@ static int davinci_spi_bufs(struct spi_device *spi, =
struct spi_transfer *t)
>  		if (!txdesc)
>  			goto err_desc;
> =20
> -		rxdesc->callback =3D davinci_spi_dma_rx_callback;
> -		rxdesc->callback_param =3D (void *)dspi;
> -		txdesc->callback =3D davinci_spi_dma_tx_callback;
> -		txdesc->callback_param =3D (void *)dspi;
> +		dmaengine_desc_set_callback(rxdesc, davinci_spi_dma_rx_callback, NULL,=
 (void *)dspi);
> +		dmaengine_desc_set_callback(txdesc, davinci_spi_dma_tx_callback, NULL,=
 (void *)dspi);

You could probably drop the cast while at it.

> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index b25f94b2ef738..7798197d5b350 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -634,8 +634,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controll=
er *controller,
>  	if (!desc_rx)
>  		return -EINVAL;
> =20
> -	desc_rx->callback =3D fsl_lpspi_dma_rx_callback;
> -	desc_rx->callback_param =3D (void *)fsl_lpspi;
> +	dmaengine_desc_set_callback(desc_rx, fsl_lpspi_dma_rx_callback, NULL, (=
void *)fsl_lpspi);

Same here.

>  	dmaengine_submit(desc_rx);
>  	reinit_completion(&fsl_lpspi->dma_rx_completion);
>  	dma_async_issue_pending(controller->dma_rx);
> @@ -648,8 +647,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controll=
er *controller,
>  		return -EINVAL;
>  	}
> =20
> -	desc_tx->callback =3D fsl_lpspi_dma_tx_callback;
> -	desc_tx->callback_param =3D (void *)fsl_lpspi;
> +	dmaengine_desc_set_callback(desc_tx, fsl_lpspi_dma_tx_callback, NULL, (=
void *)fsl_lpspi);

And here.

> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index cadf0b93f4403..f8a3ac11f49d0 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1738,8 +1738,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *=
spi_imx,
>  		return -EINVAL;
>  	}
> =20
> -	desc_rx->callback =3D spi_imx_dma_rx_callback;
> -	desc_rx->callback_param =3D (void *)spi_imx;
> +	dmaengine_desc_set_callback(desc_rx, spi_imx_dma_rx_callback, NULL, (vo=
id *)spi_imx);

Here, too.

>  	cookie =3D dmaengine_submit(desc_rx);
>  	if (dma_submit_error(cookie)) {
>  		dev_err(spi_imx->dev, "submitting DMA RX failed\n");
> @@ -1756,8 +1755,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *=
spi_imx,
>  	if (!desc_tx)
>  		goto dmaengine_terminate_rx;
> =20
> -	desc_tx->callback =3D spi_imx_dma_tx_callback;
> -	desc_tx->callback_param =3D (void *)spi_imx;
> +	dmaengine_desc_set_callback(desc_tx, spi_imx_dma_tx_callback, NULL, (vo=
id *)spi_imx);

And here.

> index eb3485149e75a..fdda26eb311fb 100644
> --- a/drivers/spi/spi-topcliff-pch.c
> +++ b/drivers/spi/spi-topcliff-pch.c
> @@ -1021,8 +1021,7 @@ static void pch_spi_handle_dma(struct pch_spi_data =
*data, int *bpw)
>  		return;
>  	}
>  	dma_sync_sg_for_device(&data->host->dev, sg, num, DMA_FROM_DEVICE);
> -	desc_rx->callback =3D pch_dma_rx_complete;
> -	desc_rx->callback_param =3D data;
> +	dmaengine_desc_set_callback(desc_rx, pch_dma_rx_complete, NULL, data);
>  	dma->nent =3D num;
>  	dma->desc_rx =3D desc_rx;
> =20
> @@ -1083,8 +1082,7 @@ static void pch_spi_handle_dma(struct pch_spi_data =
*data, int *bpw)
>  		return;
>  	}
>  	dma_sync_sg_for_device(&data->host->dev, sg, num, DMA_TO_DEVICE);
> -	desc_tx->callback =3D NULL;
> -	desc_tx->callback_param =3D data;
> +	dmaengine_desc_set_callback(desc_tx, NULL, NULL, data);

This is a preexisting issue, so nothing to do with your patch, but I'm
not sure I understand the purpose of setting callback_param to !=3D NULL
when callback =3D=3D NULL. If neither callback nor callback_result are non-
NULL, then callback_params seems to be completely unused.

Anyway, none of the above are blockers, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--unoy3twvi5fxh2md
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrrMd8ACgkQ3SOs138+
s6EYaw//UO6AHvJ+t7TrjGZA+UYLQHdy+GHHN92wIwin6E29tqokUx9FRtT1mxc+
QfpP+rIE6hr579pxyCp6mS/ocEtwyvXQ0NiQxu2KDDs4YHYh9OK6JhUHGwGtYn6r
P3Dhqwabt4yfcKDEwG00Xps8UwXK/mLJYsm5TPXnS0FiFetZeNGK0KORgB977tWk
4CEOjQOIvgKJIDgW0ornKkP5p3u5Nf+8qI6OuOkCkPmuK4Ed9DTwjHxzdx3M1Enf
6X9C8OMo5MWcn5Q4WWN4YwG/S+yYPkhz8wZOotBTvMcl1xLiz8Uc9Vn5AiDcH6hG
W8z1TXNaLhzBAE+Ov9viiL/wkD5sunZNnYLjkBsyxY1Lt1LNkOgvJGnKrf7u7Nn1
9NMMQEdb07ppFaphiVGbHRFmKFfVimrXPKBIbjoDfyFF7DscLjhXzl4ICwv4RaMR
k9vh0aZ4Efy2fOA4v61ePYYIY6sNjy+jyQp5YwXrToTkJ6UfnPyF9xeIBHJNM91Y
WqO7StU+DRjiP3FKmfYMt6rLJFe/SgGJ35vOl2fgMHD2NNRGafYIWsC0jHpteo8s
mA1Rd9Sj+E1fQqzIi+8a9grsUfq4aodwBgy3MNZhqs+6JG6BadJmTD+r/POrX7BJ
9MPiWfYSOGkvf4dm2lHIJ2nQVZZcUtLrj/Hm6DakNESIle457lU=
=AUYN
-----END PGP SIGNATURE-----

--unoy3twvi5fxh2md--
