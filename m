From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/fsl-espi: Remove the address conversion operation
Date: Fri, 22 Jan 2016 11:26:37 +0000
Message-ID: <20160122112637.GU6588@sirena.org.uk>
References: <1453460307-9768-1-git-send-email-Zhiqiang.Hou@freescale.com>
 <1453460307-9768-2-git-send-email-Zhiqiang.Hou@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gLeD4uI0NkB0GjLy"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Zhiqiang Hou <Zhiqiang.Hou-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1453460307-9768-2-git-send-email-Zhiqiang.Hou-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gLeD4uI0NkB0GjLy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2016 at 06:58:27PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> The eSPI bus driver should not touch the protocol layer drivers'
> operations. It makes the eSPI driver isn't compatiable with devices

I don't seem to have patch 1.

--gLeD4uI0NkB0GjLy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWohHsAAoJECTWi3JdVIfQQxAH/3LEOy0u2URxKZmRnpVSR1+v
VXOaxXUiNQDPbfagEwDTvBuNF8Loj8hlc0go3/jk5w64sjT0fqbNNzXV51j06kb6
qwMq/YAFttJ9c5L/9SpSvQ0VpL8y/X/whAsQXbk5LhUKGyc117rjOo03qiRTLukh
RYQhui7a9s31/UqQv+M+/nQKqGQc49auzydbDGasrH3g49dYa215Yo46qySRm7A1
Vtnae65ni6/u2NbvrNCnQcWA8l1iOtZKbz4aaqbGJkXls/rDp5+4Tr3p8tpGArF5
F9sDx2n9yriluxB1grWlo8wVSskiMkLiI3eHLBwOtHDtDFz6H+DzU0MyErJoEaI=
=X0KZ
-----END PGP SIGNATURE-----

--gLeD4uI0NkB0GjLy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
