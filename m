From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl: Sort include headers alphabetically
Date: Mon, 29 Sep 2014 18:14:20 +0100
Message-ID: <20140929171420.GX16977@sirena.org.uk>
References: <1411959426-3060-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hEi834+foqWOL7fK"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411959426-3060-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hEi834+foqWOL7fK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 29, 2014 at 10:57:06AM +0800, Xiubo Li wrote:
> Sort all the include headers alphabetically for the freescale
> spi drivers. If the inlcude headers sorted out of order, maybe
> the best logical choice is to append new ones after the exist
> ones, while this may create a lot of potential for duplicates
> and conflicts for each diffenent changes will add new headers
> in the same location.

Applied, thanks.

--hEi834+foqWOL7fK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKZNsAAoJECTWi3JdVIfQ0AUH/jb4nUiyA0vKhxfMlwKwHE4o
w/o2EclRVQ5ClONo6KbX9KOQvbUTGYgLF6271cuVASkvoOoddGiObEfbaagGcdB5
ppEUUkKHTKhdMcs8yWB33Q9+7EVNRc+Cd4sDYJJswg2AcOkPg0dwddcdHn0OMD1u
9ndPBkKL4VKGsDwV39biMAIyrHfFk0uRLq7zekIF8mEtp8XInPkUOpOUmbHAupcW
gVg6L8ydtF+Fud2ketxpjaBVOHn5wHgTs/xRP+faQ0hnStyTuXPo/DNghg63slwx
PrcAaYCvrxErEWsex0PRezKQbCT2LbXdpNIZc7zUgNYhyPjPxemp4Rfze3SvYTg=
=Ok/T
-----END PGP SIGNATURE-----

--hEi834+foqWOL7fK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
