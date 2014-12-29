From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/spidev: Convert to use unified device property API
Date: Mon, 29 Dec 2014 16:03:16 +0000
Message-ID: <20141229160316.GO17800@sirena.org.uk>
References: <1419846074-240217-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E0e4ihfNxLmjeTLW"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419846074-240217-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--E0e4ihfNxLmjeTLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 29, 2014 at 11:41:14AM +0200, Mika Westerberg wrote:
> This will allow the driver to match using DT compatible property if the
> device has ACPI _HID of "PRP0001" and accompanying "compatible" property
> listed in _DSD.

Which nobody should be doing since it's already totally broken for
something to be using this on the DT side except in the one case of the
Rohm device which is listed there.  I don't want to merge anything which
allows the breakage we're seeing with people putting spidev in their DTs
to be propagated into ACPI, at most we should have something that
specifically identifies individual devices only.

--E0e4ihfNxLmjeTLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoXtEAAoJECTWi3JdVIfQtFQH/RWVQu+hAR8vPuKzMwIcllNK
BmlpZlqV2mxJQ7hyt8DOQuYp7J5Edw9XexIQefE5b/dEiAZiuOPOv3J+m0MQM2+h
mY/m9o1aZzJ+aLIlNoSQhp9cTDX9DZnX9mohENaUZgpvGkAjvVqEDdUs/gwDlD5a
dlPVzxMHI/o8VeW+0caSxhRK/ZaFsRdyxqElb/LmP8njtNzAvM7R9Ntar3MJ6wCN
18P/INpQtsNxPHvAanc45pLn0oGI6EUxRrxxwGJkO33oHeuGkYbX667hm2xkQIdE
5t68HlDb5iKS3jU8ivktixpoRRmOYHjwjUBBBhMQgn0pALn9o0W94SZOXHnchmg=
=JGH5
-----END PGP SIGNATURE-----

--E0e4ihfNxLmjeTLW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
