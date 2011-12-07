From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] SPI: MIPS: lantiq: add FALC-ON spi driver
Date: Wed, 7 Dec 2011 23:51:22 +0100
Message-ID: <20111207225122.GF3744@pengutronix.de>
References: <1321454237-4041-1-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        spi-devel-general@lists.sourceforge.net,
        Thomas Langer <thomas.langer@lantiq.com>
To: John Crispin <blogic@openwrt.org>
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1321454237-4041-1-git-send-email-blogic@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org


--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2011 at 03:37:17PM +0100, John Crispin wrote:
> The external bus unit (EBU) found on the FALC-ON SoC has spi emulation th=
at is
> designed for serial flash access. This driver has only been tested with m=
25p80
> type chips. The hardware has no support for other types of spi peripheral=
s.
>=20
> Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: spi-devel-general@lists.sourceforge.net

Rough review.

> ---
>=20
>  arch/mips/lantiq/falcon/devices.c        |   13 +
>  arch/mips/lantiq/falcon/devices.h        |    4 +
>  arch/mips/lantiq/falcon/mach-easy98000.c |   27 ++
>  drivers/spi/Kconfig                      |    4 +
>  drivers/spi/Makefile                     |    1 +
>  drivers/spi/spi-falcon.c                 |  483 ++++++++++++++++++++++++=
++++++
>  6 files changed, 532 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/spi-falcon.c

You need to split up the arch-specific changes and driver-specific
changes into seperate patches.

> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index a1fd73d..f244553 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -180,6 +180,10 @@ config SPI_MPC52xx
>  	  This drivers supports the MPC52xx SPI controller in master SPI
>  	  mode.
> =20
> +config SPI_FALCON
> +	tristate "Falcon SPI controller support"
> +	depends on SOC_FALCON
> +

Kconfig is alphabetically sorted. Please keep that.

>  config SPI_MPC52xx_PSC
>  	tristate "Freescale MPC52xx PSC SPI controller"
>  	depends on PPC_MPC52xx && EXPERIMENTAL
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 61c3261..570894c 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_SPI_DW_MMIO)		+=3D spi-dw-mmio.o
>  obj-$(CONFIG_SPI_DW_PCI)		+=3D spi-dw-midpci.o
>  spi-dw-midpci-objs			:=3D spi-dw-pci.o spi-dw-mid.o
>  obj-$(CONFIG_SPI_EP93XX)		+=3D spi-ep93xx.o
> +obj-$(CONFIG_SPI_FALCON)		+=3D spi-falcon.o
>  obj-$(CONFIG_SPI_FSL_LIB)		+=3D spi-fsl-lib.o
>  obj-$(CONFIG_SPI_FSL_ESPI)		+=3D spi-fsl-espi.o
>  obj-$(CONFIG_SPI_FSL_SPI)		+=3D spi-fsl-spi.o
> diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
> new file mode 100644
> index 0000000..8b81aa2
> --- /dev/null
> +++ b/drivers/spi/spi-falcon.c
> @@ -0,0 +1,483 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify=
 it
> + *  under the terms of the GNU General Public License version 2 as publi=
shed
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2010 Thomas Langer <thomas.langer@lantiq.com>
> + */
> +

=2E..

> +int
> +falcon_spi_xfer(struct spi_device *spi,
> +		    struct spi_transfer *t,
> +		    unsigned long flags)

I'd prefer to squash the lines, dunno Grant's preference.

> +{
> +	struct device *dev =3D &spi->dev;
> +	struct falcon_spi *priv =3D spi_master_get_devdata(spi->master);
> +	const u8 *txp =3D t->tx_buf;
> +	u8 *rxp =3D t->rx_buf;
> +	unsigned int bytelen =3D ((8 * t->len + 7) / 8);
> +	unsigned int len, alen, dumlen;
> +	u32 val;
> +	enum {
> +		state_init,
> +		state_command_prepare,
> +		state_write,
> +		state_read,
> +		state_disable_cs,
> +		state_end
> +	} state =3D state_init;
> +
> +	do {
> +		switch (state) {
> +		case state_init: /* detect phase of upper layer sequence */
> +		{
> +			/* initial write ? */
> +			if (flags & FALCON_SPI_XFER_BEGIN) {
> +				if (!txp) {
> +					dev_err(dev,
> +						"BEGIN without tx data!\n");
> +					return -1;

-Esomething perhaps (for all occurences)?

> +				}
> +				/*
> +				 * Prepare the parts of the sfcmd register,
> +				 * which should not
> +				 * change during a sequence!
> +				 * Only exception are the length fields,
> +				 * especially alen and dumlen.
> +				 */

I think some lines could be squashed again.

> +
> +				priv->sfcmd =3D ((spi->chip_select
> +						<< SFCMD_CS_OFFSET)
> +					       & SFCMD_CS_MASK);
> +				priv->sfcmd |=3D SFCMD_KEEP_CS_KEEP_SELECTED;
> +				priv->sfcmd |=3D *txp;
> +				txp++;
> +				bytelen--;
> +				if (bytelen) {
> +					/*
> +					 * more data:
> +					 * maybe address and/or dummy
> +					 */
> +					state =3D state_command_prepare;
> +					break;
> +				} else {
> +					dev_dbg(dev, "write cmd %02X\n",
> +						priv->sfcmd & SFCMD_OPC_MASK);
> +				}
> +			}
> +			/* continued write ? */
> +			if (txp && bytelen) {
> +				state =3D state_write;
> +				break;
> +			}
> +			/* read data? */
> +			if (rxp && bytelen) {
> +				state =3D state_read;
> +				break;
> +			}
> +			/* end of sequence? */
> +			if (flags & FALCON_SPI_XFER_END)
> +				state =3D state_disable_cs;
> +			else
> +				state =3D state_end;
> +			break;
> +		}
> +		/* collect tx data for address and dummy phase */
> +		case state_command_prepare:
> +		{
> +			/* txp is valid, already checked */
> +			val =3D 0;
> +			alen =3D 0;
> +			dumlen =3D 0;
> +			while (bytelen > 0) {
> +				if (alen < 3) {
> +					val =3D (val<<8)|(*txp++);

Spaces around operators.

> +					alen++;
> +				} else if ((dumlen < 15) && (*txp =3D=3D 0)) {
> +					/*
> +					 * assume dummy bytes are set to 0
> +					 * from upper layer
> +					 */
> +					dumlen++;
> +					txp++;
> +				} else
> +					break;
> +				bytelen--;
> +			}

=2E..

> +static int
> +falcon_spi_setup(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	const u32 ebuclk =3D CLOCK_100M;
> +	unsigned int i;
> +	unsigned long flags;
> +
> +	dev_dbg(dev, "setup\n");

I'd think these debug outputs at the beginning of functions could simply
go.

> +
> +	if (spi->master->bus_num > 0 || spi->chip_select > 0)
> +		return -ENODEV;
> +

=2E..

> +static int
> +falcon_spi_transfer(struct spi_device *spi, struct spi_message *m)
> +{
> +	struct falcon_spi *priv =3D spi_master_get_devdata(spi->master);
> +	struct spi_transfer *t;
> +	unsigned long spi_flags;
> +	unsigned long flags;
> +	int ret =3D 0;
> +
> +	priv->sfcmd =3D 0;
> +	m->actual_length =3D 0;
> +
> +	spi_flags =3D FALCON_SPI_XFER_BEGIN;
> +	list_for_each_entry(t, &m->transfers, transfer_list) {
> +		if (list_is_last(&t->transfer_list, &m->transfers))
> +			spi_flags |=3D FALCON_SPI_XFER_END;
> +
> +		spin_lock_irqsave(&ebu_lock, flags);
> +		ret =3D falcon_spi_xfer(spi, t, spi_flags);
> +		spin_unlock_irqrestore(&ebu_lock, flags);
> +
> +		if (ret)
> +			break;
> +
> +		m->actual_length +=3D t->len;
> +
> +		if (t->delay_usecs || t->cs_change)
> +			BUG();

No garceful way of handling that?

> +
> +		spi_flags =3D 0;
> +	}
> +
> +	m->status =3D ret;
> +	m->complete(m->context);
> +
> +	return 0;
> +}
> +
> +static void
> +falcon_spi_cleanup(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +
> +	dev_dbg(dev, "cleanup\n");
> +}
> +
> +static int __devinit
> +falcon_spi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct falcon_spi *priv;
> +	struct spi_master *master;
> +	int ret;
> +
> +	dev_dbg(dev, "probing\n");
> +
> +	master =3D spi_alloc_master(&pdev->dev, sizeof(*priv));
> +	if (!master) {
> +		dev_err(dev, "no memory for spi_master\n");

I think -ENOMEM tells enough.

> +		return -ENOMEM;
> +	}
> +
> +	priv =3D spi_master_get_devdata(master);
> +	priv->master =3D master;
> +
> +	master->mode_bits =3D SPI_MODE_3;
> +	master->num_chipselect =3D 1;
> +	master->bus_num =3D 0;
> +
> +	master->setup =3D falcon_spi_setup;
> +	master->transfer =3D falcon_spi_transfer;
> +	master->cleanup =3D falcon_spi_cleanup;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret =3D spi_register_master(master);
> +	if (ret)
> +		spi_master_put(master);
> +
> +	return ret;
> +}
> +
> +static int __devexit
> +falcon_spi_remove(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct falcon_spi *priv =3D platform_get_drvdata(pdev);
> +
> +	dev_dbg(dev, "removed\n");
> +
> +	spi_unregister_master(priv->master);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver falcon_spi_driver =3D {
> +	.probe	=3D falcon_spi_probe,
> +	.remove	=3D __devexit_p(falcon_spi_remove),
> +	.driver =3D {
> +		.name	=3D DRV_NAME,
> +		.owner	=3D THIS_MODULE
> +	}
> +};

Use module_platform_driver here.

> +
> +static int __init
> +falcon_spi_init(void)
> +{
> +	return platform_driver_register(&falcon_spi_driver);
> +}
> +
> +static void __exit
> +falcon_spi_exit(void)
> +{
> +	platform_driver_unregister(&falcon_spi_driver);
> +}
> +
> +module_init(falcon_spi_init);
> +module_exit(falcon_spi_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Lantiq Falcon SPI controller driver");

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7f7eoACgkQD27XaX1/VRv6TgCdGM8uHqRb02rhiws/8d6BG5Wn
7eMAoILjTVpIWSIoRmuza+KcOJH7eqOg
=DhoE
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--
