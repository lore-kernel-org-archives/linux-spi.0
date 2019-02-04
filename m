From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/9 v3] staging: spi: mt7621: Switch to SPDX identifier
Date: Mon, 4 Feb 2019 09:53:02 +0100
Message-ID: <20190204085302.GB23441@sirena.org.uk>
References: <20190201101715.3760-1-sr@denx.de>
 <20190201130355.GG20797@sirena.org.uk>
 <87muncjyb3.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3702103701320796336=="
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Crispin <john@phrozen.org>, linux-spi@vger.kernel.org,
 Sankalp Negi <sankalpnegi2310@gmail.com>, Stefan Roese <sr@denx.de>
To: NeilBrown <neil@brown.name>
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <87muncjyb3.fsf@notabene.neil.brown.name>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Id: linux-spi.vger.kernel.org


--===============3702103701320796336==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 04, 2019 at 09:34:56AM +1100, NeilBrown wrote:

>  It is extremely common in the kernel for a file to start
>    // SPDX-License-Identifier.....

>  and to have that immediately followed by a comment lile:

>  /*
>   * .....
>   * ....

Yes, there was a lot of automated conversion AFAICT (and a lot of
confusion with all this stuff only being documented in random mailing
list posts for a long time).

>  This patch makes this file match much of the rest of the kernel.  Why
>  do you want something different?

Like I said because it makes the comments look more like someone
actually meant to add a C++ comment - it's what the rest of the
subsystem is doing too.

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxX/W0ACgkQJNaLcl1U
h9C17Af9EexTEI0ifnuEDFSCO1K5FHa1ccRqsPjqA2QDBKwdB6P2IgxFfYIhfp3X
gMS9rMw5d820UNMuMLd5+H/ut0VBHkF2Vh7lwPcKbcnGebemDrxDl6wSpDMqIsED
w65UmfiOh05ev7F+BFmvavhAEbUXcj5gWgRHW1j4X0wLF0zrTX66mvInW7pL9a/j
uYaZ7cn0a4TbWjSZQv+bTTYGxkJvfPrBv2aaL/2yTQTOl3BdF5rAyaq1JF2uB2W4
CteCmW/zzhZ1zTXW2zPpxNuQaXJ+WhWVZaZiPBT19TeNAwvvse8C7IpJZeXeAIJc
QlWajuOux94RmDa9PziXTjVzzTM6Zw==
=VwZP
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--

--===============3702103701320796336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============3702103701320796336==--
