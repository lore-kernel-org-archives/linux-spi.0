From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/rockchip: Avoid accidentally turning off the clock
Date: Fri, 29 Aug 2014 12:08:03 +0100
Message-ID: <20140829110803.GO29327@sirena.org.uk>
References: <1409269428-24680-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMHqbYJb993HXwLR"
Cc: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	"Jeffy.Chen" <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409269428-24680-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XMHqbYJb993HXwLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 28, 2014 at 04:43:48PM -0700, Doug Anderson wrote:
> If our client is requesting a clock that is above the maximum clock
> then the following division will result in 0:
>   rs->max_freq / rs->speed

Applied, thanks.

--XMHqbYJb993HXwLR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUAF8QAAoJELSic+t+oim99kIP/3uRNvfVY4neyrcFLxk1xnYG
3JU3o5OVMkWVN1ltT7fh18ukOXO9S2MGXzBSHbHuhnt46iqJx1pJll+8eftzrPJZ
zYyoubftXWJJquP1Ih+m4sicqMw9BXkWbfUt/i5pWwGvjGbwAZFPAwe83PXMx8YU
LFApMDg9+GX/QNrkjZfFiJwH9s2bsioupDBMtMeL5rxecGWgE5fSXd5JRyXuVCF7
X5k3qVIr/ulBVv/E7Mpt5IbJjlTAGEfObOuH6t8hu3xs3hP6riG345XTTV2HHSek
b6fuKmgcLOh/pOA1cXoCzqHdAc/X690m8W6y/U30YlOoPa6+wyLmMY1jclr26Kx6
os6poTlUEHPYDXrTzYMlae3TF64lrSMTNHRxHQNoAfA8B17bLOkzqNrrgfH/BTxK
I/3tzvJq/9z1+bjzK4bv06OCkfjwmN7TCehVWeO+A7MBKOm6y3E83c6003fwb2eb
JO6KOt959b8fCoNCXhVBJpu+5dEAFRoo0GziFEJLEM5HttCGhuH6Q5ilJlqakK2W
rwyCoqyunqFxt/CiT58KANfRku0Q2UntXIHj+1M449EE2XEQTHUPaSaN+SXYqho4
n9R5UH3y7QeAMUnczG3iTxJTMVHBsyXjSKi8uPZMagfgbPN3HTC2dqJzb7+vw3of
+ygK23mpVXd2kgAyHLbU
=Rg55
-----END PGP SIGNATURE-----

--XMHqbYJb993HXwLR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
