From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI: Add driver for Cadence SPI controller
Date: Tue, 18 Mar 2014 11:06:40 +0000
Message-ID: <20140318110640.GI11706@sirena.org.uk>
References: <1395057936-8643-1-git-send-email-harinik@xilinx.com>
 <20140317173017.GW11706@sirena.org.uk>
 <20140317175911.GU18529@joshc.qualcomm.com>
 <20140317181440.GY11706@sirena.org.uk>
 <554ccbca-f92e-454c-90c0-b8a4ddddf3fd@CH1EHSMHS001.ehs.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oIPRF+aTX2m15D8D"
Cc: Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org" <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>,
	"grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Harini Katakam <harini.katakam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <554ccbca-f92e-454c-90c0-b8a4ddddf3fd-p/+QeVIcf1BZbvUCbuG1mrjjLBE8jN/0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--oIPRF+aTX2m15D8D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2014 at 05:22:37AM +0000, Harini Katakam wrote:

> > > > This needs to call spi_master_suspend() as well (and similarly on
> > > > resume).

...

> In case of a suspend, we are stopping an ongoing transfer and
> disabling the interface.  In case I add clock disable and anything
> else to unprepared too, it will be a cleaner exit but it will still
> stop the transfer right? What do you suggest?  Should we wait for
> transfer to complete or a timeout to occur?

I suggest doing what I said above and calling spi_master_suspend().
Right now what the driver is doing is just halting the hardware if a
transfer is in progress which will break any ongoing transfers.

--oIPRF+aTX2m15D8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKCi9AAoJELSic+t+oim9QyMP/jWiK6gxNUBgEjcdxAEcl69c
MkP/Jg7ix04sB81G+YQrjgwIvw4LWvqkL3aLwx2/ko2RvxlA5Ynmt9U79An28BVL
yt18j+hiPW74297eLkGmYE4i5vNa7U5a1O6kCLc9YCJ0ZGvpJy9rBCn8FhCPsYNz
l6KqJXLVwpalpZV4EzokDyrRi9y9Hurze9giCBrOq5NLEjm6X9wdGcgKanQPKiRm
4+Pn8Uu7DiTXuKH05QGWaOBkm3tHHybdPxl41JAoxKnWe+2CQf61tHyc83qEUFAP
UUCBjZodYMUTW92W+WzLcY88ab8PHYTNcncsihQiqETCC6+GHvp8nw8C/OIPc9q+
qEbXLWhJqYS4RcOzVjfnGVIMq58JVRAYQbsx5N+rgRpE/Iev5Qpde0H2Ebd1P6pT
S+i6xEh9mPDOExdfEshc+3IoWOgn+9ev60fNF8FN5v/dFFiPEH21t4kWlpj0YQJ4
a7rVsOuF3nIktByGxJcyJwrpiHqJW7oulRU8WurCJh2IDboLB7oltY82HRCmM6i2
LEwVEmyq9MmFg3jb3sPbkQsBfAPIwWZrbvUNVc0wQ7OGSUp9KMWOaNtUSixCTl7H
iBQZOpCEUXj/wB7E963vdv5YHPiqAwU/URpyY8HiisxOAiJpFrtYWSPRodt0GsLa
8v1QC8dSQRSy64nZqo85
=71yq
-----END PGP SIGNATURE-----

--oIPRF+aTX2m15D8D--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
