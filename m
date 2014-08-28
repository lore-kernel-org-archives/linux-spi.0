From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: dw-mid: don't leak memory on exit
Date: Thu, 28 Aug 2014 19:19:22 +0100
Message-ID: <20140828181922.GJ29327@sirena.org.uk>
References: <1409215997-26085-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Cc: Feng Tang <feng.tang@intel.com>, linux-spi@vger.kernel.org,
	stable@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409215997-26085-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2014 at 11:53:17AM +0300, Andy Shevchenko wrote:
> When built with DMA support the memory for an internal structure is alloc=
ated
> but not freed. Converting to devm_kzalloc solves the issue.
>=20
> Fixes: 7063c0d942a1 (spi/dw_spi: add DMA support)
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v2.6.38+

You've sent two versions of this with different changelogs and diffs -
what's the story there?

This doesn't seem like an obvious stable candidate - it's a leak fix on
probe.

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/3KmAAoJELSic+t+oim9OD0P/1ZRe8ZheAplPLuCkMGmToBZ
W6vwCD3RS1ijt89EhfDzecqD6MXp7+fHpftJo32NQEha1LqbzCKTYKp/v+iCzrdD
bAIfWX7UJYLJUXJXZc0UEn4glINZOy5m2b0UlBUwboX3hDSUmIUrVcl6SLXF/q2V
/ctPPFXQ9VBBlxSvUA1nLn9LvSdn1x4tMAACas3BjynNWip4aZqilNZZmeHCVIqo
LsYSFxtU+tEruBrWdjV9GZLFXisqeIq4K9o5yxKCWH5+tor0G92wcSFGvIlpWnL/
QO5D4lEMTDiYS1rreYuTxxa2j67t9xOW0/Og+Lj+vOqr12XepcIp+eL3HQgdEV1O
G08n3OEZ+78nLHoMRBNbjB0Q/SwTXHO8tKvDXKmrbs0hrVyZzsd4uBIOKPQVAXi1
9FzzaWsMNzAzAVlWFjLiGiR+h8jmX7PC4tS/MNsmOkfGCoLbgDvZ/Q2ofsvCslWN
LetvMDe+WFW/877DEFzAqJtJo2IZSCS/Q3AUqr1lhRQk6O4j4jlcU3NtpsRtkOXF
/1kOlMTZ6EMtXKOCAe6s3W3mBwEHKhlKf/DBEjvXwwmlhy03BZaAOEoFvQikUpWq
4/v5PuKNYy7ar6NOeT27feMSG5B0PQ1Jo1WXp+dVfP2CnyPQrPyy0YN7cFLc6+ye
8+xIX524kPxhL5nilim6
=ZOti
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--
