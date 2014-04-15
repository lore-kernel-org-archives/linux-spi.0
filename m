From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: cadence: Add dependency on ARCH_ZYNQ
Date: Tue, 15 Apr 2014 10:45:41 +0100
Message-ID: <20140415094541.GL12304@sirena.org.uk>
References: <1397537392-3709-1-git-send-email-harinik@xilinx.com>
 <CAHTX3dJrMxWJ-8i-wLRkQYtR_zbA+nJyGW+r-DFMYHHU4Erzbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AQNmCumFClRcGgHG"
Cc: Harini Katakam <harinik@xilinx.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Michal Simek <michals@xilinx.com>, will.deacon@arm.com
To: Michal Simek <monstr@monstr.eu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHTX3dJrMxWJ-8i-wLRkQYtR_zbA+nJyGW+r-DFMYHHU4Erzbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--AQNmCumFClRcGgHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2014 at 08:11:37AM +0200, Michal Simek wrote:

> I sent the patch for it which solve this problem in generic way.
> http://lkml.org/lkml/2014/4/8/42

> Feel free to give me ACK for it.

Will has been working on this too off and on, he was also trying to
define some semantics for the relaxed versions.  It'd be really good to
address this properly, this is a constant source of make work.

--AQNmCumFClRcGgHG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTP/CAAoJELSic+t+oim9DCQP/2TbrKG2aTjmdghxd7o8aZkb
LbUrD9sHA53SauypbktqItb4fEBlp6idkvhVrMJpqAhY9Goilu5zV1JkRk2Hjb2V
4vImkhJ3FxMJ3tk41mErhDRCb9TkgkK4GzPN4V0ksyo15FW2HLtQDfobMmD5Y+uc
4Ejgg4sAxWjlF+ACr9H7zIlhfX/ZGajVe94Y7pWRQDBLVuHdurg6fttE7xuLGyps
HxsQ3YYslgVi3whnNJ9lQ2BlaZdVpvqrOWQ0+/FNuBQDEFRoLCyIHO97zlSdhCq5
ILiXmkxo9Ykp9BoNkJ2KV0j96YBMIstvEVkNsBg0/EB88d71kHl13MHaRz49zWMu
0MpzeOxccKXK40L+pYfxfa5b/N4s+Ag47INVHMJU2JlEgadANYEnwBY8ADzEn+dq
JKL2KTY4nHr+aJKeVS36BkKLnB8JrV0BAhzKy3keu0pxp9wMqk9FUGfQnMT851W7
IWrCnaQywfIfJ6hkqtsWxuZmJXgMWU0qy+fTZk7ZFy7kc1VIqfIL1Tmop95ooF1N
JZW84jlJLoCpNg4D/q4Ds+5MaQFNyE5jrCeyaEDDBon9TGno2V+3AaM0bXmpLzGr
xTkiAfwehoW/toCQHp0/6nrI6CPs/rGWqP7471yylDRM4EWGKtZm80HeEs4N6ZEq
AscsVURuXwT9fIzFp+oj
=oCL1
-----END PGP SIGNATURE-----

--AQNmCumFClRcGgHG--
