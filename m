From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 4/6] spi: atmel: use atmel_io.h to provide on-chip IO
Date: Thu, 26 Mar 2015 08:38:55 -0700
Message-ID: <20150326153855.GP3572@sirena.org.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-5-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+W7ryvxEk4RRyt+P"
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


--+W7ryvxEk4RRyt+P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 26, 2015 at 11:45:52AM +0000, Ben Dooks wrote:
> Use <linux/atmel_io.h> to provide IO accessors which work on both
> AVR32 and ARM for on-chip peripherals.

To repeat the feedback on your previous big endian fix: I've not been
CCed on the cover letter or any of the other patches so can someone tell
me if there are any dependencies or anything?

--+W7ryvxEk4RRyt+P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVFCgHAAoJECTWi3JdVIfQ180H/2nyEffGWj39E3ReOua3f/1n
cYFxCp2UKsblkjHr5iVXFl7rdcK7jJLVqcgUwId7qJRd1LTIbQ9Ke+jqw4xnhfCE
rjIo9sPjfnzpkHu7MuQvDsIuYtbv9TJUGyjFxLTtHxtoBEQxzR0NguTbCegIBTQx
OabBOd7TQS3xvqsALSzEqfKudhcEN2oYh32yshZsBMuyS66Hmb4RAS8yUhMLDr+Y
hI7GPDTGvOrUny/fei3SSyCzOdxZI5q2nF4ggiyqu0YZMzlwXyjRXX56wBsxB175
ftDtYG0LtDkKOreYbK0ylsvaogR+VedYlHgoxrxgzqwjuqS/642anmexJ40QN0E=
=5JxK
-----END PGP SIGNATURE-----

--+W7ryvxEk4RRyt+P--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
