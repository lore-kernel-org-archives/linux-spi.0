From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sirf: reset SPI controller in init stage
Date: Fri, 21 Nov 2014 18:11:39 +0000
Message-ID: <20141121181139.GW3815@sirena.org.uk>
References: <1416493987-6024-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D6v9cGCN71sRmige"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416493987-6024-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--D6v9cGCN71sRmige
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2014 at 10:33:07PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> in SPI boot mode, romcode uses SPI controller to fetch data from NOR
> flash. Here we need to reset the hardware IP to restore its state.

Applied, thanks.

--D6v9cGCN71sRmige
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb4BaAAoJECTWi3JdVIfQclcH/i9htM9uW/EK9Ve7dqzW630v
TUhcemIOWsadX/UsP4b0qbjeVB7OZlaF4ySu5tK9fxzNWBXg3KSFmgvaKhJwhsLk
D9HM3StMOx0i24Z7lVqpKNhEFRxdMvLvDR/cfR674+GYK+RjvCS04c6Pqg3r9vww
a4z0gk49HQZC1wUM1pkr41K4wxftX/dgXjUdmoPbo/KKyeyMdvx18stOrkQ5vDxx
vt9hlC36/7ckqE7WkmDB3twI6XLKpZ1erVQ/hoPrMQT/S2Jnn8E6BDxxZbdV2581
ZDueyRyICCVBYIGF3dWTtIi8RMFvdaY/eB76WJuN1Ffc+7DLFYp8ayyboa6D0hY=
=6ECH
-----END PGP SIGNATURE-----

--D6v9cGCN71sRmige--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
