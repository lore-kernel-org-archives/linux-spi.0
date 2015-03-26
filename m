From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 4/6] spi: atmel: use atmel_io.h to provide on-chip IO
Date: Thu, 26 Mar 2015 09:01:14 -0700
Message-ID: <20150326160114.GR3572@sirena.org.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-5-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YttKMwf6abDJOSyE"
Cc: linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org, linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427370354-21247-5-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--YttKMwf6abDJOSyE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 26, 2015 at 11:45:52AM +0000, Ben Dooks wrote:
> Use <linux/atmel_io.h> to provide IO accessors which work on both
> AVR32 and ARM for on-chip peripherals.

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--YttKMwf6abDJOSyE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVFC1JAAoJECTWi3JdVIfQgRkH/1ASxKC0Ndc3zdT5/WRKjpO9
byheiJ9YyiwQUoG7ywCwdULI9b5Ajjlq8ERQRYZiq/vHCqHZza4AIeG2oF6wmQdy
HUQPqDeFBdNSTlzzKgKA//wqYut/RJyPQm7529+u9dXOy55xCsRwaBYeJYkasxn3
IEzM/jWCdduV3mhoeH3QYr3YXWCvYkMy2A5p5liGLqkvq1PVzeaqcdncfQO4UzNO
H6OLtbVwUdbrusL+8+cGOXwcH+d9UhDQZH3i57nFnlYGQKLcU/K7pxk4FB/DJGMY
laV1scBQ/RoDGdyzYIxbdTskfUHWV8Kl6YRG0alVL4P2XhtXYZmhErh7VMWwLog=
=nYAV
-----END PGP SIGNATURE-----

--YttKMwf6abDJOSyE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
