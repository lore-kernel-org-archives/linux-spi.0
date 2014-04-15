From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: cadence: Add dependency on ARCH_ZYNQ
Date: Tue, 15 Apr 2014 10:49:38 +0100
Message-ID: <20140415094938.GM12304@sirena.org.uk>
References: <1397537392-3709-1-git-send-email-harinik@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vdqwC0msT4ilQ2it"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	michals@xilinx.com
To: Harini Katakam <harinik@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397537392-3709-1-git-send-email-harinik@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--vdqwC0msT4ilQ2it
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2014 at 10:19:52AM +0530, Harini Katakam wrote:
> Add dependency on ARCH_ZYNQ in Kconfig.
> This is to fix the build error.

This is too strict - ARCH_ARM would be fine (PowerPC also defines the
_relaxed() operaton if you want to include that too).

--vdqwC0msT4ilQ2it
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTQCuAAoJELSic+t+oim9xMUQAIAgImDb/5NYjFQA3ARXw8h/
GFhsamaB7LYHt7KcjOArIKzLlfaOsBntxQDYojW7+NRTeoVTyJ3vWwfuUJgQxi1i
yiUzv7Dl1/4lpHpQi56hNuMZv7TyURTzaY12IW1AYPBmft4udApCI4k9jJhrIx+e
J9sr+7HGtbY4WcY3zfWp1Eaz5sewVSD9aRK7EEN5VFzfU/w/EOSodwK8EK1W5bQn
z7ySbytBhbLOOtqY5JIDGeOgFIV8ULrgvD3pMMSkv6mE7HJnAYWHZi9zGQh0dNoO
HkB95j38gqtkfBBMtjetZL5AiR//zzicSKbhBAbdaw0H86EY3yCMtvr2fc/eRUa9
MwvAaox8C3f8mHGfnVBh+YBey3Q4sVR6ndTYhN8l7hfOhidOUZd0DtoztwWi4Hm+
xnldiOF4p1/sKBbxDiKgTLBnGTXINCdcLAk4Qz9xek9WNHY3IOgqqKe4kO0IK7v8
KUh2ygrf9f5MeZFfe8Ms1HrlXuILMkB2lHRNLpXGrQsNuO9s+7r3IXbE7tsv5xoL
w2sm7NC9F/g18HzvoeLCcyX0d9epFnv+FiKrrfzjoLfX2K60pbLaoIz02p2SpjCu
ND+wiVU8DxZElA8UJtpL8W6rAvoZzirKp4lUpawWjLMK1Jn07S3F82nwCuLQ50Zs
zXSim0ymrIld1YhijeVJ
=V7IL
-----END PGP SIGNATURE-----

--vdqwC0msT4ilQ2it--
