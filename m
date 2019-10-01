From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Avoid calling spi_slave_abort() with kfreed spidev
Date: Tue, 1 Oct 2019 12:41:08 +0100
Message-ID: <20191001114108.GA4786@sirena.co.uk>
References: <20191001090657.25721-1-lukma@denx.de>
 <CAMuHMdWHTaPkzTdzz-j1rFeT=aAEG+J46fgKiPYrXoAR_DTvtQ@mail.gmail.com>
 <20191001113420.032dbfef@jawa>
 <CAMuHMdWh7xPZqp4J1qG22dXk_g=Q1WtQ9Xu-r3wiFOL3kW+WBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Cc: Lukasz Majewski <lukma@denx.de>,
        Colin Ian King <colin.king@canonical.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWh7xPZqp4J1qG22dXk_g=Q1WtQ9Xu-r3wiFOL3kW+WBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2019 at 12:00:07PM +0200, Geert Uytterhoeven wrote:
> On Tue, Oct 1, 2019 at 11:34 AM Lukasz Majewski <lukma@denx.de> wrote:
> > > On Tue, Oct 1, 2019 at 11:07 AM Lukasz Majewski <lukma@denx.de> wrote:

> > The if (!dofree) prevents from calling spi_slave_abort() when
> > spidev->spi == NULL and spidev is kfree'd.

> If spidev->users != 0, the block checking spidev->spi == NULL is never
> executed, and spi_slave_abort() will be called.

> I'm wondering if spidev->spi can be NULL if spidev->users is still positive.

It *shouldn't* be.  I think we have other problems if it is.

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2TO1MACgkQJNaLcl1U
h9Co+gf9EMfuNyB92VOoFo9okqWdMzDPwyTkYJyk6HSgVicME9grYfHDe81a7GjJ
9Dph4fdIVAcDkIFL/MbVPi3hsJCKFy+8QV1htiKYl32T9J3fKWROCKUD67c+PDwb
6LV+0EZCb5He4bdw3/CbrMsLhDTMedQL0/smyCNVcfj9WNeRBX64tv+48sE6lCaZ
bIGvhUppBJfIjDUU9hmKBweOp7XdMvGQE8SZmhruhgVEl/XICBkL73hYrHyW0QnJ
6FTJmaYLaW8nTDsk9XEiCM/AV8yC+hGdQhlEg4VxiGJ+1sm3QfXvyqYVQo7umAkV
hNXIGjDoZ61XFt7E/0SnzKLru/taCg==
=mQ+T
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
