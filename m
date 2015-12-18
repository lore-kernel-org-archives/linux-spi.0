From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 3/3] ACPI / spi: attach gpio irq from acpi description
 to spi device
Date: Fri, 18 Dec 2015 08:01:00 +0000
Message-ID: <20151218080100.GU5727@sirena.org.uk>
References: <1450163493-4938-1-git-send-email-christophe-h.ricard@st.com>
 <1450163493-4938-4-git-send-email-christophe-h.ricard@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pdljsUaSfr6a298O"
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
To: Christophe Ricard <christophe.ricard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1450163493-4938-4-git-send-email-christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--pdljsUaSfr6a298O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 15, 2015 at 08:11:33AM +0100, Christophe Ricard wrote:
> spi->irq was ignoring GpioInt property setting it to -1.
> acpi_dev_gpio_irq_get returns and configure the slave irq according to
> the acpi slave node description.
> It is now inline with devicetree behavior.

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

though it seems like we might want to have a common "get the interrupt
for this ACPI device" function here.  OTOH there's only a few users.

--pdljsUaSfr6a298O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWc707AAoJECTWi3JdVIfQC0oH/jqg+hVmbw4J+U2rAGTw0Bbs
ty0KfmNwhrGeoVhap1NwyTzsat+e6wyPyZ43Dp5lIXFwCE8+nPLpVZ129clcYZO+
VPvh8NqXK5teXVocJ/PnvG7cK7NHxguTIAJzQynaJ9GZSVSb9iyEzY+2oLeMtXxh
kRnzp0CSa5/3/8LIhaQyxDhMH77xv9nB7PyxpHdMhGT7pa+CAEAxexrTk9xmPBjD
8TG+UpVwwvkYKH0KCS4gpHWTsShDV5nUBRpg4Xd0auiDOtLRnNdOtqcsv8Uf9nLk
Cwdg9Q0fBXWInf0IbVpnnTQ6SEWGlL+oPG2yB0SZYWyTIcNhT+PJNYLMpb8MzdA=
=RlAY
-----END PGP SIGNATURE-----

--pdljsUaSfr6a298O--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
