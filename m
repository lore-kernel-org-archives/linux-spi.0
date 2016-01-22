From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/fsl-espi: Remove the address conversion operation
Date: Fri, 22 Jan 2016 12:16:36 +0000
Message-ID: <20160122121636.GW6588@sirena.org.uk>
References: <1453460307-9768-1-git-send-email-Zhiqiang.Hou@freescale.com>
 <1453460307-9768-2-git-send-email-Zhiqiang.Hou@freescale.com>
 <20160122112637.GU6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1EkNNaW82TX7EOeM"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Zhiqiang Hou <Zhiqiang.Hou-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160122112637.GU6588-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1EkNNaW82TX7EOeM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2016 at 11:26:37AM +0000, Mark Brown wrote:
> On Fri, Jan 22, 2016 at 06:58:27PM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >=20
> > The eSPI bus driver should not touch the protocol layer drivers'
> > operations. It makes the eSPI driver isn't compatiable with devices
>=20
> I don't seem to have patch 1.

It turned up now.

--1EkNNaW82TX7EOeM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWoh2jAAoJECTWi3JdVIfQEn4H/2pmR/zT3AABSNQt4zuISKwR
TWs6Vymx2tdnF/VLW4M7Vu6zDXjzTQHN0jz1o845ZPiYTmftk9ZyTy6kVBdoI5z1
2QKskGMrkx1vJrbVPqZPZXfg1ZyzWLkShdr58Xo64RIqGNFZI3NIs663+LFBf2Y8
cd98ibpCCs6bDLk5+KwY5o1tBcueR1F0UiVf93v8UrIdcRcJ/HEFD1J+02hXlcfV
1iE8tszq6A4iw96bJqD0yEfjbx1YlCQ4OOhmhyfXl8mSLa4UXMGDySFIqRUfYDrC
m8TnKP0NM2rwCsQocu5CevhbncTTVT1uHgADLq7SBtkzoA4jvC+Lv5CLbX0xxYU=
=oTZa
-----END PGP SIGNATURE-----

--1EkNNaW82TX7EOeM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
