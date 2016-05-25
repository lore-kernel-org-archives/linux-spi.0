From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Wed, 25 May 2016 19:44:42 +0100
Message-ID: <20160525184442.GE8206@sirena.org.uk>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524172045.GN8206@sirena.org.uk>
 <57449784.4070108@weinigel.se>
 <20160524183256.GP8206@sirena.org.uk>
 <5744E51A.1040506@gmail.com>
 <20160525174932.GA10753@rob-hp-laptop>
 <5745E9B6.5090204@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CnCWQepWw43huI++"
Cc: Rob Herring <robh@kernel.org>,
	Christer Weinigel <christer@weinigel.se>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5745E9B6.5090204@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--CnCWQepWw43huI++
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 25, 2016 at 11:06:46AM -0700, Frank Rowand wrote:
> On 5/25/2016 10:49 AM, Rob Herring wrote:

> > Things get undocumented all the time when we deprecate them.

> If it is deprecated then it should be documented as deprecated so
> people do not attempt to use it.

Or we could just remove the code, we don't appear to have any in tree
users anyway (the few in tree aliases for SPI buses I can see are string
based).

--CnCWQepWw43huI++
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRfKZAAoJECTWi3JdVIfQyz0H/jTem0AYPhGc09t0O0LE2gMK
pUGMHmSkLUT/GUZ3sbbiqjmhe4VkIXVLWcHP/2mv5JBqMOToUXvIKe5ymuN7sbE+
CQwUaub6gULQJ+NDLjP0ToJPqFMbWf5ugaqIT0ZQc7YDzLytLX4B5wmF4LJ09O9A
ZxR6rnD6s6WJOLO/f0ufZd82EqAReMAVJXowdMRjkDE+LF1vB3QEsyL+/w8Hvvoh
LMw5x4tUFbeJaOAOWthtp9UsSL35ZkUbteiqXXtaIwLzd0AxULal/PYFBR5rCAN6
OlmFkVoED3btCmR1ux8ozZ5UVeNMlKIUZip+NWVBtzABNYP50cftPX58LSWaBi0=
=KENs
-----END PGP SIGNATURE-----

--CnCWQepWw43huI++--
