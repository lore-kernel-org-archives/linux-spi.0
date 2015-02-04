From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: atmel: cleanup wait_for_completion return
 handling
Date: Wed, 4 Feb 2015 11:26:12 +0000
Message-ID: <20150204112612.GX21293@sirena.org.uk>
References: <1422891811-28541-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9Jsz9XfKtAbN70/g"
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422891811-28541-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--9Jsz9XfKtAbN70/g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 10:43:31AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int, this
> patch adds an appropriate variable and fixes up the assignment. It remove=
s=20
> the else branch as the only thing it was doing is assigning ret =3D 0; - =
but=20
> ret is never used thereafter so that is not needed. As the string in=20
> dev_err already states "timeout" there is little point in printing the 0.=
=20
> A typo in "trasfer" -> transfer is also fixed.

Applied, thanks.

--9Jsz9XfKtAbN70/g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0gHTAAoJECTWi3JdVIfQA0IH/3qLR4UR4mW73VR2k4Z8+EoN
KoUzzhGdlaKRr/UnTDt8paGgFac1vFpdg8BgbPJTbsUtsf5tYHmldxMJg8oLoJKJ
1xx9Tj0CKGT15QL9uY4esaKVLHCqPFeePDik+UpBH0MM3QSaFm+y/t6xHj56pCwA
EmbtKWsdabszDBnPqd1s99h4XwIU2ObL6sqFiqU2WWtSp650DZeDFv+YaxTot8rI
mpe/sl/GWNIfqugzfQPGh9TVhxSWRVAf0S4nS2lfqDD56Pr8dyLEU2hX67CV7BHo
QHuHxlLBqqGoDrfm9/ez0ktdpPotDSmpCUyhhBwykEJm9bKw9hwq5K4AMGqlq6o=
=Ns8l
-----END PGP SIGNATURE-----

--9Jsz9XfKtAbN70/g--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
