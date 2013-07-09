From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 2/2] spi: convert drivers to use bits_per_word_mask
Date: Tue, 09 Jul 2013 17:47:04 +0200
Message-ID: <51DC3078.5090602@monstr.eu>
References: <1369190195-14598-1-git-send-email-swarren@wwwdotorg.org> <1369190195-14598-2-git-send-email-swarren@wwwdotorg.org>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2LWSCQCMWBOQWUSTABNRJ"
Cc: Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	Mike Frysinger <vapier@gentoo.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369190195-14598-2-git-send-email-swarren@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2LWSCQCMWBOQWUSTABNRJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index e1d7696..f321bf9 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -232,21 +232,6 @@ static int xilinx_spi_setup_transfer(struct spi_de=
vice *spi,
>  	return 0;
>  }
> =20
> -static int xilinx_spi_setup(struct spi_device *spi)
> -{
> -	/* always return 0, we can not check the number of bits.
> -	 * There are cases when SPI setup is called before any driver is
> -	 * there, in that case the SPI core defaults to 8 bits, which we
> -	 * do not support in some cases. But if we return an error, the
> -	 * SPI device would not be registered and no driver can get hold of i=
t
> -	 * When the driver is there, it will call SPI setup again with the
> -	 * correct number of bits per transfer.
> -	 * If a driver setups with the wrong bit number, it will fail when
> -	 * it tries to do a transfer
> -	 */
> -	return 0;
> -}
> -
>  static void xilinx_spi_fill_tx_fifo(struct xilinx_spi *xspi)
>  {
>  	u8 sr;
> @@ -377,7 +362,6 @@ struct spi_master *xilinx_spi_init(struct device *d=
ev, struct resource *mem,
>  	xspi->bitbang.chipselect =3D xilinx_spi_chipselect;
>  	xspi->bitbang.setup_transfer =3D xilinx_spi_setup_transfer;
>  	xspi->bitbang.txrx_bufs =3D xilinx_spi_txrx_bufs;
> -	xspi->bitbang.master->setup =3D xilinx_spi_setup;
>  	init_completion(&xspi->done);
> =20
>  	if (!request_mem_region(mem->start, resource_size(mem),
>=20

This part of this patch is breaking xilinx spi driver because when
spi_bitbang_start is called it goes through some if else...
and because bitbang->txrx_bufs is defined
it end up in this code
	} else if (!master->setup) {
		return -EINVAL;
	}

Probably the best solution is just revert this part of patch.
Mark: What do you think?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



------enig2LWSCQCMWBOQWUSTABNRJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHcMHgACgkQykllyylKDCE0tQCghjnGxeb6USLNInQqlxXGVRLu
cLsAnjm4xWVQeT63emvmTSqfnWhkUJDq
=DM0e
-----END PGP SIGNATURE-----

------enig2LWSCQCMWBOQWUSTABNRJ--
