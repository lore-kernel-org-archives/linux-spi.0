From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: s3c24xx: Remove reference to plat/fiq.h
Date: Wed, 8 Jan 2014 13:06:59 +0000
Message-ID: <20140108130659.GE31886@sirena.org.uk>
References: <1388478639-25279-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ueIuAkhIEDaOqOw0"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388478639-25279-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ueIuAkhIEDaOqOw0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 31, 2013 at 02:00:39PM +0530, Sachin Kamat wrote:
> fiq.h contains only a function declaration and is not used by anyone
> else. Move the declaration to the driver header file and remove the
> unnecessary platform dependency from the driver.

Applied, thanks.

--ueIuAkhIEDaOqOw0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzU1wAAoJELSic+t+oim9dxUP+QEswUsgc9w4DWvFAfSkfsxY
hD48HZZLiZq6Nbs7zMnJrqrr57BCZZ/otK16nAmRpePy+QnN+5O5vVk8m8fxDiop
ZQEWeXqYD0f/4FOQfPUYqzSQSp+1aS2o/sehFCv4l0RQVWY00vXMs7Yqtu9pASi/
O3927g+2V3Fm5BRdcg7mVW9y4ECiO+pz/JYM0cLfKwtwYhnYTwIMu0JxECNNGtHs
cAkaL718/oiE9jLE/cayAnBmuvW9ZjQugkBOL9yMYMWU759dkHQYbSRorm870gkm
pzdFm8/vOAsPaSJmN4GA9AEh1QhNLEnMu+Z/8KjlJ35RstV6taZ5sbMG3CBjXAe2
AtoWnDtZB1gxPmWyTZF8TGumRstc8V5ErswHG+8HuwYyKUHA2tkyOVuShkVLVFX3
GteLTnRyiX9Yjh+5LOkeLxAqXS1auZTXXvaSsTxxqhgHO+kd9n91m5F4jh0N2SiZ
RIZus0Q5y1ueFSv1Wkx1M/mKc78Dy7K29Xh+U9AhciNioC3iwKaAEsw17LoE8Gxg
blFNt/shVOnzvWPseaeosV9UyGHSeHY9nxvchQW8Q8iLF0KELb+TPNlBiYLoLhKh
ZRxcDg2lGBrV+m8HRpTWzmyLxo3TwTrk9PcYh8bzIdlByBTmB4udsJ7pcBAT7Hs3
XcIP/gmCoMzYWlsguQwH
=mKP4
-----END PGP SIGNATURE-----

--ueIuAkhIEDaOqOw0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
