From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: add xtfpga SPI controller driver
Date: Wed, 12 Mar 2014 01:11:16 +0000
Message-ID: <20140312011116.GJ28112@sirena.org.uk>
References: <1394541891-26469-1-git-send-email-jcmvbkbc@gmail.com>
 <1394541891-26469-2-git-send-email-jcmvbkbc@gmail.com>
 <20140311194959.GB28112@sirena.org.uk>
 <CAMo8BfLTn+pneF6_7XkP66+LzpZgcefnAo_FkwxpvtYdt9yduA@mail.gmail.com>
 <20140312003401.GE28112@sirena.org.uk>
 <CAMo8Bf+dePYf0jW6zaH-4Qiy5oF-bBzHjkfzL1u6pyTS1OE46w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IaU6t3Sui9pnIBPM"
Cc: "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>,
	Marc Gauthier <marc-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMo8Bf+dePYf0jW6zaH-4Qiy5oF-bBzHjkfzL1u6pyTS1OE46w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--IaU6t3Sui9pnIBPM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 04:59:47AM +0400, Max Filippov wrote:

> And tlv320aic23 has the following regmap:

> const struct regmap_config tlv320aic23_regmap = {
>         .reg_bits = 7,
>         .val_bits = 9,

> and its SPI interface accordingly does the following in .probe:

>         spi->bits_per_word = 16
>         spi->mode = SPI_MODE_0;
>         ret = spi_setup(spi);

So I just looked again - the SPI code isn't in mainline, there must
be some out of tree patches here that can't have been tested since the
driver was converted to regmap (or the byte swapping you're doing in the
controller is buggy for 16 bits per word).

--IaU6t3Sui9pnIBPM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTH7QxAAoJELSic+t+oim9sAQP/j30vaX/EyFbjLRGQOkM4erp
43sZ823B1uKTDuYgrDq8TxjwpjDCJmUPy1YiUghaJB/1DhrFeRePXDYq9M9d8kku
ld9Y+dCQD+ybZuQKK0ZbGaTyGSsKCVQ/+TZ/hkMDQLwXAhQmcYpIb5/1Cf9765hS
AjdmeHe2CN75XPGq7k0HvWPYjY9zxeJqaWgkorkxlVVjQPQ6U5V8SJrvDSmbaUCv
GR6UBGZNhm3bCIgdLW/IJpwGWWZTThMe3tPHFaruGQyXRNMC0zP6T3rimp/VKP3n
+SkavK8nipAqJOo1eVCiEyCbhBJMZIBAbOLwQE5yQI6qYOIxVaSdtRQHptbqRjPp
ectG//6fUFVL0zHWm1OqoZ0V+mFOW/N4hxXgRjKpxvrbNNAGC1i4hLQ/741PvNIi
aJ0B80y1ttcEjYdYtuklruQ5fxbtoKY70942wM0rle3/vNts7BF2MLhS+m81VfM0
sWWfzBwrYRrOZKebShuiQW+jHKw+s3fRBi3N80U2s0Eq8BDRVmQEB6Ovb+Y+GzXD
eNKOyZv90naZpKS7hxnfVbvQm3y98fen5a2wycTeEoJZdzLcWGSJr1gLX4z+jWs9
FOlylHTujawdnQKsHxjpTVvONY2Bf98PptwCsX8ch0AjpvsE2WwtpbfOJF87IHFz
azfnoE1KaWrCch2nBUl2
=6HCY
-----END PGP SIGNATURE-----

--IaU6t3Sui9pnIBPM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
