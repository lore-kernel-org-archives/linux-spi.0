From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] SPI: control CS via standard GPIO operations instead
 of SPI-HW
Date: Sat, 7 Mar 2015 10:50:52 +0000
Message-ID: <20150307105052.GA28806@sirena.org.uk>
References: <1425487205-5477-1-git-send-email-kernel@martin.sperl.org>
 <54FA8EB8.9090102@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Cc: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54FA8EB8.9090102-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2015 at 10:38:00PM -0700, Stephen Warren wrote:

> BTW, you forgot to Cc the SPI maintainer, so he probably won't see your
> patch and apply it.

Correct, if something doesn't end up in my inbox I'm not going to look
at it - see SubmittingPatches for the process.

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+tgLAAoJECTWi3JdVIfQtkUH/RYu0IACVK3a9+rGWmAEuDBN
F7JyRPUPA58Rn7lIy+YVclhb6qBk3DSAVzxkzWt/zC+qwg6eQF9/l3AGS3lz/Wlu
LsE5CTyUFMC1mP8+DKQBfVtwPH6aj2KX1wi01cNZspRSX+c017GtD9Gkn6gwk9PX
iH2dMZaPogqo7NUfZtEk7mY5w91Mln8Iiprfg+mSY2WKRVsQoTOkmNou5eequnpP
KtLxZfoLTDfUVgdR6dEFBhW0VhCCbJXxxEjXfbiB7/V6GYsHzBfBOhhk9EbNbGs4
yGADt/KsjRTj1mZdK70ZWTEPMXlZKTo4rlMmhE/EgmYgpt7hZOHZE0jIz5M8GjE=
=KeZD
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
