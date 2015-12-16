From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4] spi: dts: sun4i: Add support for wait time between
 word transmissions
Date: Wed, 16 Dec 2015 11:39:27 +0100
Message-ID: <20151216103927.GS19456@lukather>
References: <1450080676-6704-1-git-send-email-mweseloh42@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rG09A39trvEtf3rB"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1450080676-6704-1-git-send-email-mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rG09A39trvEtf3rB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 14, 2015 at 09:11:14AM +0100, Marcus Weseloh wrote:
> Adds a new property "spi-word-wait-ns" to the spi-bus binding that allows
> SPI slave devices to set a wait time between the transmission of words.
> Modifies the spi_device struct and slave device probing to read and store
> the new property.
>=20
> Also modifies the sun4i SPI master driver to make use of the new property.
> This specific SPI controller needs 3 clock cycles to set up the delay,
> which makes the minimum non-zero wait time on this hardware 4 clock cycle=
s.
>=20
> Signed-off-by: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

It looks mostly fine, however, please try to make only one thing in
one patch.

In this case, it would mean having one patch to add the DT property
and support in the SPI core in a first one, and then add support for
it in your driver.

I also have a minor comment below....

> ---
> Changes from v1:
>  * renamed the property for more clarity
>  * wait time is set in nanoseconds instead of number of clock cycles
>  * transparently handle the 3 setup clock cycles
>=20
> Changes from v2:
>  * fixed typo in comment
>  * moved parameter to spi-bus binding, dropping the vendor prefix
>  * changed commit summary and description to reflect the changes
>=20
> Changes from v3:
>  * remove reference to "hardware" in comments and description, as the wait
>    time could also be implemented in software
>  * read and set property value in spi core
>=20
> As I am now changing SPI core, the sun4i driver and the spi-bus binding, I
> should probably split the patch into smaller parts (spi core + binding,
> sun4i changes). I will do that as soon as you are satisfied with the actu=
al
> approach.
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt |  2 ++
>  drivers/spi/spi-sun4i.c                           | 23 +++++++++++++++++=
++++++
>  drivers/spi/spi.c                                 |  2 ++
>  include/linux/spi/spi.h                           |  2 ++
>  4 files changed, 29 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Document=
ation/devicetree/bindings/spi/spi-bus.txt
> index bbaa857..434d321 100644
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> @@ -61,6 +61,8 @@ contain the following properties.
>                        used for MOSI. Defaults to 1 if not present.
>  - spi-rx-bus-width - (optional) The bus width(number of data wires) that
>                        used for MISO. Defaults to 1 if not present.
> +- spi-word-wait-ns - (optional) Delay between transmission of words
> +                      in nanoseconds
> =20
>  Some SPI controllers and devices support Dual and Quad SPI transfer mode.
>  It allows data in the SPI system to be transferred in 2 wires(DUAL) or 4=
 wires(QUAD).
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index f60a6d6..c1a33dc 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/of.h>
> =20
>  #include <linux/spi/spi.h>
> =20
> @@ -84,6 +85,7 @@ struct sun4i_spi {
>  	const u8		*tx_buf;
>  	u8			*rx_buf;
>  	int			len;
> +	u32			word_wait_ns;
>  };
> =20
>  static inline u32 sun4i_spi_read(struct sun4i_spi *sspi, u32 reg)
> @@ -173,6 +175,8 @@ static int sun4i_spi_transfer_one(struct spi_master *=
master,
>  	unsigned int tx_len =3D 0;
>  	int ret =3D 0;
>  	u32 reg;
> +	int wait_clk =3D 0;
> +	int clk_ns =3D 0;
> =20
>  	/* We don't support transfer larger than the FIFO */
>  	if (tfr->len > SUN4I_FIFO_DEPTH)
> @@ -261,6 +265,25 @@ static int sun4i_spi_transfer_one(struct spi_master =
*master,
> =20
>  	sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);
> =20
> +	/*
> +	 * Setup wait time between words.
> +	 *
> +	 * Wait time is set in SPI_CLK cycles. The SPI hardware needs 3
> +	 * additional cycles to setup the wait counter, so the minimum delay
> +	 * time is 4 cycles.
> +	 */
> +	if (spi->word_wait_ns) {
> +		clk_ns =3D DIV_ROUND_UP(1000000000, tfr->speed_hz);
> +		wait_clk =3D DIV_ROUND_UP(spi->word_wait_ns, clk_ns) - 3;
> +		if (wait_clk < 1) {
> +			wait_clk =3D 1;
> +			dev_info(&spi->dev,
> +				 "using minimum of 4 word wait cycles (%uns)",
> +				 4 * clk_ns);

Logging it at the info loglevel seems a bit too high. debug seems more
appropriate.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--rG09A39trvEtf3rB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcT9fAAoJEBx+YmzsjxAgwZwP/3S1qBXDCQRfBp3PRfeNslTj
FOjnB027pf6sGjeXncx6BQlIJpQsABR6PtQnJr+PcJBXC2kuH9UX3I7XnMw0AoCT
PVzY8Jve7lG7LyP7N/5oDYzATu1jdbN5SWIv7+ZlNaBQU3pfKdZJsuE7EdFw0uFq
h4zfHFWHuMapS9oQghWMk83upiwcbK0eONFV/qnluzwseEK/dRlcUMJUP6x5Iwer
RxAxicuK3oGPbTsb8xePZoXk3pAGIZss0+TLk0pTWvVJXB0f0+0h4Hx0MxVuqt45
cuKenreIVJVBzV1rutYnhoqtf+oPUR0QXgQsuK0WQzuCcAtHkSsb3nYoezpMTeFW
3FqfGH+pJWwwZ1rfvaFVgHGqUCzl1usyFKJ0Oodgw41H5v7Or6EWeZCtUx1G91NH
dkrks0wuSn9LNIVWHKWJBd4lSEVENatb7rd0+k5yJlFBsWh4ZAhXtAEAvgB523cK
235XZ4SYzEGFRClkFE5jPcSlUhw0/nTEPyVQwfGSYzGYjFmWdso4sFaFCfS1VEfl
+/NtlOuqzNYxsLiz8x41/IY7lAoy3eBEq9Ll7xemRPY5/qzelL8QMMfy52nrGqFK
wlzb7N9Wfd7qASeIxAPwMX0x507Mi73htsd/TJ4xgBCVBJ7HPvKKqMnsmPatKlx1
MCsVr/Z40yQ2aXDLkxSn
=m+NG
-----END PGP SIGNATURE-----

--rG09A39trvEtf3rB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
