From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4] ARM: sun4i: spi: Allow transfers larger than FIFO size
Date: Mon, 31 Mar 2014 12:45:22 +0200
Message-ID: <20140331104522.GD26751@lukather>
References: <20140322175053.GU27873@lukather>
 <1395842392-31491-1-git-send-email-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395842392-31491-1-git-send-email-mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for respinning this patch.

On Wed, Mar 26, 2014 at 08:59:52AM -0500, Alexandru Gagniuc wrote:
> SPI transfers were limited to one FIFO depth, which is 64 bytes.
> This was an artificial limitation, however, as the hardware can handle
> much larger bursts. To accommodate this, we enable the interrupt when
> the Rx FIFO is 3/4 full, and drain the FIFO within the interrupt
> handler. The 3/4 ratio was chosen arbitrarily, with the intention to
> reduce the potential number of interrupts.
>=20
> Since the SUN4I_CTL_TP bit is set, the hardware will pause
> transmission whenever the FIFO is full, so there is no risk of losing
> data if we can't service the interrupt in time.
>=20
> For the Tx side, enable and use the Tx FIFO 3/4 empty interrupt to
> replenish the FIFO on large SPI bursts. This requires more care in
> when the interrupt is left enabled, as this interrupt will continually
> trigger when the FIFO is less than 1/4 full, even though we
> acknowledge it.
>=20
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-sun4i.c | 72 +++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 65 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 3f82705..1557528 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -47,6 +47,8 @@
>  #define SUN4I_CTL_TP				BIT(18)
> =20
>  #define SUN4I_INT_CTL_REG		0x0c
> +#define SUN4I_INT_CTL_RF_F34			BIT(4)
> +#define SUN4I_INT_CTL_TF_E34			BIT(12)
>  #define SUN4I_INT_CTL_TC			BIT(16)
> =20
>  #define SUN4I_INT_STA_REG		0x10
> @@ -62,11 +64,14 @@
>  #define SUN4I_CLK_CTL_CDR1(div)			(((div) & SUN4I_CLK_CTL_CDR1_MASK) << =
8)
>  #define SUN4I_CLK_CTL_DRS			BIT(12)
> =20
> +#define SUN4I_MAX_XFER_SIZE			0xffffff
> +
>  #define SUN4I_BURST_CNT_REG		0x20
> -#define SUN4I_BURST_CNT(cnt)			((cnt) & 0xffffff)
> +#define SUN4I_BURST_CNT(cnt)			((cnt) & SUN4I_MAX_XFER_SIZE)
> =20
>  #define SUN4I_XMIT_CNT_REG		0x24
> -#define SUN4I_XMIT_CNT(cnt)			((cnt) & 0xffffff)
> +#define SUN4I_XMIT_CNT(cnt)			((cnt) & SUN4I_MAX_XFER_SIZE)
> +
> =20
>  #define SUN4I_FIFO_STA_REG		0x28
>  #define SUN4I_FIFO_STA_RF_CNT_MASK		0x7f
> @@ -97,6 +102,28 @@ static inline void sun4i_spi_write(struct sun4i_spi *=
sspi, u32 reg, u32 value)
>  	writel(value, sspi->base_addr + reg);
>  }
> =20
> +static inline u32 sun4i_spi_get_tx_fifo_count(struct sun4i_spi *sspi)
> +{
> +	u32 reg;
> +	reg =3D sun4i_spi_read(sspi, SUN4I_FIFO_STA_REG);

You seem to assign the reg variables when declaring it in other part
of your code. It would be great to be consistent.

> +	reg >>=3D SUN4I_FIFO_STA_TF_CNT_BITS;
> +	return reg & SUN4I_FIFO_STA_TF_CNT_MASK;
> +}
> +
> +static inline void sun4i_spi_enable_interrupt(struct sun4i_spi *sspi, u3=
2 mask)
> +{
> +	u32 reg =3D sun4i_spi_read(sspi, SUN4I_INT_CTL_REG);
> +	reg |=3D mask;
> +	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
> +}
> +
> +static inline void sun4i_spi_disable_interrupt(struct sun4i_spi *sspi, u=
32 mask)
> +{
> +	u32 reg =3D sun4i_spi_read(sspi, SUN4I_INT_CTL_REG);
> +	reg &=3D ~mask;
> +	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
> +}
> +
>  static inline void sun4i_spi_drain_fifo(struct sun4i_spi *sspi, int len)
>  {
>  	u32 reg, cnt;
> @@ -119,8 +146,15 @@ static inline void sun4i_spi_drain_fifo(struct sun4i=
_spi *sspi, int len)
> =20
>  static inline void sun4i_spi_fill_fifo(struct sun4i_spi *sspi, int len)
>  {
> +	u32 cnt;
>  	u8 byte;
> =20
> +	/* See how much data we can fit */
> +	cnt =3D SUN4I_FIFO_DEPTH - sun4i_spi_get_tx_fifo_count(sspi);
> +
> +	if (len > cnt)
> +		len =3D cnt;
> +
>  	if (len > sspi->len)
>  		len =3D sspi->len;

You probably want to use min3 here

> @@ -175,8 +209,8 @@ static int sun4i_spi_transfer_one(struct spi_master *=
master,
>  	int ret =3D 0;
>  	u32 reg;
> =20
> -	/* We don't support transfer larger than the FIFO */
> -	if (tfr->len > SUN4I_FIFO_DEPTH)
> +	/* This is the maximum SPI burst size supported by the hardware */
> +	if (tfr->len > SUN4I_MAX_XFER_SIZE)
>  		return -EINVAL;
> =20
>  	reinit_completion(&sspi->done);
> @@ -274,7 +308,10 @@ static int sun4i_spi_transfer_one(struct spi_master =
*master,
>  	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
> =20
>  	/* Enable the interrupts */
> -	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
> +	sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TC | SUN4I_INT_CTL_RF_F3=
4);
> +	/* Only enable Tx FIFO interrupt if we really need it */
> +	if (tx_len > SUN4I_FIFO_DEPTH)
> +		sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TF_E34);
> =20
>  	/* Start the transfer */
>  	reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
> @@ -287,8 +324,6 @@ static int sun4i_spi_transfer_one(struct spi_master *=
master,
>  		goto out;
>  	}
> =20
> -	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> -
>  out:
>  	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
> =20
> @@ -303,10 +338,33 @@ static irqreturn_t sun4i_spi_handler(int irq, void =
*dev_id)
>  	/* Transfer complete */
>  	if (status & SUN4I_INT_CTL_TC) {
>  		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TC);
> +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
>  		complete(&sspi->done);
>  		return IRQ_HANDLED;
>  	}
> =20
> +	/* Receive FIFO 3/4 full */
> +	if (status & SUN4I_INT_CTL_RF_F34) {
> +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> +		/* Only clear the interrupt _after_ draining the FIFO */
> +		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_RF_F34);
> +		return IRQ_HANDLED;
> +	}
> +
> +	/* Transmit FIFO 3/4 empty */
> +	if (status & SUN4I_INT_CTL_TF_E34) {
> +		sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
> +
> +		if(!sspi->len)

  		if (!sspi->len)

> +			/* nothing left to transmit */
> +			sun4i_spi_disable_interrupt(sspi, SUN4I_INT_CTL_TF_E34);
> +
> +		/* Only clear the interrupt _after_ re-seeding the FIFO */
> +		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TF_E34);
> +
> +		return IRQ_HANDLED;
> +	}
> +
>  	return IRQ_NONE;
>  }
> =20
> --=20
> 1.8.5.3
>=20

Once these minor issues fixed, you can add my
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks!

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTOUdCAAoJEBx+YmzsjxAgQ/MQAIq4I97b7jkHeXa1dVjQpqX1
E7fZAPGCStBVzd0TTmdjmb/c27PmE3VInXouV5DVJTG8GYT+85xftPcvgze1YdsB
xoUVYeK+Ww2Dvt+eoUfsw/u4detWTAybnTNEX2QAM6xv1VzkyuzwjpjXIM3YqQfS
AnImreSFVrpAZB00Ww7TnjnvNk2QhoV4zrC133VLZUXArAmnJPSUmAs4j0+57p8U
n+V/1aEVhm1Cja/h3ILHYtH773SnzOGHjim5tM6GUPsJ161R3fyg09gHxnt/TzHB
JJ1LxS1adn6zDLHkR72cVDrPfxJx9zQRe1HcHpz+CMiZApDemTqvfkI0CF9ZsfGQ
M6gImrNalcQpYWyivCtEhQsi/xETK3GAiDWbnkc3PJ4tf2u/HkFpY9N9leMOXVXx
qM6Dz4xZBetI+IXaKa+FNDve8+oIBMqCGobclpof0i+5vNGUFhF/agrUpwVGjlFx
2Wi09u0IfYeh+OPGio7BeEXk4r/MdGnJpyuo4knKgYBQzFP5u1TnZbO31Vl9ZHit
zztSS80NMiHjIiPmld+RqhpND4JfNtlM6mjJFYCS/ZFxRc4gqjAZKZmnM13SGgd7
8dh6mdGoRiG58ySMVXEbILIEl2X7bgFtvKaDPBflz2bw92aMeE4oSeC2dXvUGM/3
pC4LpyQcnSbuHMW2hlBI
=Tb3l
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
