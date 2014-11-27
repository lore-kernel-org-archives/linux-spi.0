From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: st: Provide Device Tree binding documentation
Date: Thu, 27 Nov 2014 13:00:53 +0000
Message-ID: <20141127130053.GW7712@sirena.org.uk>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
 <1417088636-11994-3-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mv22/3EYgOJmG2Gb"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417088636-11994-3-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mv22/3EYgOJmG2Gb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 27, 2014 at 11:43:54AM +0000, Lee Jones wrote:

> +Required properties:
> +- compatible	: "st,comms-ssc-spi" or "st,comms-ssc4-spi"

What do the two different compatible strings mean (for example, should
ssc4 be used for version 4 and higher or is it just a quirk for that
version)?

--mv22/3EYgOJmG2Gb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdyCFAAoJECTWi3JdVIfQyZkH/jf2ZF5qoC1l32gbd1cJ69YV
k/Gne/q1Idfy43qupB73e5HonqJ4e448EImpxQSJ38TcY7xuaP3KE1zsRCY8c6VF
ai7x4si1ejQ8pzqncY+BpjcP8sR9y8oHPOEHcYPFL+myfUHxJvLFVYRNXH8EM0hK
AAKF1qHqq/sAhyiRDa1lRICW0fcO+8s4DOu451GrqUEdixxUn4Uf/P59FKm1587r
R4IUFfN7RMRd6R0jc+0YxLFC8FH2bc9pz2SVN28W8QaRGzJ9CYGfu9QyOGlxrUJt
8Zd7PV8mVRccAvbVuD/1XfXpIFRexipJKPMpbNz32UasNJM49Bw9U/AwgC9B428=
=gWma
-----END PGP SIGNATURE-----

--mv22/3EYgOJmG2Gb--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
