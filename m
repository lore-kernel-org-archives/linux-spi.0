From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] spi/s3c64xx: Log error interrupts
Date: Sun, 29 Jan 2012 21:40:29 +0000
Message-ID: <20120129214028.GC2994@opensource.wolfsonmicro.com>
References: <20120121132329.GA10751@opensource.wolfsonmicro.com>
 <1327152265-10789-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAM=Q2ctA6o0wW4LMW=Jpe7HPGbm4S-UySURToXrC1r4kOe08Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Linus Walleij <linus.walleij@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2ctA6o0wW4LMW=Jpe7HPGbm4S-UySURToXrC1r4kOe08Rg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 28, 2012 at 10:30:36PM +0530, Shubhrajyoti Datta wrote:

Please delete irrelevant context from your replies.

> > +	ret = request_irq(irq, s3c64xx_spi_irq, 0, "spi-s3c64xx", sdd);

> Could we have a threaded irq instead and there are prints and that may get
> executed in interrupt context.

So, clearly we *could*.  However I think that's not going to be as
helpful.  These errors are never supposed to happen (and if they do
indicate a fairly serious problem) so the performance impact shouldn't
be our primary concern and if they do happen then my suspicion is that
the timing information will be very important.  I expect that knowing
exactly when the error occurred is likely to help diagnose what caused
it by virtue of knowing what other things were going on in the system at
that time.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPJbzAAAoJEBus8iNuMP3dZgoP/36JVgKolsarycqj0Pl3ixkp
7CIsQVxAHp1bJMucxfce3yYMBzWstGTKdMwOY9Lqa4+V8vLtQ9d7y9VBSAG4jf/l
mCpgi0lzwhTgQ1vMWjXR9RH4OmEGkayfwgxtVQuG+qLDqG/fTy6a1D8Y+GSSRGsH
ZsAA4jHSCmQwPxcAWQM+DHh/KGT4N2iwY7WJnpF0OfwvVkElRf5Q6uGuhxz7SJTX
YB1coc2Ac+81axchtz5Xwcn10xeDbOqLREORJ5f0lRXj9urxWT/UGe58lADhCB74
V23cBWlLs03YHVaniLV5V31ICwzLgrjSeNzo9/biIDfx/RYA6hP4N1nbXQFzDt0N
imChZoVt30uC7iL7LpxEZBlqDld2mp38So4CcCQkgdlsNNtlKEQZaV4Cxj2RHtF3
SrGOmzW+ISaJXLBfHSiwvWqE1udcQCK6juQjpfs82WVcm0sCKlYXrDCNK7seyZZt
jqnf0gIar13kBFlXsZO0Pv6A0l3TpAeMOx80xumolfJDYYm8jcLaz9NNQpGg9LUv
oll5nG94UciZoMcab/mCDbhVTHWWiAuNnPnXvN3wJVsgrck2i8dJCY5zRvtApHEI
mhJGavatSYqWB7cb9QiFP2vIM/zH9HMHmSPOnInyDhrx4aYzjh+OpUyrT7hH+tpU
0suZegCJmOul55kglH4V
=diPj
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
