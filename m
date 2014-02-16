From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sun6i: Fix define for SUN6I_TFR_CTL_CS_MASK
Date: Sun, 16 Feb 2014 09:11:17 +0800
Message-ID: <20140216011117.GS4451@sirena.org.uk>
References: <1392257895.3964.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vSzmLLrdioqyxIBH"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392257895.3964.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vSzmLLrdioqyxIBH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2014 at 10:18:15AM +0800, Axel Lin wrote:
> Current code in sun6i_spi_set_cs() actually clears CPHA and CPOL bits which is
> obvious wrong. The define for SUN6I_TFR_CTL_CS_MASK is wrong. Fix it.

Applied, thanks.

--vSzmLLrdioqyxIBH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTABAyAAoJELSic+t+oim9s0YP/0NqGVEDfDH/jhaMWQK2i75D
dzQ2+6idtso0CAPzvzneSLPP/SGMlttZotA75GeVMA2G16Rtz+9VLc43fLb+SqwE
MgPeoZhrqc9YDe2NTbI0G4RDkZa9pahwg87VV+/bEbz8DuuNPnC4sH5eQPwcXY+y
8K6Oc64+J+0jjG826PPwHJKqugukKBxXNhtkdNnm5bEC783SO7OGoXPqRM2aaAB3
EJ49PGK4BR43BjyyvGJzjrIo0XpTrUnqmONtRMwaC5Kt/N5umryM637BfOhG2Obo
MGD8HWKbVCGl123if3kwLwPcSvZDoHMNg8E/cQv9nrRsQExguXGce6jQ2zpBm4B1
X3bCnjyTQr8EMSHhmZP1GNt0bxP1adcOxG0U+xXyDz4I0MYfp2KI3TnECSXL2P5U
thDfmxEREyME8Di110h+JHqSz+WrSreaF3DxzeLFiMJl1meznhubz4GZHT5RzD4z
x6P1Srs7gyNVuG/wAYrE/SLaWq46V12N3kIG6iZBnYa4UFyD+K2TRrtXhDOU06Uo
GXivsvU7LMbaZfbnSgeGXh//Ym3cz0HkJJESI6FL9IuDw7yl9qGCoED0/c6ZrAz1
tYMoaMvP5Ylvx3vC+C8jDFy3h9tII9iHgnqdpIN6W8/CLQWzgRqD52EZlQIGhwxJ
0XJIOPz96BC2DTJF4rRw
=6ym/
-----END PGP SIGNATURE-----

--vSzmLLrdioqyxIBH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
