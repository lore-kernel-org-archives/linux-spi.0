From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: SPI_FSL_DSPI should depend on HAS_DMA
Date: Wed, 14 Dec 2016 15:13:00 +0000
Message-ID: <20161214151300.jrq4qexxcjyfk5sv@sirena.org.uk>
References: <1481718485-6966-1-git-send-email-geert@linux-m68k.org>
 <20161214143713.3kl34okpr5vnuyc6@sirena.org.uk>
 <CAMuHMdU6PGUrmMOKFH9AFwK7j-eyThVaofS0jKN=HiL0WupJEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ajnjnbgx6v4ol7u3"
Cc: Sanchayan Maity <maitysanchayan@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU6PGUrmMOKFH9AFwK7j-eyThVaofS0jKN=HiL0WupJEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ajnjnbgx6v4ol7u3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 14, 2016 at 03:40:43PM +0100, Geert Uytterhoeven wrote:
> On Wed, Dec 14, 2016 at 3:37 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Dec 14, 2016 at 01:28:05PM +0100, Geert Uytterhoeven wrote:

> > Honestly I think we should just fix the architectures that don't support
> > DMA to provide compile out stubs for DMA, it seems like these
> > dependencies are more trouble than they're worth.

> Will that really help?

> Then people will start adding "depends on HAS_DMA || COMPILE_TEST"
> instead...

No, I'm thinking just arrange things so that we don't need to depend on
HAS_DMA at all.

--ajnjnbgx6v4ol7u3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhRYXwACgkQJNaLcl1U
h9B6Cgf9Ghav0irv7vFCKc13dhALsqrY3kq7AlNJH/QsPutguMstnyElqO03QvV+
WAOYlO3CWHIPlAIpscMkBdhnr4f7/sF90EqnONf4RqmrcHWow5wfAOwyIM0A6ki1
lacCaCz1WVYYaMTueqjVRHmnWCf0INhHtNu9O8FGZzVz5IEcEX2rT+024Gu6Ynnc
q/4dNc615gbFlTZvYaYsGUNexsC0SGghZWrHa83yNmovASrTfbXqjAp5xP6RHeKZ
lKHPW+kaCg0ccPfXOplaNGt2EmO5r1GSGSHhzxs4PQ4apMGZAcMsvOik5OeeYNV/
eF2l6M6IxT8hXg/n5MiZeZS5lqMr1Q==
=p/xU
-----END PGP SIGNATURE-----

--ajnjnbgx6v4ol7u3--
