From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] mtd: spi-nor: add an option to force 3byte adressing
 mode
Date: Mon, 4 Sep 2017 18:26:02 +0200
Message-ID: <20170904162602.GC21849@amd>
References: <1503954854-30963-1-git-send-email-mw@semihalf.com>
 <1503954854-30963-2-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com,
        cyrille.pitchen@wedev4u.fr, marek.vasut@gmail.com,
        broonie@kernel.org, thomas.petazzoni@free-electrons.com,
        gregory.clement@free-electrons.com, nadavh@marvell.com,
        neta@marvell.com, omrii@marvell.com, hannah@marvell.com,
        jaz@semihalf.com, tn@semihalf.com
To: Marcin Wojtas <mw@semihalf.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503954854-30963-2-git-send-email-mw@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> index 1413828..029c87d 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2002,7 +2002,17 @@ int spi_nor_scan(struct spi_nor *nor, const char *=
name,
>  		if (JEDEC_MFR(info) =3D=3D SNOR_MFR_SPANSION ||
>  		    info->flags & SPI_NOR_4B_OPCODES)
>  			spi_nor_set_4byte_opcodes(nor, info);
> -		else
> +		else if (of_property_read_bool(np, "spi-3byte-addressing")) {
> +			/*
> +			 * Do not enter 4byte mode in order to prevent
> +			 * the early bootloader to come up on non-default
> +			 * SPI NOR memory during boot. Limit accessible
> +			 * size to 16MiB.
> +			 */
> +			nor->addr_width =3D 3;
> +			mtd->size =3D 0x1000000;
> +			dev_info(dev, "Force 3B addressing mode\n");

I'd append "limiting access to first 16MiB" .. because otherwise
people will wonder where their flash went.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmtfpoACgkQMOfwapXb+vIroACffO9X/PgTB78Lap7a67L4ktNh
Um4AoLYdOzK2KItNHTvYmMsBVuX3624u
=Bpyw
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
