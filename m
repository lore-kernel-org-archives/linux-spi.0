From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] spi: spi.h: clarify the documentation of
 transfer_one
Date: Mon, 27 Jan 2014 18:44:10 +0000
Message-ID: <20140127184410.GG11841@sirena.org.uk>
References: <cover.1390681463.git.baruch@tkos.co.il>
 <598dd86dc07d794d7cd19a3259ea71618ba150bd.1390681463.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PyMzGVE0NRonI6bs"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <598dd86dc07d794d7cd19a3259ea71618ba150bd.1390681463.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 25, 2014 at 10:36:13PM +0200, Baruch Siach wrote:
> Explicitly note the transfer_one and transfer_one_message are mutually
> exclusive, to make the text a little more newcomers friendly.

Applied, thanks.  Still surprised this is confusing but hey ho.

--PyMzGVE0NRonI6bs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5qj2AAoJELSic+t+oim9iK4QAJ49+2Sros207KACqb5Jshuq
4BwkvvvFN05FLuWY16skYegr6NYXtHZdbIzyLHfXPmPoMdf29U2vL1h/fMWOvXRT
CxMGL22ukrQEmnBcqGXEd6yrdZTj+8W3B7biDUCtcUJ3OwxPHwdMA4YiMFf5nA6Z
w3naaFzAaYEvETj/YLLEoRqZk7YVMwOo503QO0qE1BQodPIAzS9aJ4tIr2GQyliQ
nfqMVKPzfwLXky02R871vmENycGnaNuBybBjQ85COFD9aePvJrkkTKqrNF25bk3H
soH29wXzBBmtnuF6c5WEmx+2J8OPTMfCq/jJlD+BwcLNEtm4Rwxti4C8siaB3NpU
GW/RSptaYGjZMylwHrs8LIAHSEPKkzuZtqhV6LGpOe70Tf8wktoGHAg3nVLb5uC8
BNUx7e8S3FuBGUla9ncdrGcA2qtvkgnytjU9FT36giwhcwDhM/dPRNba02ycRqB2
kg0UWzUZyYGwz+oGOeJe2nFXURSGjWC+5A/FpOSNGzJec5qVYagc3bD9AQxydegq
g2Vd/IkGOgpmjDh6T01BtkQ8CZQ9n+JrKgDRF530ht6f/r9mNLGaSzYPJ/Xk1Dd4
ay5HHNY1MIZODij658P0T1e8qRtxLXzl1m04B8LjcVuJxsojcEGDHbeMpJ9u2Lwz
VugOmroVE/mNUijMprcd
=L+om
-----END PGP SIGNATURE-----

--PyMzGVE0NRonI6bs--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
