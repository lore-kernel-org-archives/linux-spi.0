From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fix __spi_pump_messages deadlock
Date: Fri, 13 May 2016 14:38:19 +0100
Message-ID: <20160513133819.GR22038@sirena.org.uk>
References: <1463144312-23998-1-git-send-email-thomas.perrot@tupi.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="teKjxxMjPsACTz/N"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Perrot <thomas.perrot-cVvwS2TCF4I@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1463144312-23998-1-git-send-email-thomas.perrot-cVvwS2TCF4I@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--teKjxxMjPsACTz/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 13, 2016 at 02:58:32PM +0200, Thomas Perrot wrote:
> The lock on the spi bus is never release at the end of call of the function
> __spi_pump_messages.

So how does this deadlock, in what situations does this trigger?  If
there were a deadlock that happened every single time we tried to
transfer messages I'd expect people would have noticed...

--teKjxxMjPsACTz/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNdjJAAoJECTWi3JdVIfQ+Q0H/iHobjrsp6F9A0h97AGTEmlV
PojfA/wsywYHTlUJSsGiBWBcoOBE6V58P/QVZ+ka0y+ZaGCZ9itKoBpOT4deVJQC
GlWWOEGsT0oF9DsGZNVbJnXXnlEyplWB7TUqGX2ZPmgXg7DaS9iYEQsh6DBKCfNE
k7VbehH6s97f5XsRFwMFBSC1EzQ2aCJfCc3v62/T+6bDH1K+agXNm4x2OtYD0ulL
FkSUGC2hnIN7qWCCrwMmZ8a6nRkgGpb3zclIbBGtkO45EobCtzi3xpTw3Vb3bH5n
0/ANwq4bcxo7KyfVtffLqv7ra/q74CHxW3yx80tQPXE3Kc0YZwP8O/OZl3ADMgU=
=4uBH
-----END PGP SIGNATURE-----

--teKjxxMjPsACTz/N--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
