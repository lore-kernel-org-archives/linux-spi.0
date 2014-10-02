From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: dw-mid: change magic numbers to the constants
Date: Thu, 2 Oct 2014 17:06:38 +0100
Message-ID: <20141002160638.GV4273@sirena.org.uk>
References: <1412256669-14828-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BBw4iOnA9FNdCxVc"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412256669-14828-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BBw4iOnA9FNdCxVc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 02, 2014 at 04:31:07PM +0300, Andy Shevchenko wrote:
> Instead of using magic numbers in the code we create a bit map definition of
> the DMACR register and use it.

Applied all, thanks.

--BBw4iOnA9FNdCxVc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULXgOAAoJECTWi3JdVIfQlrUH/R818gi8/iStQm1s/EDK2Qjz
B2PnwKSD8dV1ucoASGxdYoV9d0CyJD9Hvby9j9RFWjvL9B7FgKFmzdUe7vvmWGbM
K/SZZmu6/k9psgpAt/jR1UmWKZiM2Eg8IEUeWgFMa4a8S9/q+gna/PUhePrCRFFT
f4Hu0wv+0O7smXnZF3fA5pjy3ZdRBoiauwW63YR1vZ+a4CEAuWTdVlFznrqEVZiF
wMOJJzxmiQVx7OUV3xSvsHSgnP0nTJuubZ0kr0j2bMnouFWl+KvC4CFpqJcUMHb3
nqOIhnRvRFRX4hTIojh99OvylLZ3IA+LqBDbvOnixdzSBcg8rjx6XQm6wf8ygaU=
=EZY9
-----END PGP SIGNATURE-----

--BBw4iOnA9FNdCxVc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
