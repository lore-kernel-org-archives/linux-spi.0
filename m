From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: add driver for STM32 SPI controller
Date: Wed, 21 Jun 2017 16:13:00 +0100
Message-ID: <20170621151300.s74lbymyisvde2zo@sirena.org.uk>
References: <1498055526-6918-1-git-send-email-amelie.delaunay@st.com>
 <1498055526-6918-3-git-send-email-amelie.delaunay@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pu757pfxejkkr2dv"
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498055526-6918-3-git-send-email-amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--pu757pfxejkkr2dv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2017 at 04:32:06PM +0200, Amelie Delaunay wrote:

A few minor stylistic things but overall this looks really nice, please
send followup patches fixing these style things.

> +	/* Determine the first power of 2 greater than or equal to div */
> +	mbrdiv = (div & (div - 1)) ? fls(div) : fls(div) - 1;

Please write normal conditional statements, it makes things much easier
to read.

> +static bool stm32_spi_can_dma(struct spi_master *master,
> +			      struct spi_device *spi_dev,
> +			      struct spi_transfer *transfer)
> +{
> +	struct stm32_spi *spi = spi_master_get_devdata(master);
> +
> +	dev_dbg(spi->dev, "%s: %s\n", __func__,
> +		(!!(transfer->len > spi->fifo_size)) ? "true" : "false");
> +
> +	return !!(transfer->len > spi->fifo_size);

This !! is redundant, you're converting a boolean value into a boolean
value.

> +	buswidth = (spi->cur_bpw <= 8) ? DMA_SLAVE_BUSWIDTH_1_BYTE :
> +		   (spi->cur_bpw <= 16) ? DMA_SLAVE_BUSWIDTH_2_BYTES :
> +		   DMA_SLAVE_BUSWIDTH_4_BYTES;
> +
> +	/* Valid for DMA Half or Full Fifo threshold */
> +	maxburst = (spi->cur_fthlv == 2) ? 1 : spi->cur_fthlv;

Again, please use normal conditional statements - people have to read
things.

> +static int stm32_spi_suspend(struct device *dev)
> +{
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	struct stm32_spi *spi = spi_master_get_devdata(master);
> +	int ret;
> +
> +	ret = spi_master_suspend(master);
> +	if (ret)
> +		return ret;
> +
> +	clk_disable_unprepare(spi->clk);

It'd be good to also have the clock disabled by runtime PM, that will
save a little more power.  There's support for enabling and disabling
the device in the core so it should just be adding callbacks.  Not
essential though.

--pu757pfxejkkr2dv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllKjPsACgkQJNaLcl1U
h9CThgf/UdEv1dJpadMX6f7mFIWstIkH/wJwRbCTqlz+mmsb9FJfSUo1Pm0hwKFa
1qfHz21uYEtx5/3R41Pd9QC0rH1irKb3wwEVswReL1cy1CeKHPnKYZ13NnabD3oe
fqf7/lLU0SEhZ3O7RwLA4ApZmuKgCj1e2PzLQf6AZcwv6T+wo/1qNgEVPjOL/Ou/
5ZAsm5uRdRWA3HLKQ4FHm2/pJrzOdpY9sBJdOjyD6KwRrGvzMq5CN08g+kTK8pv1
y94j2gTsVZYX8/XnbBO8P48TFDNlLufln67lcx7sDz1NO29tbjtJQ4o9Tvxbypcg
e1b5E4YIdOtO3ok+Mem0DgBDlI71vw==
=nU2U
-----END PGP SIGNATURE-----

--pu757pfxejkkr2dv--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
