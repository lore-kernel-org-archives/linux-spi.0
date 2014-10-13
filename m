From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/12] spi/atmel: use dmaengine_terminate_all() API
Date: Mon, 13 Oct 2014 12:30:20 +0200
Message-ID: <20141013103020.GH27755@sirena.org.uk>
References: <1413041973-28146-1-git-send-email-vinod.koul@intel.com>
 <1413042040-28222-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nSQmAjgQTjpDdTby"
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413042040-28222-7-git-send-email-vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--nSQmAjgQTjpDdTby
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 11, 2014 at 09:10:35PM +0530, Vinod Koul wrote:
> The drivers should use dmaengine_terminate_all() API instead of
> accessing the device_control which will be deprecated soon

Applied, thanks.

--nSQmAjgQTjpDdTby
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUO6m7AAoJECTWi3JdVIfQmjgH/RgCPG7dptur9uhOE2CrbMfF
be8ufFhosYhZQWknXMWMgEZwO8HLQTkKZ5QOHRsstR5Ri/lTfmdJyFgIxWKf0p/Q
M5NspL+9lLZ3QDWm+VXtpd9/wh+vetKffdRq1qy6k7WYJAH8iYcy/d3iyi8Crmb7
7rOEQCAL3gE3kUZuxMpHnSCaVRXd/I1HY5auRqOVQApHPkCOqPRa3cQw8Dzg6/FZ
i7WTIW+oOzAJunZq3cxz4CoIJKnub/ab80aVaLVSpxaIy9H8myBlMOY4SQL7usaM
wi3beQK2hZxQmv7rdnZbxF/HXjCepTdwM/AaCqpx6dSCcIgFQxWcqZ8Jead66rU=
=kzFp
-----END PGP SIGNATURE-----

--nSQmAjgQTjpDdTby--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
