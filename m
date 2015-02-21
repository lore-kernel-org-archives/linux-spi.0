From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] drivers: spi: ti-qspi: wait for busy bit clear
 before data write/read
Date: Sat, 21 Feb 2015 18:29:21 +0900
Message-ID: <20150221092921.GD6236@finisterre.sirena.org.uk>
References: <1424199831-5518-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424199831-5518-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 18, 2015 at 12:33:51AM +0530, Mugunthan V N wrote:
> Data corruption is seen while reading/writing large data from/to qspi
> device because the data register is over written or read before data
> is ready which is denoted by busy bit in status register. SO adding
> a busy bit check before writing/reading data to/from qspi device.

Applied, thanks.

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU6E/xAAoJECTWi3JdVIfQ4hwH/jHj8GK1XaN/RFCtH5DsAxAL
ACvib5R+VH+jBkHLj8Yr/BDV7lk+Ffekp+oMH53M6CbhHTIFMgwC2nlWVkafhetV
Wors/lgpACcNeq78UKN92K76lCQyU8bgatF1et2bhStBZISCCtTlp3IZwJ5Qv4EN
LJpQ0wFnZfwiReNz/z7CHiWBEZz/cq+kXNw4+DPtMJ0ZnwoTuz3886DR6VIsz2n7
wzdBXePcXnNXbaphYd4FSqiV04Yydx4zP0lsyvs8Tq8xwbLe+lKxNI6OeCsvTF3B
VMY5+gMmTigNiHsF1GRUjwL6vrCXEcYNGYmyOYXEJhNAWd6c9vfMUV1wfSmZVRA=
=x5xG
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
