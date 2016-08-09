From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: dw-spi driver bus number
Date: Tue, 9 Aug 2016 11:51:32 +0100
Message-ID: <20160809105132.GI10383@sirena.org.uk>
References: <1470712490330.33016@dji.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3Shs6nLsUBL77Lfu"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Edison Chen <yongsen.chen-dS4nfl7sBO4@public.gmane.org>,
	Fang Yingju <yingju.fang-dS4nfl7sBO4@public.gmane.org>, Flare <jiaquan.su-dS4nfl7sBO4@public.gmane.org>
To: First Light <xiaoguang.chen-dS4nfl7sBO4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1470712490330.33016-dS4nfl7sBO4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3Shs6nLsUBL77Lfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 09, 2016 at 03:14:51AM +0000, First Light wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> but pdev->id is not initialized, it is -1 by default. also there is no dts information for this driver to init bus number.

> I know pdev->id is used frequently when dts is not used long time ago. is  this out of date?

> should we add dts to pass bus_num to this driver?

No, nothing should be relying on the bus number anyway and it's
certainly not something that should be part of a description of the
hardware - the expectation is that if things are using DT they will be
using a dynamically assigned bus number.

--3Shs6nLsUBL77Lfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXqbWzAAoJECTWi3JdVIfQ/PYH/RLwSUkaeOc7KJfVRj4J5piH
VZ7QuvGcccdOC/KwCxyDpihWFAHfCs9ODRHrQq+0fX7HqihiN6j9JHgRWdUWhRIV
/dRQlzHQBtCUD6J72AT7lmd0465O/rnYj/KhOa7P19DMqHfOYvjs3zoJQQbNqRi0
HFZGToRfQv/GC61V7z4W+Wcgi4s9M+bVIRJpoR6SzaHTVf3innUGZQ4DwFiMPliD
9pfBsSWEuiGKq1YQ7HfuXC8qAB8Dz+7am3JW9erewn8K7PVbqDluGEkoIqO/nYX9
StsQq3Espq2UXD2pZxoBDSakZS28WjTeB7aos7OL/K3yKRizuFj0WL4yanwZfWQ=
=TTqh
-----END PGP SIGNATURE-----

--3Shs6nLsUBL77Lfu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
