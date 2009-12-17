From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors@mocean-labs.com>
Subject: Re: [PATCH] spi: xilinx_spi: Fix up I/O routine wrapping bogosity.
Date: Thu, 17 Dec 2009 11:59:51 +0100
Message-ID: <4B2A0F27.8070906@mocean-labs.com>
References: <20091216060130.GD31265@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Linn <John.Linn@xilinx.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764500AbZLQLPF@vger.kernel.org>
In-Reply-To: <20091216060130.GD31265@linux-sh.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Paul Mundt wrote:
> xilinx_spi presently makes some fairly questionable assumptions about=
 I/O
> routines, and attempts to assign ioread32/iowrite32 and friends direc=
tly
> to its own internal function pointers. On many platforms these I/O
> routines are macros or wrappers and not actual functions on their own=
,
> resulting in things like:
>=20
> ERROR: "ioread32be" [drivers/spi/xilinx_spi.ko] undefined!
> ERROR: "iowrite32be" [drivers/spi/xilinx_spi.ko] undefined!
> ERROR: "iowrite32" [drivers/spi/xilinx_spi.ko] undefined!
> ERROR: "ioread32" [drivers/spi/xilinx_spi.ko] undefined!
>=20
> If xilinx_spi wants to do this sort of casting, it needs to provide i=
ts
> own wrappers for these, or change how it does accesses completely.
>=20
> I've opted for the first approach, and the attached silly patch does
> that. If someone with the hardware available wants to give the second
> option a try that's ok too. In any event, the current code is broken =
for
> at least: arm, avr32, blackfin, microblaze, mn10300, and sh.
>=20
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>

Looks good to me.

Acked-by: Richard R=F6jfors <richard.rojfors@pelagicore.com>

>=20
> ---
>=20
>  drivers/spi/xilinx_spi.c |   28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
> index 9f38637..154e908 100644
> --- a/drivers/spi/xilinx_spi.c
> +++ b/drivers/spi/xilinx_spi.c
> @@ -93,6 +93,26 @@ struct xilinx_spi {
>  	void (*rx_fn) (struct xilinx_spi *);
>  };
> =20
> +static void xspi_write32(u32 val, void __iomem *addr)
> +{
> +	iowrite32(val, addr);
> +}
> +
> +static unsigned int xspi_read32(void __iomem *addr)
> +{
> +	return ioread32(addr);
> +}
> +
> +static void xspi_write32_be(u32 val, void __iomem *addr)
> +{
> +	iowrite32be(val, addr);
> +}
> +
> +static unsigned int xspi_read32_be(void __iomem *addr)
> +{
> +	return ioread32be(addr);
> +}
> +
>  static void xspi_tx8(struct xilinx_spi *xspi)
>  {
>  	xspi->write_fn(*xspi->tx_ptr, xspi->regs + XSPI_TXD_OFFSET);
> @@ -374,11 +394,11 @@ struct spi_master *xilinx_spi_init(struct devic=
e *dev, struct resource *mem,
>  	xspi->mem =3D *mem;
>  	xspi->irq =3D irq;
>  	if (pdata->little_endian) {
> -		xspi->read_fn =3D ioread32;
> -		xspi->write_fn =3D iowrite32;
> +		xspi->read_fn =3D xspi_read32;
> +		xspi->write_fn =3D xspi_write32;
>  	} else {
> -		xspi->read_fn =3D ioread32be;
> -		xspi->write_fn =3D iowrite32be;
> +		xspi->read_fn =3D xspi_read32_be;
> +		xspi->write_fn =3D xspi_write32_be;
>  	}
>  	xspi->bits_per_word =3D pdata->bits_per_word;
>  	if (xspi->bits_per_word =3D=3D 8) {
