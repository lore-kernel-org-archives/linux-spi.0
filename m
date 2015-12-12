From: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v2] spi: dts: sun4i: Add support for
 inter-word wait cycles using the SPI Wait Clock Register
Date: Sat, 12 Dec 2015 11:19:40 +0200
Message-ID: <1449911980.29015.7.camel@plaes.org>
References: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
Reply-To: plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark
 Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell
 <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime
 Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,  Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Return-path: <linux-sunxi+bncBDJLTBEBXENBBTWNV6ZQKGQE2C3INAY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1449873940-10167-1-git-send-email-mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On Fri, 2015-12-11 at 23:45 +0100, Marcus Weseloh wrote:

[...]
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-sun4i.txt b/Docume=
ntation/devicetree/bindings/spi/spi-sun4i.txt
> index de827f5..d6c55fc 100644
> --- a/Documentation/devicetree/bindings/spi/spi-sun4i.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
> @@ -10,6 +10,10 @@ Required properties:
> =C2=A0=C2=A0=C2=A0- "mod": the parent module clock
> =C2=A0- clock-names: Must contain the clock names described just above
> =C2=A0
> +Optional properties for slave devices:
> +- sun4i,spi-word-wait-ns: hardware based delay in nanoseconds between
> +			=C2=A0=C2=A0transmission of words

Should be 'allwinner,spi-word-wait-ns'

Vendor prefix do come from:
Documentation/devicetree/bindings/vendor-prefixes.txt

> +
> =C2=A0Example:
> =C2=A0
> =C2=A0spi1: spi@01c06000 {
> @@ -21,4 +25,11 @@ spi1: spi@01c06000 {
> =C2=A0	status =3D "disabled";
> =C2=A0	#address-cells =3D <1>;
> =C2=A0	#size-cells =3D <0>;
> +
> +	spi1_0 {
> +		compatible =3D "example,dummy";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <1000000>;
> +		sun4i,spi-word-wait-ns =3D <12000>;
> +	};
> =C2=A0};
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index f60a6d6..8cfd96c 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -19,6 +19,7 @@
> =C2=A0#include=20
> =C2=A0#include=20
> =C2=A0#include=20
> +#include=20
> =C2=A0
> =C2=A0#include=20
> =C2=A0
> @@ -173,6 +174,9 @@ static int sun4i_spi_transfer_one(struct spi_master *=
master,
> =C2=A0	unsigned int tx_len =3D 0;
> =C2=A0	int ret =3D 0;
> =C2=A0	u32 reg;
> +	u32 wait_ns =3D 0;
> +	int wait_clk =3D 0;
> +	int clk_ns =3D 0;
> =C2=A0
> =C2=A0	/* We don't support transfer larger than the FIFO */
> =C2=A0	if (tfr->len > SUN4I_FIFO_DEPTH)
> @@ -261,6 +265,25 @@ static int sun4i_spi_transfer_one(struct spi_master =
*master,
> =C2=A0
> =C2=A0	sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);
> =C2=A0
> +	/* Setup wait time beteen words */
typo

> +	of_property_read_u32(spi->dev.of_node, "sun4i,spi-word-wait-ns",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&wait_ns);
> +	if (wait_ns) {
> +		/* The wait time is set in SPI_CLK cycles. The SPI hardware
> +		=C2=A0* needs 3 additional cycles to setup the wait counter, so
> +		=C2=A0* the minimum delay time is 4 cycles.
> +		=C2=A0*/
> +		clk_ns =3D DIV_ROUND_UP(1000000000, tfr->speed_hz);
> +		wait_clk =3D DIV_ROUND_UP(wait_ns, clk_ns) - 3;
> +		if (wait_clk < 1) {
> +			wait_clk =3D 1;
> +			dev_info(&spi->dev,
> +				=C2=A0"using minimum of 4 word wait cycles (%uns)",
> +				=C2=A04 * clk_ns);
> +		}
> +	}
> +	sun4i_spi_write(sspi, SUN4I_WAIT_REG, (u16)wait_clk);
> +
> =C2=A0	/* Setup the transfer now... */
> =C2=A0	if (sspi->tx_buf)
> =C2=A0		tx_len =3D tfr->len;
> --=C2=A0
> 1.9.1
>=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
