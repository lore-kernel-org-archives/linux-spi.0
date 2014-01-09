From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Check conflicting CS based on spi->chip_select
 instead of device name
Date: Thu, 9 Jan 2014 14:06:46 +0000
Message-ID: <20140109140646.GT31886@sirena.org.uk>
References: <1389273835-8615-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x0RaPWQfynZ8U26R"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389273835-8615-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--x0RaPWQfynZ8U26R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 03:23:55PM +0200, Mika Westerberg wrote:

> In case of a buggy BIOS that lists multiple SPI devices sharing the same
> chip select (even though they should use different) the current code fails
> to detect that and allows the devices to be added to the bus.

This actually also points out another issue - if we have two instances
of a device on different buses they could end up with the same
dev_name() if they have the same chip select.  Hrm.

I'll apply this but we'll probably need to do something about such
conflicts at some point.

--x0RaPWQfynZ8U26R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzqzyAAoJELSic+t+oim9B2AP/RMy0fntr0+gZ7FM2MBrhZb+
A/c4phbh0YmLthdbHX7lk3Vtg4KtwcxAW097EgVZ3JxL29xroV9NPBJ4/qTVcOsZ
EJkT1gX0zVyFd9Uck9aPaPRm4Wmkxw5Lctgd9Qxk9qeceib6oAyPV7ZaxV4MtTxJ
FuWYcTBizqbIKapnasm5EMeXwv+m9xH5sRpWiX53EBv2zUal6hqnmoByGw5t8cgl
v+o8Gn5rVjntSAyTF64xVVX80cFgaP7/kaLKs2eyiu2f8ptkv2LAxnhYNiDtQnve
6CCVTZuIkSL9WdnMabJZGDJd4uwF7WjHU/UrUREA3yI/1yHy1boU6QUO1WPvZpyg
skhaq0azms/WgBI3CKiScgnA9J2s3XyjkD8AdB80kpvAWUjh6ROhiW6xwYgPYtHa
utx3Bt1jIuDMozVFOg4rdTWhmiiwgbEnKUhkpG95Pkf4BDE6yKMInkjaKQdXxQoP
E+nbhVgeRac5BMa96x78GnK44w4upuo4X+BzV/vWS7gxFdgpYVz4Dy0sZVSbqXJ8
IcQsC90CJz9K1OnTY8PICFRk9nNESfx68VIcZdmdvPR5o4pshiABabnIIrqpWBJV
1usXHAvcLGcv+CTP6yP+aFbPdKBIdX/ScLKiNJbgIB3yckcdSoor1IDPWqqArjVW
D0AFo1YJAgLX6ugRlXUG
=j2MG
-----END PGP SIGNATURE-----

--x0RaPWQfynZ8U26R--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
