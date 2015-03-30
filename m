From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/1] spi: Using Trigger number to transmit/receive data
Date: Sun, 29 Mar 2015 21:30:49 -0700
Message-ID: <20150330043049.GE1568@sirena.org.uk>
References: <1414034053-14750-1-git-send-email-cm-hiep@jinso.co.jp>
 <1414034053-14750-2-git-send-email-cm-hiep@jinso.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Cc: geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org,
	ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414034053-14750-2-git-send-email-cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2014 at 12:14:13PM +0900, Cao Minh Hiep wrote:
> From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
>=20
> In order to transmit and receive data when have 32 bytes of data that
> ready has prepared on Transmit/Receive Buffer to transmit or receive.
> Instead transmits/receives a byte data using Transmit/Receive Buffer
> Data Triggering Number will improve the speed of transfer data.

Applied, thanks.  It'd have helped to be more explicit about what a
"trigger number" is here - it's not a commonly used term.  "Trigger
level" is more normal.

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGNF4AAoJECTWi3JdVIfQK0UH/1QOQfOb3gz6gxmdpBTksck6
nVFWHbq0tiGXv3KIq1ciUKRRCQD8mcwb+WDxFPf+NPp8gJwINyTPgUENHn13JVzj
vgMZzcHl85KpDkLauh74SLSbn8kmlVToF0WrCjO0n8345GvWxE7tMcRUYiyKfE/X
xdZ/abeRvYLXNg5nXsJFNq7JVWS4FiDHIpBQLivd4qBZRRu9p1OIwrKHE0QL/qKZ
Ma1tg9VxvAlz5aAxDNUcBmzrzzntkk01x5TS5sG0HvRC4HVF1fmoERNJShCrYQtZ
mndWmYmySnwrg8xY4E+EU6DtVhTXW+viEJefOLr/Fvd+QAL4rW9ob+SFgxafPQo=
=acKP
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
