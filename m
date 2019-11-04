From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: sifive: disable clk when probe fails and remove
Date: Mon, 4 Nov 2019 12:47:18 +0000
Message-ID: <20191104124718.GC5238@sirena.co.uk>
References: <20191101121745.13413-1-hslester96@gmail.com>
 <mhng-3be3dc4e-15f2-4ad2-b156-ea5439e729bd@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Cc: hslester96@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
To: Palmer Dabbelt <palmer@dabbelt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <mhng-3be3dc4e-15f2-4ad2-b156-ea5439e729bd@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2019 at 04:07:29PM -0700, Palmer Dabbelt wrote:
> On Fri, 01 Nov 2019 05:17:45 PDT (-0700), hslester96@gmail.com wrote:
> > The driver forgets to disable and unprepare clk when probe fails and
> > remove.
> > Add the calls to fix the problem.

> Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3AHdYACgkQJNaLcl1U
h9Bxbwf+PS/3tt1r3nRdDUeTgiw12asFTlFdosGPaCdJ0zCp0XBMPgFZBia9R16z
QBrOHOQ5BL+W7FEEOh9hfPpvdVPzgygwAip2n2uHEWrOZ7pt7PWoGj2ybu0JDXTu
rPhwWNvY36hCVKElOiixQeR43pU7yKJZzPoWVTxJgGarWaE03ngE0jEvQUqtsVMB
aI0LNK076Dt9geC7wg5FFSppQTVv6c9PvpTehaS5hKvY00hfUS3i9uFgYsXjuggz
TYsKknIrHD0gm0Q1bCfGK7u6C3YkbyPs6uj1j2xZLh5isMgVokBkrlpkbpMtKl+i
PPxqmUKox9ymgSDfmnZ1yGneuS3qVg==
=2j2y
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
