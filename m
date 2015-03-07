From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/9] spi: dw-mid: clear BUSY flag fist and test other
 one
Date: Sat, 7 Mar 2015 11:04:15 +0000
Message-ID: <20150307110415.GF28806@sirena.org.uk>
References: <1425320166-13788-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1425320166-13788-3-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150306112519.GH21293@sirena.org.uk>
 <1425645629.14897.196.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425645629.14897.196.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2015 at 02:40:29PM +0200, Andy Shevchenko wrote:
> On Fri, 2015-03-06 at 11:25 +0000, Mark Brown wrote:

> > The commit this is fixing is in v3.19 so this should go to stable but I
> > can't apply this against my fix/dw branch.  Can you generate a version
> > that can be applied there please?  We'll need to work out the merge
> > issues with the current code I gues...

> Hmm=E2=80=A6 Just tried apply on top on fix/dw using

> git am -C1 -s
> 0001-spi-dw-mid-clear-BUSY-flag-fist-and-test-other-one.patch

> It went fine with reduced context.

> Shall I still resend you that version?

Yes, please resend.

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+tsuAAoJECTWi3JdVIfQQAcH/2SMZaEkmsiSTquEM4wDvp/A
p0WqzUAhEE96rXMxpTA2WvMlRt0ex+kOFNfPSCRXSlfeYIz6BHY7+3y1l+ZJ3brb
NBztcrl8YqDCwkamybzJvvB/xABs+TfKvxg1jliKzD0B0vsMXo+L1lOlm4oubGLf
Wd1mpG6yREf4l58t77Cq+dXzO4QsW7jwugfQldGMGzi7OkAhsVOLaqcat/8pY9jm
jwbIYCin7XMl08vLmvnDAM8NKBCNwRI2M24qM7dACsehi382d+CBUBC761tLzRpq
zZtMtWAFqPPP3yf5fyMWJ2f4fNYMBSr4c8Xna7BCgFzQ/8GK5cxf2vXtS32zfVk=
=hYT6
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
