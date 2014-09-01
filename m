From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: dw: Don't use devm_kzalloc in master->setup callback
Date: Mon, 1 Sep 2014 17:52:49 +0100
Message-ID: <20140901165249.GI29327@sirena.org.uk>
References: <1409460426.31873.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jVH9MMcXWLfwoO6"
Cc: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409460426.31873.4.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--9jVH9MMcXWLfwoO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 31, 2014 at 12:47:06PM +0800, Axel Lin wrote:
> device_add() expects that any memory allocated via devm_* API is only
> done in the device's probe function.

Applied, thanks.

--9jVH9MMcXWLfwoO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBKRdAAoJELSic+t+oim9yyEP/0KljKfJ3o0KnM6CUoor9ARG
zkp4M7EERBI8U7ED0EiVWePGhMbdhVHpEoJmG+aRN8OwKa2QyNduFub7+23rwT9m
3XDIUFWM6qI4h3OmNNOFlAK+AQXN84XEEewekIqZ8OKeEoJMPyW0K47ddEsZmkHi
3sRi8OnU0SB6O4IMpVLGwGWtFss5yeR/raDZj1KwAzr7NZIu04MBMPpotniC8GPX
knp8xU/32/AAR+coIMPg3qMjUBNpIeqJ7OgjNu3xue24zD1NXE9T//7dRj0qYuN6
ZGbyGF1QCYXqDX/OtMKoMNR6yB16rjow5fIFCPDvYCG20nPeYI33d3ftW//G+5Db
IO/LR8LsqfYSRwMwVjE9MyZNEYD5tod4tOL6UGhkL7jil9bwCWuVAqpuwRkwaFnV
AFw19afX2oqQn+RLnRxpSduI08NuuYJ1vJ43hCY8KT1SqNB0q9OuIqKwRTZgZWLc
qdG3kXa2JdoJK6eHb6pRdQ4Mh//aUnRQf5AmzzNkWnsXsH2eECVAg16sn1Ai+Ef3
rCzGj+A/f83HmFP0ahz3IDxiIUJmJhLTWb8IS8FG3oDbXTkgnxVIZ6QfMTavY/Po
0apCNlXeNl1S5ACCglEXXtMRBq3KZZ7/tSPfpvv09VrOk1csofYOLeBoxvbejPFz
1unG5BupR6nY2M8WSKSX
=xZ6j
-----END PGP SIGNATURE-----

--9jVH9MMcXWLfwoO6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
