From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 2/2] spi: pxa2xx: replace ugly table by approximation
Date: Wed, 25 Mar 2015 08:17:01 -0700
Message-ID: <20150325151701.GB3572@sirena.org.uk>
References: <1427211802-217454-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1427211802-217454-3-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150324165954.GL17265@sirena.org.uk>
 <1427279865.14897.405.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Chen, Alvin" <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427279865.14897.405.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2015 at 12:37:45PM +0200, Andy Shevchenko wrote:
> On Tue, 2015-03-24 at 09:59 -0700, Mark Brown wrote:

> > I'm not sure that
> > one could reasonably expect someone to follow this code without doing
> > detective work.  I think the biggest thing is that the comments aren't
> > saying why the code is doing what it's doing.

> Should I cite data sheet in case to explain some branches?

Yes, that should be helpful.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEtFtAAoJECTWi3JdVIfQ+G4H/RbtNrOa3+m5CgIrRY8Dt0ea
F9HpV+qbVV5GB6mtYyewoc/Mx9gFG7XANx7ctgYLTdOvQ5KIsae5nP2SDFJN8uzt
mBzmXsB1wiBdU3+V97zve67sTiePo6m4v0ezw2DPiGFq9vMhE4/kDh9i6oQ0+kkz
jn7I3KBPFsPIQcxM1p7JCSdJZ9ta0uxDWd8Mqntwe/ZOSjv9P3Td6qtrP+wB6Bo8
KNPcEzBUSX/VbBEiHXv90cSanucq+ZL+BfXfLGCtYS5nLjZT8u3Ww9EJuF34I+vg
TErmMrQIFbSMlunSwEB/sr3P7mANY+jVFT44WxhNWU2Hzhgo9Tc9bEWhkkho/ek=
=CRgR
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
