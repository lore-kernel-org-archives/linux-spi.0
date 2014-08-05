From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 2/8] spi: sun4i: add DMA support
Date: Tue, 5 Aug 2014 22:23:54 +0200
Message-ID: <20140805202354.GA2019@lukather>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
 <1407183002-29420-3-git-send-email-emilio@elopez.com.ar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
To: Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407183002-29420-3-git-send-email-emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 04, 2014 at 05:09:56PM -0300, Emilio L=F3pez wrote:
> +	if (sun4i_spi_can_dma(master, spi, tfr)) {
> +		dev_dbg(&sspi->master->dev, "Using DMA mode for transfer\n");
> +
> +		if (sspi->tx_buf) {
> +			desc_tx =3D dmaengine_prep_slave_sg(sspi->tx_dma_chan,
> +					tfr->tx_sg.sgl, tfr->tx_sg.nents,
> +					DMA_TO_DEVICE,
> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +			if (!desc_tx) {
> +				dev_err(&sspi->master->dev,
> +					"Couldn't prepare dma slave\n");
> +				return -EIO;
> +			}
> +
> +			dmaengine_submit(desc_tx);
> +		}
> +
> +		if (sspi->rx_buf) {
> +			desc_rx =3D dmaengine_prep_slave_sg(sspi->rx_dma_chan,
> +					tfr->rx_sg.sgl, tfr->rx_sg.nents,
> +					DMA_FROM_DEVICE,
> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +			if (!desc_rx) {
> +				dev_err(&sspi->master->dev,
> +					"Couldn't prepare dma slave\n");
> +				return -EIO;
> +			}
> +
> +			dmaengine_submit(desc_rx);
> +		}
> +
> +		/* Enable DMA requests */
> +		reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
> +		sun4i_spi_write(sspi, SUN4I_CTL_REG,
> +				reg | SUN4I_CTL_DMAMC_DEDICATED);
> +		sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG,
> +				SUN4I_DMA_CTL_TF_NOT_FULL |
> +				SUN4I_DMA_CTL_RF_READY);
> +
> +		dma_async_issue_pending(sspi->rx_dma_chan);
> +		dma_async_issue_pending(sspi->tx_dma_chan);

I guess the DMA levels setup and the issue pending calls could be
moved to the if statements above about wether the RX and TX buffers
are here or not.

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
> +		sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
> +	}
> +
>  	/* Start the transfer */
>  	reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
>  	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
> @@ -286,7 +359,12 @@ static int sun4i_spi_transfer_one(struct spi_master =
*master,
>  		goto out;
>  	}
> =20
> -	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> +	if (sun4i_spi_can_dma(master, spi, tfr) && desc_rx) {
> +		/* The receive transfer should be the last one to finish */
> +		dma_wait_for_async_tx(desc_rx);
> +	} else {
> +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> +	}
> =20
>  out:
>  	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
> @@ -351,6 +429,7 @@ static int sun4i_spi_runtime_suspend(struct device *d=
ev)
> =20
>  static int sun4i_spi_probe(struct platform_device *pdev)
>  {
> +	struct dma_slave_config dma_sconfig;
>  	struct spi_master *master;
>  	struct sun4i_spi *sspi;
>  	struct resource	*res;
> @@ -386,7 +465,10 @@ static int sun4i_spi_probe(struct platform_device *p=
dev)
>  		goto err_free_master;
>  	}
> =20
> +	init_completion(&sspi->done);
>  	sspi->master =3D master;
> +	master->can_dma =3D sun4i_spi_can_dma;
> +	master->prepare_message =3D sun4i_spi_prepare_message;
>  	master->set_cs =3D sun4i_spi_set_cs;
>  	master->transfer_one =3D sun4i_spi_transfer_one;
>  	master->num_chipselect =3D 4;
> @@ -409,7 +491,45 @@ static int sun4i_spi_probe(struct platform_device *p=
dev)
>  		goto err_free_master;
>  	}
> =20
> -	init_completion(&sspi->done);
> +	sspi->tx_dma_chan =3D dma_request_slave_channel_reason(&pdev->dev, "tx"=
);
> +	if (IS_ERR(sspi->tx_dma_chan)) {
> +		dev_err(&pdev->dev, "Unable to acquire DMA channel TX\n");
> +		ret =3D PTR_ERR(sspi->tx_dma_chan);
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
> +	ret =3D dmaengine_slave_config(sspi->tx_dma_chan, &dma_sconfig);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to configure TX DMA slave\n");
> +		goto err_tx_dma_release;
> +	}
> +
> +	sspi->rx_dma_chan =3D dma_request_slave_channel_reason(&pdev->dev, "rx"=
);
> +	if (IS_ERR(sspi->rx_dma_chan)) {
> +		dev_err(&pdev->dev, "Unable to acquire DMA channel RX\n");
> +		ret =3D PTR_ERR(sspi->rx_dma_chan);
> +		goto err_tx_dma_release;
> +	}
> +
> +	dma_sconfig.direction =3D DMA_DEV_TO_MEM;
> +	dma_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dma_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dma_sconfig.src_addr =3D res->start + SUN4I_RXDATA_REG;
> +	dma_sconfig.src_maxburst =3D 1;
> +	dma_sconfig.dst_maxburst =3D 1;
> +
> +	ret =3D dmaengine_slave_config(sspi->rx_dma_chan, &dma_sconfig);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to configure RX DMA slave\n");
> +		goto err_rx_dma_release;
> +	}
> =20
>  	/*
>  	 * This wake-up/shutdown pattern is to be able to have the
> @@ -418,7 +538,7 @@ static int sun4i_spi_probe(struct platform_device *pd=
ev)
>  	ret =3D sun4i_spi_runtime_resume(&pdev->dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Couldn't resume the device\n");
> -		goto err_free_master;
> +		goto err_rx_dma_release;
>  	}
> =20
>  	pm_runtime_set_active(&pdev->dev);
> @@ -436,6 +556,10 @@ static int sun4i_spi_probe(struct platform_device *p=
dev)
>  err_pm_disable:
>  	pm_runtime_disable(&pdev->dev);
>  	sun4i_spi_runtime_suspend(&pdev->dev);
> +err_rx_dma_release:
> +	dma_release_channel(sspi->rx_dma_chan);
> +err_tx_dma_release:
> +	dma_release_channel(sspi->tx_dma_chan);
>  err_free_master:
>  	spi_master_put(master);
>  	return ret;
> @@ -443,8 +567,17 @@ err_free_master:
> =20
>  static int sun4i_spi_remove(struct platform_device *pdev)
>  {
> +	struct spi_master *master =3D platform_get_drvdata(pdev);
> +	struct sun4i_spi *sspi =3D spi_master_get_devdata(master);
> +
> +	if (pm_runtime_active(&pdev->dev))
> +		sun4i_spi_runtime_suspend(&pdev->dev);
> +

This doesn't really belong in this patch, please send a separate one.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT4T1aAAoJEBx+YmzsjxAgTD0P+gMu4PJaaW8NdbrN6Sl5/TWr
NVUaO9zeZ7AMK074HNh6C4+L13D8Q5IVU+CMaqVCMlVXx5U1/6Djtckd+0Mw1jiZ
7fFpOTOXAB2i7RK/m0EJZmBB1vLGln0kaFpnFSALw83ftC/h6UCZbO2eMo9aL632
J8GERcsxvM/zz78tafaegaXpy5+fEM4+3+MKbtcFm9wA91dkO36Qvs97w5vA87Dy
bQcIC+KsPlbRpg6loDtgFNCMpTaJI8NsWtOBY3zuTUrehAn0CYDnYeMOnBnm4BsT
rPno4hhXiJPM8oApadJBvgEQeMNWPmextCd/UNw8+PB59PrAe5vciH5d6JG2biTa
GMKGvrHPOoOKj1ejr49wSIUuCZ9jReZmnsbAq8YT3287IS3TO/6Sk/EFUyFlksFr
efjzSrm8AfBpXcU+rSaKhitkK8lXysTe93uk8zLekehKAVatCIHtW0gMKS7YOF6m
te4RbvKtDBsvge1L5wOoMciYzOiYVY7hcdHTYcwsTnXn9sL6942tvg6LobCA66bN
t9G2+Cm4wXPQXRWMICbjWfLjEb/Q1BiDpJv2rmC6pK78zGyaKa0bCh+HxgLgTDxG
CarQ95ufNmYOjXmBFjGr9xqqA+nl7Jb3BFuUw89DA48PQN9s99LtJKlofl2ZiqDL
YUhbvUa+XGMSM8LRewey
=iyqx
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
