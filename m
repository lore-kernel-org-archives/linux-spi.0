From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/atmel: improve the system suspend/resume functions
 implementation
Date: Tue, 21 Oct 2014 22:27:33 +0100
Message-ID: <20141021212733.GC2344@sirena.org.uk>
References: <1413863014-1791-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413863014-1791-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 21, 2014 at 11:43:34AM +0800, Wenyou Yang wrote:
> To make it cleaner, the system suspend/resume directly call
> the runtime suspend/resume functions
> and remove the wapper of CONFIG_PM_RUNTIME, CONFIG_PM_SLEEP.

Applied, thanks.

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJURs/EAAoJECTWi3JdVIfQbv0H/RgSk4I4ouelcB4hJpU7uubO
JOSW3UZAb+ZI9SMdLprqe/Gr7Fxf/DDuVeExrWZ2nFhl+Ha4BWTqg96OeCD0rLjD
DM7PwYPNZte7HXTFfAPV4uqPg7UDPKuPPOSrGRBjt6odQnBm6S3A1xhzhuB2PrsA
Jbx7mU31dxKgrAqsLK0vtSMaYGclUCW1fISW939cB/J/frdS4PSvS08Y3wIDfWMK
zNaRvbqZ1eRI0mCYpKEwJc7CZLG/q6lNcq3T1+PqqfaKLnGa6whxBRz8TyKx/ENS
FNDS90X6TsmPvad1mIHZqd7JUgVdhti811zczVjnj7TatejS8BaLEpyRqs8M9Oo=
=qtFQ
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
