From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: core: Increase timeout value
Date: Thu, 10 Apr 2014 18:36:16 +0100
Message-ID: <20140410173616.GC6518@sirena.org.uk>
References: <1397134229-2380-1-git-send-email-harinik@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DaTEgnRu5pEC8TLg"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
To: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397134229-2380-1-git-send-email-harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DaTEgnRu5pEC8TLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 10, 2014 at 06:20:29PM +0530, Harini Katakam wrote:

> Considering acceptable latencies, this timeout can be set to a large
> value >= 1*HZ typically.

> This patch adds a tolerance of 2000 msec in the core accordingly.

That's too much, it's 2 seconds which gets to be incredibly painful when
trying to debug problems - if you're sitting there waiting for a driver
to time out some operations (and it may be more than one of them) so you
can look at the diagnostics it can be quite aggrivating.  That's why the
delays are related to the expected runtime for the operation.  Something
like double the expected runtime plus something in the 100ms or so range
perhaps?

Ideally we'd use the actual speed the device set rather than the
requested one too, that'd help.

--DaTEgnRu5pEC8TLg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRtaNAAoJELSic+t+oim9LeEP/R9f6o0YW3zxWF++cgXl4c7D
n/AM00SOyDaMIwXJjjX50/mrnWz1V3HEbhZY799FjhSAVvhS+nR15RlZROzvfet9
bIIQ+8WCHFh2YRAqWk+pUzdOu+3iswKZ+4upEWXedGOqwL8BS2KIXrANE4JSsoTQ
8nmj8ch7wm31E6gjZTI0ykSy3+p0DnLpYM5vnH2sZPIXLXj0OzyKmy9weLvrEb+7
VFnzusSk0mKn6mNQgxOvFdgYudZ6fHne1x6rGhiu4fn+22ziRoA0k+lPWfngiEkt
z2xe9x9bQVbfTc9BcGI8E4FwggHtFqIULWYwXCivMuCFPP7n70UjS7sIwmv4ax7c
nlWwG8HLc7V0osuJGdcpHM4l3dvZa8roBh+XPmfAH+aNJvvHrLskYM9RBEllxdln
9VMGm4LpZ+03FIAB++b2ij+hEIaoKu78XHkBZo1keqkU4QMV49s//XANdXaryRTL
8Es4Yz13cpNUh1DzB1Wigpz0dBX7n5FByrXJ4y06z3+bqd0GkCFeIXF0yAi8s+Dy
vppFVzVtit/WBshSkn5ivuyi1nDI8yM9s3hBI++wEAnciLq0Ba2GIDQkRYLMho8A
WiSRWoyUFGBi9zOgItNfkwrlEIzKfb68nibCEbOlxXBxKYraTsDlQg0YpEvdzOK/
X1RaPkQOnDlhfQOXO8ZF
=8MsI
-----END PGP SIGNATURE-----

--DaTEgnRu5pEC8TLg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
