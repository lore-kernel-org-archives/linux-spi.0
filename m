From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Merge problem: Re: Applied "spi: fsl-espi: avoid processing
 uninitalized data on error" to the spi tree
Date: Wed, 26 Oct 2016 22:59:24 +0100
Message-ID: <20161026215923.GF25322@sirena.org.uk>
References: <E1bzLFV-0004Wz-Ut@debutante>
 <4b1c5f78-d754-fdc8-0f15-17f88ed224b7@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
        Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4b1c5f78-d754-fdc8-0f15-17f88ed224b7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 26, 2016 at 08:11:28PM +0200, Heiner Kallweit wrote:

> Instead it should be:
>=20
> if (rx_nr_bytes && mspi->rx) {
> 	*(u32 *)mspi->rx =3D rx_data;
> 	mspi->rx +=3D 4;
> }

Please send a patch.

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJYESc6AAoJECTWi3JdVIfQof0H92wRDgwPB0nvuXFPMDGTK/+8
9J20Ly8/bzuRCDCpwrDsEWZUhqmnoulzHmLZCN0q2cNP1MdG8oMpX17VbriU/swo
gfoChL1gga/8fRebZQCkPrSuzMkzKbCZzhZAVweM/dH80GBoS90YEGbvUVY4wbUx
OtTqT6MVQTdPSJ+OM0h5TXoeArLBrO0XuaXzKolGjiuK3A6O6StGTPgESvwR66sN
hRYSzrOboqTLw2bgxzAIq8x7r2qc2G80m311pyCwdnZJFPs+WUSwegQACIPee8mL
T9kUsV1XwyLol0X+GLxhG0ffjFh3gKD9yDq9C20J/HY74MyZq1ryK6oxl5Dnig==
=EBeH
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
