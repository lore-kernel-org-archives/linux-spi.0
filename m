From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/2] v1 ARM: sun4i: spi: Allow Tx transfers
 larger than FIFO size
Date: Wed, 19 Mar 2014 18:02:51 +0100
Message-ID: <20140319170251.GK27873@lukather>
References: <1521319.la1khlz7Zz@nukelap.gtech>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ag0ALTx5bNxCf4La"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBQM4U6MQKGQEFMPCCXA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1521319.la1khlz7Zz-joXr/IIKmbNbKQuZ0yLBSw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--Ag0ALTx5bNxCf4La
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2014 at 05:04:36PM -0500, Alexandru Gagniuc wrote:
> Enable and use the Tx FIFO 3/4 interrupt to replenish the FIFO on
> large SPI bursts. This requires more care in when the interrupt is
> left enabled, as this interrupt will continually trigger when the FIFO
> is less than 1/4 full, even though we acknowledge it.
>=20
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-sun4i.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 09d4b54..174736c 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -48,6 +48,7 @@
> =20
>  #define SUN4I_INT_CTL_REG		0x0c
>  #define SUN4I_INT_CTL_RF_F34			BIT(4)
> +#define SUN4I_INT_CTL_TF_E34			BIT(12)
>  #define SUN4I_INT_CTL_TC			BIT(16)
> =20
>  #define SUN4I_INT_STA_REG		0x10
> @@ -100,6 +101,21 @@ static inline void sun4i_spi_write(struct sun4i_spi=
=20
> *sspi, u32 reg, u32 value)
>  	writel(value, sspi->base_addr + reg);
>  }
> =20
> +static inline int sun4i_spi_get_tx_fifo_count(struct sun4i_spi *sspi)

return an u32 here

> +{
> +	u32 reg;
> +	reg =3D sun4i_spi_read(sspi, SUN4I_FIFO_STA_REG);
> +	reg >>=3D SUN4I_FIFO_STA_TF_CNT_BITS;
> +	return reg & SUN4I_FIFO_STA_TF_CNT_MASK;
> +}
> +
> +static inline void sun4i_spi_disable_interrupt(struct sun4i_spi *sspi, u=
32=20
> intm)

Please rename the variable "mask" here, and add a matching
enable_interrupt function for consistency.

> +{
> +	u32 reg =3D sun4i_spi_read(sspi, SUN4I_INT_CTL_REG);
> +	reg &=3D ~intm;
> +	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
> +}
> +
>  static inline void sun4i_spi_drain_fifo(struct sun4i_spi *sspi, int len)
>  {
>  	u32 reg, cnt;
> @@ -181,10 +197,6 @@ static int sun4i_spi_transfer_one(struct spi_master=
=20
> *master,
>  	if (tfr->len > SUN4I_MAX_XFER_SIZE)
>  		return -EINVAL;
> =20
> -	/* We only support read transfers larger than the FIFO */
> -	if ((tfr->len > SUN4I_FIFO_DEPTH) && tfr->tx_buf)
> -		return -EINVAL;
> -
>  	reinit_completion(&sspi->done);
>  	sspi->tx_buf =3D tfr->tx_buf;
>  	sspi->rx_buf =3D tfr->rx_buf;
> @@ -280,8 +292,11 @@ static int sun4i_spi_transfer_one(struct spi_master=
=20
> *master,
>  	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
> =20
>  	/* Enable the interrupts */
> -	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC |
> -						 SUN4I_INT_CTL_RF_F34);
> +	reg =3D SUN4I_INT_CTL_TC | SUN4I_INT_CTL_RF_F34;
> +	/* Only enable Tx FIFO interrupt if we really need it */
> +	if (tx_len > SUN4I_FIFO_DEPTH)
> +		reg |=3D SUN4I_INT_CTL_TF_E34;
> +	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);

I'd be much dumber than that. Why don't you just enable both
interrupts all the time if we need larger transfers ?


>  	/* Start the transfer */
>  	reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
> @@ -306,6 +321,7 @@ static irqreturn_t sun4i_spi_handler(int irq, void=20
> *dev_id)
>  {
>  	struct sun4i_spi *sspi =3D dev_id;
>  	u32 status =3D sun4i_spi_read(sspi, SUN4I_INT_STA_REG);
> +	u32 cnt;
> =20
>  	/* Transfer complete */
>  	if (status & SUN4I_INT_CTL_TC) {
> @@ -323,6 +339,22 @@ static irqreturn_t sun4i_spi_handler(int irq, void=
=20
> *dev_id)
>  		return IRQ_HANDLED;
>  	}
> =20
> +	/* Transmit FIFO 3/4 empty */
> +	if (status & SUN4I_INT_CTL_TF_E34) {
> +		/* See how much data can fit */
> +		cnt =3D SUN4I_FIFO_DEPTH - sun4i_spi_get_tx_fifo_count(sspi);
> +		sun4i_spi_fill_fifo(sspi, cnt);

Making sure that you don't write to much data should be part of
_fill_fifo

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Ag0ALTx5bNxCf4La
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTKc26AAoJEBx+YmzsjxAgpVUQAJTjNEP8VQ1njqFoWEKxqmug
2TqH6AEkbpiv0Oc+g2uFelt/D4r3EzgxUsvdJG28xZ5uBbfwp7lVGwb1r11IJwtc
G35O2RAOZY/JFeVo2w2GEE+Aw2oyB+f2vSIQqU//o54XQjUdmpHUEDdhKOylJRdQ
tZW7v7OClqhvl+S5qqhS9sp7qIg0T4Z/AjkArxfVJbw4OY/T/VoOM7G8hH07XWS8
XJ5p1QZ3r+ZXnK8hUlajkoiUKoeuQwrNK/4lbIrCQ9Dj77g+T9bNqD/xMW+M7Cgn
Ltp7ODMoM+6hs697dIrx7+ODigoJlhTee6FGhOh+KmKO4mZKlbVFUD43pYr+XksV
gxS0RSROmNZ60j/g+2zeXGpFrgDghO0W7PWCLkQ/peVrJl9PK2Mm3icv8xh3tRAt
PGfD6XHMZAlZFTJHPvKS/kJZfFB4PLXo3wZnkz2z38IiFCVIgJg/7NcRmM2n6Igd
IIGxKB2Qa4X+W1Z4p0dhqX/BPzpRVTtLI8MiDGembUBlIPOVLHhUVv2vMwlK9ckB
DtYremn24w+ZBAzC6LAgOVFQzhgQif4pYMrQ7s5raxT8VYClnqOT1WtZCsK2Qein
5/2PBKQCHfG1K1sXtuIGa2E+m9HvE7Ol6GqfRludVPm8kpzI2y1Fo3W98qitxbcN
f6Ns2d121QpouCfsoTlb
=9RjX
-----END PGP SIGNATURE-----

--Ag0ALTx5bNxCf4La--
