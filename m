From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: sirf: use SET_SYSTEM_SLEEP_PM_OPS to initialize
 PM entries
Date: Mon, 24 Feb 2014 11:01:45 +0900
Message-ID: <20140224020145.GW25940@sirena.org.uk>
References: <1392222620-17273-1-git-send-email-21cnbao@gmail.com>
 <1392222620-17273-3-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zXMTu4gyvSiIg/yU"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392222620-17273-3-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zXMTu4gyvSiIg/yU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2014 at 12:30:20AM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> use SET_SYSTEM_SLEEP_PM_OPS to initialize PM entries, this makes the codes
> clean and also enable the ability of hibernation support for sirf SPI.

Applied, thanks.

--zXMTu4gyvSiIg/yU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCqgGAAoJELSic+t+oim95BMP/3gtjToK0p89v4/2gFj0ywEY
e4UPoxAxhtL5E715m0pMLgSLqqexLeBMv7NIG0SEHmkWzvVij7xquJbu1HgaXyxN
Lf7e6sqweH0fe3pTd/tGrowwSVO2mMZIkVa8SyQodOY42/wlUQALZRW+cF2kk77w
JkzyljBeWbKSIXnX2xxG0a2qqll0+lCdlvnmZCu14La3ysVRjEnjTm081d382bvj
dk5DE0XFQtiNeh1z5bdtAP/G4G7hx1OrxTgfpX3Z+QmdGDYmB6lf9cuS2l32fXl+
/xLAz37PhEJsrrKGrk6gFNouEk8pP8vK118c3LPkmjgNnO4cUNG49Z2p9kxOsRb8
h2edIQV2dkLWmdPFaAl6N5+P+iociHafF5mm71H6iOARjRKGdV3MTf1YeoRlq8Rj
BuV7RmnvOGCFenC9jXA/RhC56mlhEKsSsndRjcFTGct+xojXVzfLbZxAaBCYwxJu
4h95/ydpZqleRHLMXl9JISv5nn47VsWfnCIIhxnQDiyw9YFAppvjFIyMXX2ZBQEU
IkqZ+9LOqoyamUC8xLS1q/1GIKxsE1KORI5MGXwEsEntM7Q3hCu8LsKZFfD+FAvP
mlMmiiU+iBduAHwWHboX5zRZsMcAscfOew5N3lK6ARDL55Rz31+oIpIxs6XDLV33
FzsKbFiHf31qq9N+66ce
=2Aqm
-----END PGP SIGNATURE-----

--zXMTu4gyvSiIg/yU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
