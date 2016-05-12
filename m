From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Applied "spi: omap2-mcspi: Undo broken fix for dma transfer of
 vmalloced buffer" to the spi tree
Date: Thu, 12 May 2016 16:44:36 +0100
Message-ID: <20160512154436.GE6261@sirena.org.uk>
References: <1460140995-4062-1-git-send-email-akinobu.mita@gmail.com>
 <E1apndq-0002S5-8J@debutante>
 <CAC5umyg2fJxYKOB4J96+3igkNx+eJs5MET8S8NnafZ3hcPPEag@mail.gmail.com>
 <20160511162030.GN6261@sirena.org.uk>
 <CAC5umyjoKfMBbO1JPyTjqsz4zuiZMQDZcKHxonZuEwqGpJxb_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="djTb5EnuS5qMpC9h"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAC5umyjoKfMBbO1JPyTjqsz4zuiZMQDZcKHxonZuEwqGpJxb_g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--djTb5EnuS5qMpC9h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2016 at 10:49:15PM +0900, Akinobu Mita wrote:

> If we have an optional callback to get the actual DMA transfer length
> instead of using spi_transfer->len for each spi_transfer in the
> framework, we can use it to determine the correct map size used by
> spi_map_buf() in spi.c.

That sounds plausible, we can also do some querying of the dmaengine at
the same place we call that when we get around to that.  Can you try to
come up with an implementation?

--djTb5EnuS5qMpC9h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNKThAAoJECTWi3JdVIfQLX8H/17iQu+bDiGwX2wCMv/lj5OY
NcQCwpd1BiyDPA3/E/kWL3U9OmxPFWtTypM50CmBvXSGlCnYil+QJlu3DI/lJ2oW
G3iflJhRS6zPk1YaLIVDZO/qR+qxUMKtjSfvSV/44JxEyrRrbw4ZljV109xZO3mf
l7cWaN5utY6Itl0ccVHqikXXT6u+n00blVDXK8H08Y3oMkDIN0d8mX/WMS8sYLjH
PAf4ZgyYYUSQVZEuhauaTAqDC34QF7Mrs+P0MEM/+J7Y8mmGfOUNGhQ8mJ60ceXB
HCJtNVUZVcoOUKkf0M22grfaS4IF/XOIpkZo+pcau/hue/C83w4Q/Wn0m68ezl0=
=9Pds
-----END PGP SIGNATURE-----

--djTb5EnuS5qMpC9h--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
