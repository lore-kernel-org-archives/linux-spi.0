From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: sirf: add the reset for USP-based SPI
Date: Tue, 26 May 2015 11:38:55 +0100
Message-ID: <20150526103855.GO21577@sirena.org.uk>
References: <1432617694-15974-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCaxfLZdDTBfImim"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432617694-15974-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--FCaxfLZdDTBfImim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2015 at 05:21:34AM +0000, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> USP-based SPI need a disable and enable, otherwise it doesn't work.
> this patch adds it as HW initialization.

Applied, thanks.

--FCaxfLZdDTBfImim
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZE0+AAoJECTWi3JdVIfQH14H/2cxcQBp71hHw2MalcqhMpbF
yn+hdDBdrLG+dcnjZGnvquZoSUzcBtETB3k36yHcH6bE0P5D2HPJAQMvGR5xRWVy
76rNGxlLS7Z1vfMwc1PXrV9QTpKwazIHiuqwEWB4aNw35ooZ8GSzz0nUltRE+URG
ty2NJyk8u+WKCVSPOOorNJ3N4a5ty3Ua8VCc0ciB5BFiG02uSZ8gtbQlgj2UYXXe
wzKZBIVNInUzwIUKcpavX/6c7Z65tKoE0A2fuCTn4ZmRS0Mm7fWe3CokNWsvUB3G
IWq/lXIb++M21QR36uq65hS2lUJZxUHTNI8XmNt2PjjevcPsiO0LHaIc/oHXT7k=
=O2qm
-----END PGP SIGNATURE-----

--FCaxfLZdDTBfImim--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
