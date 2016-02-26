From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND 0/2] spi: sun4i: add DMA support
Date: Fri, 26 Feb 2016 21:15:42 +0900
Message-ID: <20160226121542.GP18327@sirena.org.uk>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kHzaMwHKMzpKYIjS"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456466217-6793-1-git-send-email-plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kHzaMwHKMzpKYIjS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 26, 2016 at 07:56:55AM +0200, Priit Laes wrote:
> While trying to get SPI TFT screen working with Cubietruck, I noticed that
> at current state driver didn't actually support SPI data bursts bigger than
> n bytes (n is probably ~64 bytes).

If you're going to add noise like "RESEND" to your subject lines (which
makes the visible space for the actual subject smaller so makes handling
incoming mail harder) please at least make sure it's true, you've not
sent these before.

--kHzaMwHKMzpKYIjS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW0EHtAAoJECTWi3JdVIfQzU0H/3Ekg2Gl7jBrRW/aDtyVRJx7
u+Y7lmHvCuNlB0fhgMk1yYqfrMOTkGqbtSlyHo3rYSY1ZYbD10cXdkPArerXCEj0
WAQ32uQchJdzuOEkhQ18M4PSau2rWhjpxqpvZNev9rgAoxCRtbnO08W7TvB39WjC
+O3YrAF4qND5b6XykH3Np01D0rLorCELA1AIymwI3iZqv5LgoRO4IuoOxwnyAhtk
M9SdIpFw0vCeGKEIOxL9YbchHM8AG54ObXNq5ffAPFlolE01w4zlFC+cuHz+QjJt
gM9kLkdI/xIvnieOeMD6SkQKl5Ifr7Q/0GzB5Z5sGNTQKlC4XiKS5Guh0cDQ8Yk=
=cZA/
-----END PGP SIGNATURE-----

--kHzaMwHKMzpKYIjS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
