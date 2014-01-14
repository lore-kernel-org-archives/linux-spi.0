From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] fix module autoloading for ACPI enumerated devices
Date: Tue, 14 Jan 2014 14:41:55 +0000
Message-ID: <20140114144155.GQ15567@sirena.org.uk>
References: <1389686417.3309.8.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JQ29orswtRjjfiJM"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389686417.3309.8.camel@rzhang1-mobl4>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--JQ29orswtRjjfiJM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2014 at 04:00:17PM +0800, Zhang Rui wrote:
> On Mon, 2014-01-13 at 17:35 +0000, Mark Brown wrote:
> > On Mon, Jan 13, 2014 at 09:48:31PM +0800, Zhang Rui wrote:
> > > ACPI enumerated devices has ACPI style _HID and _CID strings,
> > > all of these strings can be used for both driver loading and matching.

> If this piece of code is used in an *SPI* driver for an ACPI enumerated
> spi device, the spi driver module_alias is "acpi:INTABCD", but
> the uevent of its spi device node is
> "spi:INTABCD" (PREFIX:spi_device->modalias).

OK that makes sense, but what does this have to do with the _HID and
_CID methods?  Surely we're just replacing spi: with acpi: in the uevent?

--JQ29orswtRjjfiJM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1UyvAAoJELSic+t+oim9bG0P/0goHARf3A90XHRUhgRTGYUu
RoxxvXItiqeVwx7IhjlB3cfaRTomiftiPyzthaVv4JiJkZjl87J+AsBiOuKS+t84
stHjPCAgaAM+VjX5NZZ5KJlslduei0Gi4DMC+t9p5agdMrzpYLTVtmu6oRzrgcFV
btfpNUin6fwthsw+5pormum0Ic8enZ86mk9NAOY6sfBCeJ+wIOsNrxtbhUEOOWlq
CqoOFEz+7oEu9ncZJrKFxpM6IOpyFabYsbME+MJjSc8pzJmX8jUCTk4JEEuOnSjn
m+5Qh0HvbuONoLTp9Ruy3orscCg4vgKYom8E4tbJMm7ugYgTGfN3Gg4vQf1rkuid
PrBM41OzeMBUBeQ8dho0MiS6xiUpAA9TsCYNxGYX1bbF2i8MYXpb/ZwXO8ClUSu7
4YDO+w7u0XHrmfapVz222EJQAhqDBSTDBT9JRUQR66PKnETFp0ffJeKD7uvQQcYY
WB0nQUQ8NEZt9Qz9J8oZCSGtdqine9hHsey/a72L2HQpvywghAHkncY/bNTgLHLT
UiDXfn92CqME2Kv+aHhg6AEvayOSQ0NS6/a+8WEu3+OInk4U3Xo4noAsOHOG5g7M
0Jx2TsKDhuZU5XJdXxPnh0GRDbLwoWwkaXKgTkFY3I4RAZOEkzjie+O8wDHmyr7v
qk7CKdXl9x4+Vz7uTK3o
=1KHM
-----END PGP SIGNATURE-----

--JQ29orswtRjjfiJM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
