From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI: Add driver for Cadence SPI controller
Date: Mon, 17 Mar 2014 13:14:53 +0000
Message-ID: <20140317131453.GF11706@sirena.org.uk>
References: <1395057936-8643-1-git-send-email-harinik@xilinx.com>
 <CAL_JsqKacetGytGUJir7ky3qOgCy-3ny1pT_Bx4eCYV2wMgcTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
Cc: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKacetGytGUJir7ky3qOgCy-3ny1pT_Bx4eCYV2wMgcTg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 17, 2014 at 07:47:24AM -0500, Rob Herring wrote:

Please delete irrelevant context from your replies, it makes it easier
to find the new content.

> On Mon, Mar 17, 2014 at 7:05 AM, Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:

> > +/* Macros for the SPI controller read/write */
> > +#define cdns_spi_read(addr)    readl_relaxed(addr)
> > +#define cdns_spi_write(addr, val)      writel_relaxed((val), (addr))

> Just use readl/writel directly.

Or make them static inline structures which take the driver data
structure and an offset within the register map for the device and do
the maths to resolve the actual address.

> > +static SIMPLE_DEV_PM_OPS(cdns_spi_dev_pm_ops, cdns_spi_suspend,
> > +                        cdns_spi_resume);

> > +/* Work with hotplug and coldplug */
> > +MODULE_ALIAS("platform:" CDNS_SPI_NAME);

> Not sure, but I don't think this should be needed.

It won't be used by DT systems but it is good practice, especially with
something like this that clearly is a generic IP which could be used on
non-DT systems too (it's not like it costs anything meaningful).

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJvVKAAoJELSic+t+oim9NoMP/3CVL2JtmNVGnAlppFjd9mMJ
LtioqcpAiBYfuq/ayoHIQ1JaZYmjTPMvMty9TFetCAhGy2g6lFnlNll15vtnKj/g
Y9El2X3L8HwNw48jkcV180vBxi5yxGtWjoaM4o1wCewsTwhNiZwC5F0M/ytagORb
BUJgptmgAv9/dF1Nq+nxJONmJ8avR48PKPeY06950oWtrwWFNJ05g0yC04ZQCzoF
w3yoPdYXQANLT4HMI4St7qVu+CO6+q/0u+sqB9Ugi5aQijF7Q5kA7/mZHxtXAvif
mrBHru2O/Qh2E76rzu98xyq79IJ8Jb5vYR+hLauvPsO1wB1xmQ+iNu8bZc62fyId
APABMGlqcB+o/PbbQ1znnAjuaXWOs06nIGv62MEpI1ar+vrwgwVVow/rc8FN9K5o
OrzSYSdAR71CmLnW4upTnOsnV2TyBrwTEFt4cLQXsXWuo4g7Qg04DbPmILS5UYjM
NCkww40V+lnETl/IWUeVoIYzm+hU6Nr9J69oKAmt6XKbTkWl7lk4LQGM23rN6/po
4+ui+gkkHzeJfJS3RQGZNi2QVxjPWV6IEbBOaWVaGmxOPmI/CH5JS331pwSSLY0S
2oaY0MgLrsmtLACJn3G3iFfJ5PLalenlr1JKERm4LTCwLgvcLtVdQwSMn7kjhCFL
K5N9uzM0yG3kkWZHuQTJ
=ISNL
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
