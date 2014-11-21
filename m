From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-spi: Don't use cpm_command on CPM1
Date: Fri, 21 Nov 2014 18:12:53 +0000
Message-ID: <20141121181253.GX3815@sirena.org.uk>
References: <20141120162418.04FAC1A9BFC@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RyRVxeT1fPSLkipE"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141120162418.04FAC1A9BFC-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--RyRVxeT1fPSLkipE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2014 at 05:24:17PM +0100, Christophe Leroy wrote:
> On CPM1, when the SPI parameter RAM is relocated to somewhere else than t=
he
> default location, in accordance with freescale documentation
> (refer micropatch SPI application note EB662), init RX/TX params command =
shall
> not be used because it doesn't take into account the new location, and
> overwrites data that is in original location of SPI param ram at addresse=
s=20
> SCC2 param base +  (u32*)0x88 (u16*)0x90 (u32*)0x98 (u16*)0xA0, hence bre=
aking
> activity on SCC2 if SCC2 is used in a mode like QMC for instance.

Applied, thanks.

--RyRVxeT1fPSLkipE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb4CkAAoJECTWi3JdVIfQzEIIAIBpGFtzX4a+MGQh8q+sJtEs
AwPTpoaGY/EzbgYSx39srYrjQD17FK5uogXnDRYcg62BEIbvix2PQrNgADXK0xLi
wF6VY2ApnMnyoBZQKx+yT0d1esADAswtX8pfkD2yL2WroIwIfCtC1six4uXZB2WC
UEantw8K25PTJfNLT3N82Cb21qclcuA1vUYe/Q+8dtQKJzz+kt+v4Q8dZCKqoiWf
lvA43RWlFLXfjjQnCfpb4v4Cm1sNglJkuMsJS+opiKMvjq9b1NkPL3rs3ysb5NyG
9haY99ntFjTYydZEmsQT1YBAsjfR01rCuaJnee6jWJZWMx46t5oLG1OGaymWQf8=
=uMc0
-----END PGP SIGNATURE-----

--RyRVxeT1fPSLkipE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
