From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/2] spi: add driver for J-Core SPI controller
Date: Mon, 1 Aug 2016 19:12:45 +0100
Message-ID: <20160801181245.GZ10376@sirena.org.uk>
References: <cover.1469686300.git.dalias@libc.org>
 <2a46090a5a7c177b7eca83f68406650844423e7f.1469686300.git.dalias@libc.org>
 <20160728191153.GL11806@sirena.org.uk>
 <20160728194045.GK15995@brightrain.aerifal.cx>
 <20160728195125.GN11806@sirena.org.uk>
 <20160730033441.GO15995@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j+Rb494BzBd9643b"
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
To: Rich Felker <dalias@libc.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160730033441.GO15995@brightrain.aerifal.cx>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--j+Rb494BzBd9643b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 29, 2016 at 11:34:41PM -0400, Rich Felker wrote:

> I was able to get it working via the clk api and I'll include support
> for this in the next version of the patch, but to actually use it
> depends on changing arch/sh to use the common clk framework; otherwise
> there's no way to provide a suitable clk in the DT and have
> [devm_]clk_get actually pick it up. Should I keep around the option of
> using clock-frequency too? That would be most convenient.

It sounds like at the minute the devices all have one frequency anyway
in which case just having a default frequency in there that you fall
back to if you get -ENOENT from a failed clock lookup might be enough?

--j+Rb494BzBd9643b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXn5EcAAoJECTWi3JdVIfQBIwH/iNPu2AxYU0oEIYk3n5UVMvR
mR5548bNX7JboYJX5rlwnlLqirN0emD1BR+5WDRx1JIieqDf6PbO6yRw7FWjUw/n
NhjfMiX3IhaQWqGwNjNKXP4DhNjIqA9535ouwEMmS7hh+in8PTeMTY9Ixut/aX9R
xHdLQO/pfM/F7QDPUB05ODIq6CrpP6SFNFD/dPQWiBSa+H8ZfhYf5XvpQHEdKVNO
2uU+U3IGoIIEO6YL3pOGRxuwr+OFBUIo539wCv8v2FWhNL1i6mFfeLLCnfNWGV7t
nCDPIrjYYe4bASU7pQV8M0kasqI10ilTGXJJbQP+eWglaoqXkZBanxKwN0HogrA=
=8TC0
-----END PGP SIGNATURE-----

--j+Rb494BzBd9643b--
