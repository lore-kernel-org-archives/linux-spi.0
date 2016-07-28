From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Split bus and I/O locking
Date: Thu, 28 Jul 2016 10:59:32 +0100
Message-ID: <20160728095932.GC11806@sirena.org.uk>
References: <1469142737-2814-1-git-send-email-broonie@kernel.org>
 <20160728022314.GG15995@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T4NxgPrvSrIDR5b4"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160728022314.GG15995-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--T4NxgPrvSrIDR5b4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 27, 2016 at 10:23:14PM -0400, Rich Felker wrote:

> I saw it's in the asoc tree now -- will this be making it upstream for
> this merge window? Hoping so. The issue it fixes is a nasty data
> corruption regression that's been around for a while now and although
> we can keep using out-of-tree patches or workarounds it would be nice
> to have it fixed in unpatched kernels. Thanks again for the quick
> patch and for doing it in a way that makes the code clearer & more
> accessible to developers reading and trying to understand it.

It was sent to Linus via the SPI tree earlier this week, the message
about ASoC was a result of a misfiring script.

--T4NxgPrvSrIDR5b4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmdeDAAoJECTWi3JdVIfQCMIH/RJsR6G3yuOG1PMc3R/jOQiu
BCbIhiHAz0gl+Bs6psAQBY0STxTpN/gaQ5An5fe9LhIQrXT3tKlsAx8c61Ym7+vY
jQaDacR+Dpr7jCt8jMcf222Q1CHiKLuc6PnIwb4aQMkMSvSvMt4rX8tCa81tKWA8
aHW8b9bLYxZ9EQy2OB8GPq+O6XmuQf4hNRc5nMfbtIyBYUjdfXLUgDGyZDSRlNao
XHgQRahJ4Ac3v3vrdSPcehMrn7mrSxWG6b37+sla9BRIRrL9tCR8b1zIo9lCefeZ
D0RrIV0LffKAmXLzuwRPCqw8SK5OAddN+MQstlnBuGBEkiMLFTs/XnTngW89HgY=
=EG3J
-----END PGP SIGNATURE-----

--T4NxgPrvSrIDR5b4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
