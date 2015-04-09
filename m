From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] spi: Add SPI driver for Mikrotik RB4xx series boards
Date: Thu, 9 Apr 2015 22:50:47 +0100
Message-ID: <20150409215047.GE6023@sirena.org.uk>
References: <1428285263-15135-1-git-send-email-bert@biot.com>
 <20150406163905.GL6023@sirena.org.uk>
 <5526EFA0.2010108@biot.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gkncWFjxA+un9L7+"
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	andy.shevchenko@gmail.com, jogo@openwrt.org
To: Bert Vermeulen <bert@biot.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5526EFA0.2010108@biot.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--gkncWFjxA+un9L7+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2015 at 11:31:12PM +0200, Bert Vermeulen wrote:
> On 04/06/2015 06:39 PM, Mark Brown wrote:> On Mon, Apr 06, 2015 at

> > I queried this on a previous version and asked for the code to be better
> > documented...

> I documented it in the commit message:

I'm asking for the *code* to be better documented.  Right now it's just
raising obvious questions which are at best going to cost people time
digging for the reasons.

>  The m25p80-compatible boot flash and (some models) MMC use regular SPI,
>  bitbanged as required by the SoC. However the SPI-connected CPLD has
>  a "fast write" mode, in which two bits are transferred by SPI clock
>  cycle. The second bit is transmitted with the SoC's CS2 pin.

>  Protocol drivers using this fast write facility signal this by setting
>  the cs_change flag on transfers.

> The cs_change flag is used here instead of the openwrt version's
> spi_transfer.fast_write flag. The CPLD driver sets this flag on a
> per-transfer basis.

No, this is broken - it's abusing a standard API in a way that's
completly incompatible with the meaning of that API which is obviously a
very bad idea, especially since good practice is to offload the
implementation of that standard API to the core.  It *sounds* like
you're just trying to implement two wire mode which does have a standard
API, please use that.

--gkncWFjxA+un9L7+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJvQ2AAoJECTWi3JdVIfQ690H/2PjnawZ5UsBCvUeNspUcNPX
jcowu4muM67lLh3z2KQBour+N+6dKNjl7IQn3FTzTIiSxPsXCeWZF3HcfeEoC2hd
GDOdk+JytWk4zehN9jnvtVw51LJC83IptdFEn6PRgkWlmmyus2fgwEfBoAlmS0uX
/6x4FGPSu7X5Zf8GBFpjTHLa9oBESdL1AfaXAVhAosCcC6YsUGndmub/cBjWzAfs
96hdh51x+s1uR7EDtfn4LjVCesqxvQ/1M8N3GqykZCqlucVRfz/DqLGROFo4XZYp
BBoMmNnHZxWNs4CHRvcIg0MEOyRXoC5HSO95M7LlJkV5QgqzZucWp1XZVyGad7Y=
=kqIm
-----END PGP SIGNATURE-----

--gkncWFjxA+un9L7+--
