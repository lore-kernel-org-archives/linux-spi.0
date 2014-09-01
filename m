From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-imx: use threaded interrupt
Date: Mon, 1 Sep 2014 15:57:57 +0100
Message-ID: <20140901145757.GZ29327@sirena.org.uk>
References: <1409582106-2845-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oUI2l+Vq7ILP1REU"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409582106-2845-1-git-send-email-l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oUI2l+Vq7ILP1REU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2014 at 04:35:06PM +0200, Lucas Stach wrote:
> From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>=20
> The i.MX SPI driver fills/flushes the FIFOs in interrupt context. With
> longer SPI messages this introduces big latencies in the system. Using
> a threaded interrupt avoids this issue.

Adding Marek.  A few things here:

> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 5daff2054ae4..5e40801e1c52 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -672,6 +672,15 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_id)
>  {
>  	struct spi_imx_data *spi_imx =3D dev_id;
> =20
> +	spi_imx->devtype_data->intctrl(spi_imx, 0);
> +
> +	return IRQ_WAKE_THREAD;
> +}

This means we unconditionally defer to the thread which means that we
will add latency in any case where we've not got any more data to place
in the FIFO.  That doesn't seem great.  I'd expect the driver to only
defer in cases where it was going to call one of the FIFO handling
functions (ideally it'd be possible to do some sort of copybreak based
on the amount of data to fill but I'm not sure it's worth the effort of
trying to pick numbers for that) and still complete transfers in hardirq
context in cases where that's all that needs doing.

I'm also not sure why the interrupt needs masking here - the driver
doesn't support shared interrupts so doesn't this just duplicate what
the interrupt subsystem is doing when it implements threading?  As
things stand it looks like the hard interrupt handler may as well just
be omitted.

> @@ -883,8 +892,8 @@ static int spi_imx_probe(struct platform_device *pdev)
>  		goto out_master_put;
>  	}
> =20
> -	ret =3D devm_request_irq(&pdev->dev, spi_imx->irq, spi_imx_isr, 0,
> -			       dev_name(&pdev->dev), spi_imx);
> +	ret =3D request_threaded_irq(spi_imx->irq, spi_imx_isr,
> +			spi_imx_isr_thread, 0, dev_name(&pdev->dev), spi_imx);
>  	if (ret) {
>  		dev_err(&pdev->dev, "can't get irq%d: %d\n", spi_imx->irq, ret);
>  		goto out_master_put;

You've removed a devm_ but not added any free_irq() calls.  There's a
devm_request_threaded_irq() so you could just use that?

--oUI2l+Vq7ILP1REU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBIlyAAoJELSic+t+oim998gQAIsT9DXCQvvfcO6yRWdRoCfg
vGTIp6n8dgAi2fjcl8Xoq+xVPzAzRVJ/HvzKW02d2ht9jDdX/G/xy1HzBIGLpP/m
ej+ts5ioyw8FWHjS1EylBTsC0+pa1/wFfIdOjCrraWM5LeZ4h7XF0tCbN+UzyXgs
ZSWTt+IzdQtZ9iEqWj3qh6iLw2p1LiwC6TRQi3faM4rBm+EJj7aNcchW7QqTGlse
ijAVXLqK9v1ZfT57sFfcHSJ4ckx8YG+8tT7CA0dGCxbrzIv0CIQreYmM8Xm+5KaV
rizltS3DOrLhJHIyfew2Nnge/xX8Wm4ko3/VnXAfn79A+GwuNNks2eKM6aHD5hNn
0WgVwejZy6dCJeF7/fLq3dhta5QHgA+aaBwCo0Dgru7HXkmhxAKAzbE1Mk0alSn1
MV2SLG3nMc6aGNS+XZPfRtte/H3HjCelQ/WIZz0stihMVKEIpzOdsWXXX3pvmoOs
JSDrWia2zph5AwMOj0PCiUlamqxBySK4gbWqEZToLch2/V27o/YHwwv/S6FXxPtd
m3tosUTyX9qrFnwiqAXITFWtx0wgkx3PZ+Qo3yGmGI8WE4ZTEhQTaoWPWFhLjwrt
9z8WSFKcVJO6AuxNAH7Qmv8sDRCnGA7cnrGLJ/PF49Bx5FDs2JZgmO5oGCnVakn+
S+Rm2E1yTo6HazPVq74m
=8qUJ
-----END PGP SIGNATURE-----

--oUI2l+Vq7ILP1REU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
