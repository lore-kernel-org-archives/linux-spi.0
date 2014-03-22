From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 1/1] ARM: sun4i: spi: Allow transfers
 larger than FIFO size
Date: Sat, 22 Mar 2014 18:50:53 +0100
Message-ID: <20140322175053.GU27873@lukather>
References: <1395261670-19386-1-git-send-email-mr.nuke.me@gmail.com>
 <1395264538-29158-1-git-send-email-mr.nuke.me@gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T3X/gqwmxfK0WLE8"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB544W6MQKGQEUEBDCIA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395264538-29158-1-git-send-email-mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--T3X/gqwmxfK0WLE8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



On Wed, Mar 19, 2014 at 04:28:57PM -0500, Alexandru Gagniuc wrote:
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
>  drivers/spi/spi-sun4i.c | 67 +++++++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 62 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 3f82705..9dd55d3 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -47,6 +47,8 @@
>  #define SUN4I_CTL_TP				BIT(18)
>=20
>  #define SUN4I_INT_CTL_REG		0x0c
> +#define SUN4I_INT_CTL_RF_F34			BIT(4)
> +#define SUN4I_INT_CTL_TF_E34			BIT(12)
>  #define SUN4I_INT_CTL_TC			BIT(16)
>=20
>  #define SUN4I_INT_STA_REG		0x10
> @@ -68,6 +70,8 @@
>  #define SUN4I_XMIT_CNT_REG		0x24
>  #define SUN4I_XMIT_CNT(cnt)			((cnt) & 0xffffff)
>=20
> +#define SUN4I_MAX_XFER_SIZE			0xffffff
> +

I'd rather define the mask only once here, and reuse it in the macro
just above.

>  #define SUN4I_FIFO_STA_REG		0x28
>  #define SUN4I_FIFO_STA_RF_CNT_MASK		0x7f
>  #define SUN4I_FIFO_STA_RF_CNT_BITS		0
> @@ -97,6 +101,28 @@ static inline void sun4i_spi_write(struct sun4i_spi *=
sspi, u32 reg, u32 value)
>  	writel(value, sspi->base_addr + reg);
>  }
>=20
> +static inline u32 sun4i_spi_get_tx_fifo_count(struct sun4i_spi *sspi)
> +{
> +	u32 reg;
> +	reg =3D sun4i_spi_read(sspi, SUN4I_FIFO_STA_REG);
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
> @@ -119,8 +145,15 @@ static inline void sun4i_spi_drain_fifo(struct sun4i=
_spi *sspi, int len)
>=20
>  static inline void sun4i_spi_fill_fifo(struct sun4i_spi *sspi, int len)
>  {
> +	u32 cnt;
>  	u8 byte;
>=20
> +	/* See how much data we can fit */
> +	cnt =3D SUN4I_FIFO_DEPTH - sun4i_spi_get_tx_fifo_count(sspi);
> +
> +	if (len > cnt)
> +		len =3D cnt;
> +
>  	if (len > sspi->len)
>  		len =3D sspi->len;
>=20
> @@ -175,8 +208,7 @@ static int sun4i_spi_transfer_one(struct spi_master *=
master,
>  	int ret =3D 0;
>  	u32 reg;
>=20
> -	/* We don't support transfer larger than the FIFO */
> -	if (tfr->len > SUN4I_FIFO_DEPTH)
> +	if (tfr->len > SUN4I_MAX_XFER_SIZE)

A comment here about why you're doing so would be nice

>  		return -EINVAL;
>=20
>  	reinit_completion(&sspi->done);
> @@ -274,7 +306,11 @@ static int sun4i_spi_transfer_one(struct spi_master =
*master,
>  	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
>=20
>  	/* Enable the interrupts */
> -	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
> +	reg =3D SUN4I_INT_CTL_TC | SUN4I_INT_CTL_RF_F34;
> +	/* Only enable Tx FIFO interrupt if we really need it */
> +	if (tx_len > SUN4I_FIFO_DEPTH)
> +		reg |=3D SUN4I_INT_CTL_TF_E34;
> +	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);

You probably can use the _enable_interrupt function you just defined here :)

>=20
>  	/* Start the transfer */
>  	reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
> @@ -287,8 +323,6 @@ static int sun4i_spi_transfer_one(struct spi_master *=
master,
>  		goto out;
>  	}
>=20
> -	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> -
>  out:
>  	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
>=20
> @@ -303,10 +337,33 @@ static irqreturn_t sun4i_spi_handler(int irq, void =
*dev_id)
>  	/* Transfer complete */
>  	if (status & SUN4I_INT_CTL_TC) {
>  		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TC);
> +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
>  		complete(&sspi->done);
>  		return IRQ_HANDLED;
>  	}
>=20
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
>=20
> --
> 1.8.5.3
>=20

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--T3X/gqwmxfK0WLE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTLc19AAoJEBx+YmzsjxAgbmcP/jsM97vX3gFaqSdwJ05phdU3
z4AWgm8JXr4GBgDUnqTnSwPNZ6hkbu99SznyMCGZdMM0+EpJJ/DJQa8V43ztMEPv
q5VeHMi4PqgoYgzRwReQPXwRxlprZ2xwHKRyZbxSG9YrovblBZ5DYtzLbGF15vXj
YJLaEGTWm8f276+RGkUuXO98t/S6LNWMvaJcwcNyzp3abyCGfQ2igaOgpMr6p7By
w6lNwvRHA/3+2pPmw1YPe+wNzRbVcsW18e7Xmhv15ODFmKl8igByMFzkctO+uzpV
k8Y695ynwpZUZjTN8ijE1cUnAXvAQAmaxnnu2QChVZlN2QgTsX38Akb9vb6Im9Qw
LzhFDnMVxHkkng888KvdV79v6BkXnGwfUKdnffY5Lv0Mbgz9kwo/wnZq3r8E9fgT
aAfuv6MU+mtFb0RjF4rw4AzESC2NU5SJqayD7b3877HwsWLwrl/F3lcD3aqtNFQp
3w4QMBjbV3fOe2baY7aGgP9zsrHxbChNd7ApXnIGm4VuTPKuqcT1d5WDvj5uclN2
y5JkFIduA0W0/+kV9iIolepJ1FsdTYFccuQNGW6gsN+P9uw02fXtwj07a+89VtU4
YM2PavchvuT1ceLM5kECIQ4wMlORf3VSJZRlOquqfB9rltrd+Nm4LeaK72lc3SS8
lL/E5WHrJGwLA4xTSeDk
=Xm5V
-----END PGP SIGNATURE-----

--T3X/gqwmxfK0WLE8--
