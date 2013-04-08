From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 4/5] spi: s3c64xx: Added provision for dedicated cs pin
Date: Mon, 8 Apr 2013 11:15:30 +0100
Message-ID: <20130408101530.GC9243@opensource.wolfsonmicro.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
 <1363157014-9615-5-git-send-email-ks.giri@samsung.com>
 <20130401125744.GG18636@opensource.wolfsonmicro.com>
 <CAKrE-Kd+YAFmteDdh3odtV+YU1=OjoMuQV9usF4NmUse+TXhTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Cc: spi-devel-general@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tomasz Figa <t.figa@samsung.com>
To: Girish KS <girishks2000@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKrE-Kd+YAFmteDdh3odtV+YU1=OjoMuQV9usF4NmUse+TXhTg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 08, 2013 at 03:21:03PM +0530, Girish KS wrote:
> On Mon, Apr 1, 2013 at 6:27 PM, Mark Brown

> > It's also a bit odd that we end up checking cs_gpio and then using line
> > in the code, it'd be more idiomatic if cs_gpio were the GPIO number.

> In the original driver it was assumed that the cs line is always a gpio pin.
> But the current controller that i am working on has no gpio pin for cs
> selection.
> All the lines to the device are internally connected. There is no
> option to select
> the cs signal. So cs-gpio property parsing has to skipped for this
> controller, that means
> cs_gpio cannot be a GPIO number. If it has to be a number then it has
> to be < 0 to say
> it is not gpio. Any >= 0 number implies it is a valid gpio (in reality
> for this controller it is not.)

Two options here, one is to just assume nobody will use GPIO 0 and the
other is to set the number appopriately during probe so that only probe
needs to worry about the issue.

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRYpi0AAoJELSic+t+oim9j60QAJw2B4Zu6vyrC1EQu05J9Os9
glBg+SSQBE5nnDXv3NrcZv/dVxDrVvNpYwCsEBmM83YCgpJb68MVWAFgA+fzZxgy
AN5HFH0EegxoImk+6tGyBNC11Ytti/HA1m0sGotV22f9xXnDETsxzT7FBPpx9BsC
dSb2GnuHgUwL6JGU2JuYicJid8d4Bn9g8dkgttD7J+z2dcTrRtsNgMOnWy1h48Xj
eOlbtwPYYTsV7GR4XPgNmHWozIu68rmHTtGISwCCPDtVWRLrowYLWNd3J5WjbbM4
XuzRK5oElLCHimWVqThEzdpqjNRHvy6oWaMFaXkv2USNvL3MvlFF/erhOFe0u0sC
I2eFYhMXAgDdnstwddYVzLsIP/MV9cKlAIspgaqeaQyrierhbNgSmjnVhbUlbL7F
E/39u4oDdQIj7MDQW2qbyIkpq5TQCM22z+ez+7+FP7/7ZSBJ0OfmVS/z8M/FepLw
TfrnoQS3oBboyEMLCG+7Iv5Xd3nQndcWYsp9Heohb6T5bXuoK/yNFk1+/MFbpRUq
Guy4mm+aeFu1+8Ayc2jjs9UZOAYH+TklCiDdnjra8tHtzwIEGCI85vAmHv8+uOnS
8DgAZao7VZSDVA8IYdJQxd0x1d+nnHapY57B/4JlVrZJgu8W/n1ua4/eGoRUMpc2
vpTbF7V8s51f5mqvHUqQ
=rtNQ
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
