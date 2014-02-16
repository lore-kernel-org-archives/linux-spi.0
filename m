From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi/s3c64xx: Trivial cleanup in header file
Date: Sun, 16 Feb 2014 09:59:28 +0800
Message-ID: <20140216015928.GY4451@sirena.org.uk>
References: <1392360977-21183-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H7QJU8Gl1+/xsYtC"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392360977-21183-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--H7QJU8Gl1+/xsYtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2014 at 12:26:17PM +0530, Sachin Kamat wrote:
> Commit 436d42c61c3e ("ARM: samsung: move platform_data definitions")
> moved the files to the current location but forgot to remove the pointer
> to its previous location. Clean it up. While at it also change the header
> file protection macros appropriately.

Applied, thanks.

--H7QJU8Gl1+/xsYtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTABt9AAoJELSic+t+oim9+80P/0I2NXbVX17W3T9OV8tNmeVZ
4KWrvnMKzBvUnQYDLEGyS8wiS/ornYXJLF3jlNQINGowejbt/x7ANOIqHUoYprEW
kmwa2tiBA8zXCl/h6NbJhUULgOyFEU+inPTRQgdK2Zaq/zjaCxAClcVmUr4XCADi
anPBoLpEWJjTbK+eb/+SQMm+Fp/Sng8QztH+ibBRXnYntMf0iNGvYP+fHwsppj/n
CJAc4Ur7voz7kBLfCY1V7yAiJJEa8aTFgPVA6in/tMnSQ3UJX+mMnaUlB2iLR+QL
M71U6RauyfkGVXqST774cm+hw5qNdAW6jmdT/8nuw0bw6Ek3Kn9iEmRhxkCCB+Jc
l1FK72Mtujhkqsi634SU+9lReVdhQ45Xmzsgbk2P7S6R25p2pQLIxXmQTywrnIdt
cvN8t0pYVuixmCl+xTIA6CLjdcvRt8u+AGOpQ2bSTuYIjgkgmw4mmF7Ffb2ivF96
/1FkIJqphJ0rIUHnbbInYAyVrXZ7AZiGt165qg2vvWBye/+NyX05Krk0OJEPvnkC
vjsmtsBueuOdElUyQWicN8+WRio+Liowgc85p603Jcj/iM0Fi0QnN6mCuHI73t16
0lNXYp+GFRxFEbKzaj1CtFNaZ86O2eyukOUqqbSkXHmgDUEDf9x8LB66ozzppHiR
7Y5cNJOpaiFUKvoMcnND
=kx91
-----END PGP SIGNATURE-----

--H7QJU8Gl1+/xsYtC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
