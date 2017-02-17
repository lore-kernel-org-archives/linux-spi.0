From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Add possibility to define bits-per-word property.
Date: Fri, 17 Feb 2017 10:11:51 +0000
Message-ID: <20170217101151.hyzmz5a4lgdy7p5m@sirena.org.uk>
References: <20170216133910.18278-1-adrian.fiergolski@cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rynao5wyzq4m4r6q"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Fiergolski <adrian.fiergolski-vJEk5272eHo@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170216133910.18278-1-adrian.fiergolski-vJEk5272eHo@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rynao5wyzq4m4r6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 16, 2017 at 02:39:10PM +0100, Adrian Fiergolski wrote:
> Signed-off-by: Adrian Fiergolski <adrian.fiergolski-vJEk5272eHo@public.gmane.org>
> ---
>  drivers/spi/spi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Why would this property be useful?  You're also adding a new binding
with no binding documentation, binding documentation is mandatory for
all new bindings.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--rynao5wyzq4m4r6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlimzGYACgkQJNaLcl1U
h9DEeAf+KDMQDmQTAgEV5+kwXkN6PofPcloNYDdrHMBetJhqKyg/Sdn5cnmP7AS7
jywXmn0l3SJoSIS0wco5sw3KFD51zP0FIlely4JV1ueC5Hozv746ESQyb6m6b78E
h3mRldlJTKemT75kOlhQ5EXoNntrJe8ftpTIuqakili/A3yM4S+hrVbNtTwyldjA
sPRtSCI9fBra9yYucCdbmiCXGaajgl9mVqRt5z2aFvRAHhey5l/qAXEpoB+khI1R
g/9lfTNqgh0DP4OqBUtEFwFz52aKbafZj5aX1cTNIP2pFl9k2DQNxNsOwycCDl1d
cf8l1xXxqj7iep13aObCpucj1BJg/w==
=ydm7
-----END PGP SIGNATURE-----

--rynao5wyzq4m4r6q--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
