From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Date: Tue, 9 Oct 2018 11:33:28 +0100
Message-ID: <20181009103328.GA20774@sirena.org.uk>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
 <20180928084431.300b7bf9@bbrezillon>
 <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <20180928091833.15e95f7f@bbrezillon>
 <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <20181009120522.6b2bd15a@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Cc: Chuanhua Han <chuanhua.han@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181009120522.6b2bd15a@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 09, 2018 at 12:05:22PM +0200, Boris Brezillon wrote:
> On Tue, 9 Oct 2018 09:52:23 +0000
> Chuanhua Han <chuanhua.han@nxp.com> wrote:

> > 1. In the dspi driver (spi controller), bits_per_word
> > (dspi->bits_per_word = transfer->bits_per_word) passed from the upper
> > layer (spi-mem.c) is used. In this way, I can only assign the
> > appropriate value of transfer->bits_per_word before passing to the
> > controller, that is, the controller driver does not know the value of
> > bits_per_word, and it will use this value when the upper level sets
> > what value is passed.

> I think you're missing my point: ->bits_per_word is not what you're
> looking for if what you're trying to do is use 32-bits accesses when
> things are properly aligned.

To be clear: bits_per_word affects what goes out on the SPI bus (4 byte
words swapped to be in MSB first order), it needn't have any effect on
on what goes on inside the SoC - many controllers fill their FIFO in 32
bit blocks even when sending 8 bit SPI words.

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu8g/UACgkQJNaLcl1U
h9DLawf/WlD+TLCVZMYkPjr2exJkiriLytbS+tBT2Ajv3GJ3iEz5RaT1I/vULM7/
gQAcl9hvJGEMQQHTwdY7ZCwaP81liqd2qG5R/qX/yfoZh4Z3FCMYjEbdOHPpNgLA
aATd4k7ve4rsOhYUPkFYgtfcGz+Y004RSLuraaDUcDHLuOOF895vEfRpRg0PgLwy
c1fVHgAyOoxbOfj1oF9mmupmBqiTx+NiNrZGq16xST6RPGqRLhpFmGAZ8++7p3kw
RyZtmnq5b/U7fPk4HftVsJk1uxp1/0/xFUYv1tU5gHgc18Jcu0lFa1D1guwqa1Xn
ibh1mtxlboxFIDXVp2Gu1Nj3zS9x5g==
=gyE5
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
