From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: sc18is602: Use devm_spi_register_master()
Date: Wed, 4 Dec 2013 12:54:17 +0000
Message-ID: <20131204125417.GQ29268@sirena.org.uk>
References: <002d01cef0af$5a21f140$0e65d3c0$%han@samsung.com>
 <002f01cef0af$b618e170$224aa450$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OxDG9cJJSSQMUzGF"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Guenter Roeck' <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <002f01cef0af$b618e170$224aa450$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--OxDG9cJJSSQMUzGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 02:14:30PM +0900, Jingoo Han wrote:
> Use devm_spi_register_master() to make cleanup paths simpler,
> and remove unnecessary remove().

Applied, thanks.

--OxDG9cJJSSQMUzGF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnyX2AAoJELSic+t+oim9JhkP/RUlpneWPQzPcmRIi+1Ywq10
c+xB5FW42K2S6sAVHe60DBusKfqYV/HoR0uARdp4eNyJJTsNQQDGJXUzulCE4IBy
lNDWUyAcvPGNOhU9LCo/pHsqfbbppqY6IBcLOnOIqwIbL/VpmNZF6+y6T31KtLkP
AnhmS9ooVZbZlXFDKiWNSbt62m+on6+NHxIP9p5K4Qe38pxV3P6vRhwG0vykuNni
IY/dJ9tnzOcEcJoRja3ZaxLdZb3NrXjH1KXOkgtojx36nW2XRFbRXNp6hug2aPYX
BS7wSiaL8dDvDPsqvXJ8ZGwnzl1B1Nc3/9eZR/RaWAkahINXXpykW3rsrP3pt2+A
Ghkn5jSrATyJFO4WD8n7IL4Wu/SBmELEUH4N80H+q6+opMdPuTn0j4Len1mmK+8+
leBPKPKEWf0KcARJ75/GjYs4KFOJEuXKbk1Dsbjuyt+eXuj4RnDFnRUMtwi8Wv/S
R7yY93FXqvx4PLYShTaOVzXLiMrCzLWXJp+TKUGhMh/0tp6v66JHTnEjLMqpClBR
3DM7WiXPkLPNQc91Bx0bR9f7xcEGrSPpGvpkLWhPjkGTyW5TrUwGitJlxSqFWidS
yltxmkKCVzKBSgibedvjdD9cFEC4CvuiCS+UqdXaxErRImS4xchSUBqRmix/mF4L
wf41ycNRubeCew/3L3wm
=agcK
-----END PGP SIGNATURE-----

--OxDG9cJJSSQMUzGF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
