From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 06/11] spi: spi-ep93xx: remove dev_err() for kzalloc()
 failure
Date: Wed, 3 Jul 2013 19:22:24 +0100
Message-ID: <20130703182224.GD27646@sirena.org.uk>
References: <201307021009.00176.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fzqeIE+j4cN25Pqf"
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	Ryan Mallon <rmallon@gmail.com>, mika.westerberg@iki.fi,
	grant.likely@linaro.org, hsweeten@visionengravers.com
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201307021009.00176.hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--fzqeIE+j4cN25Pqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2013 at 10:08:59AM -0700, H Hartley Sweeten wrote:
> The kzalloc() failure will have already output a message.

Applied, thanks.

--fzqeIE+j4cN25Pqf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1GvdAAoJELSic+t+oim9g5AP/1uFRYDfa4Fclshb1MqePv/9
4n6ep42kQrDuyNcV9Bv5DHjUNpwRbblm/5w+TsYSd8/P5cYs0v6xQ+MeZjrYfd1q
bXTDPeGpxwNL2xGUpd0bELmM5cmj+C38J3RkPJ4QeOEC0tnAcpJbx6PIDeJdVuj+
x3GEMisEur8oKQGyl+Db/Qpe0y+IxKfJJXDgaJbEx4DymegDHR8gnC7BJbBzniXw
NNszEeqR3nN0iw7LGNLmjkf3btSqenoen1y6GsHKhxSaJQPsgyKcdhjytAquiIaI
hXunOLhnCnRMgfyZIRRnor2BTlXOer7KxD1fgPOSIJNARQD9ji7GGAmqAE0nG/uw
ScbGWfGMDZlMIMrEPlTxbOUGAgwlQPcoaYsXgF5VgtRlbgYdjZEsiahym4h47nM3
Uyan8xZkFyEbk3qtAm8RN1PZWBV8fMA/+Ms8EpeVCNdccX0phuIU3uFwSnMskX3n
aA/YfIpWBDYmudXpM4l8+Zh1OdrtAbqLnxGKi/kUmIspTzzT/nCOrPobquG13BcC
hUD8JQOi/fR4sntgNBAm4KPZTBp1dROc0/zcen7+U1cafzCDdhdTTUW2XMPwfMM6
8H5YjRpiqE/hpwnEsNl0+IyYsyYP0ud/Kie0gP5yI/lzKDt28A1yx88yjPtiFcLH
B/VYQ3Zz8Aj5s9EjZkfB
=eYyE
-----END PGP SIGNATURE-----

--fzqeIE+j4cN25Pqf--
