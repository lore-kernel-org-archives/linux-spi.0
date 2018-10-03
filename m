From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: slave: Fix missing break in switch
Date: Wed, 3 Oct 2018 16:24:00 +0100
Message-ID: <20181003152400.GF7132@sirena.org.uk>
References: <20181003123328.GA29471@embeddedor.com>
 <CAMuHMdX2YL2PG390ej0WMct7DciAbzO=66z7TJ-VnS8_phjdaQ@mail.gmail.com>
 <20181003150111.GD7132@sirena.org.uk>
 <37edd7c9-c93f-49a1-6621-880d8f88f345@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <37edd7c9-c93f-49a1-6621-880d8f88f345@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 03, 2018 at 05:05:04PM +0200, Gustavo A. R. Silva wrote:

> I'll include the __noreturn in addition to the break statement.
> I'll send v2 shortly.

No need for a v2, I already applied this - adding __noreturn seems like
a separate (although desirable) effort.

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu03w8ACgkQJNaLcl1U
h9AoBgf/XblnzeKCFq8Y+RvmPxZI4aKxu5DCn1XBQbor/kDEzvrfkjV4p06uvFsE
/VHvfH/IZVJ1sxMqU7GUQ6s/pOEmTRH2jH857dERMItTxB3RwL73g1zYTfDE9QsW
ifDn93bax2auLHxRCIXzKFo30kutXHR9+u4/N9Lut825Q3QBYQ25K+GbXCE5BwdF
Qr2KVWFC/8navypKrEIr8UzcTWcLe+WNZNQRhwmNWW/9X8zXUamdWQNpVOR3MHaf
NBs1iYIzT7NeweRTZnL8Zac9M7ity63AS7bJrKr1f0R8Bnmi+2+ohXf+/RwvHp47
6Dsm9QswTT763Av49x3CuelovYyrjA==
=H4K7
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
