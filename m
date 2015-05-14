From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm-mspi: Add support for Broadcom MSPI driver.
Date: Thu, 14 May 2015 20:08:23 +0100
Message-ID: <20150514190823.GR2761@sirena.org.uk>
References: <1431452293-16697-1-git-send-email-jonathar@broadcom.com>
 <1431452293-16697-3-git-send-email-jonathar@broadcom.com>
 <20150512191718.GW3066@sirena.org.uk>
 <5553E31A.8060309@broadcom.com>
 <5553E9FA.4070708@broadcom.com>
 <20150514103144.GO2761@sirena.org.uk>
 <5554E715.7070203@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vtBqmokgY1evbO3C"
Cc: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5554E715.7070203-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vtBqmokgY1evbO3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2015 at 11:19:01AM -0700, Scott Branden wrote:
> On 15-05-14 03:31 AM, Mark Brown wrote:

> >Chip vendors often say this sort of thing and then get surprised by what
> >their users choose to do, and even if it only ever gets used with flash
> >all it would take is some new flash command which can use full duplex
> >for something.  Please write the code so it at least tries to handle
> >full duplex operation, if you can't test it fully that's not the end of
> >the world.  It doesn't look like it should be particularly difficult.

> Yes, there is always room for improvements in code.  In this case - it
> really is not worth our time to add code we can't test.  We try to deliver
> code that we can test and actually works.  Yes, if anyone needs to use the

While I try to not apply code that has obvious problems with silent data
corruption in it which is what we have just now.

> mspi for full duplex operation code can be added in the future - it is
> software.  This block has gone through many generations of our SoCs and has
> only been used for this purpose - the bootROM boots from this SPI only.  It
> is dedicated for this purpose.

All it takes is one hardware engineer who sees a SPI controller and a
GPIO they can use for chip select; I wouldn't be so sure that nobody
ever fixed this up locally (or happened to use a device that only needed
single duplex).

--vtBqmokgY1evbO3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVVPKmAAoJECTWi3JdVIfQcZIH/3Qt4z6w2+tZTbnG0h6yKDYW
W4P4pKqRyLPVVm1mLEDIJ1inJQYem9uEeBLEBQASHYe+l1nHvGCKH552IIeYmFrW
XymK9odV7t8FW3fjS3NSX0wrvv9aGdtkBZif1Kivz+9DY5aw9jifGnclwLfSzCy6
q5JCVPNB1CyKKNyKztraMtzvxDnNJWhqWUO9frssWfRvIBM7Z8v7FIg8IfZoHlWe
dsD4AnWSg2JrfDdgWPZrLDMtTWmebtCiR3YHO0uBufIxvvYw9WhcI0sYcc5590g/
yqyZeOScc1roitgm5UtQQBd0owTrlM1ohi8s8mqybftpOGmZsaW/nc5VDRjWnj4=
=2uLb
-----END PGP SIGNATURE-----

--vtBqmokgY1evbO3C--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
