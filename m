From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 3/5] spi: lpspi: Add 8qm/qxp support for lpspi
Date: Wed, 24 Oct 2018 11:37:11 +0100
Message-ID: <20181024103711.GN2103@sirena.org.uk>
References: <20181024075617.19548-1-xiaoning.wang@nxp.com>
 <20181024075617.19548-3-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xdWF/UuCWMRSqXrg"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181024075617.19548-3-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--xdWF/UuCWMRSqXrg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 24, 2018 at 07:58:27AM +0000, Clark Wang wrote:
> Add both ipg and per clock for lpspi to support i.MX8QM/QXP boards.

I'm missing both the cover letter and rest of the series so I don't know
what's going on with dependencies here - what's the story?

> Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>

Please try to at least have the git commit author (which would show up
as an in-body From: if you use git send-email), especially given that
it's not just a spelling variation but actually a different name used in
both places it's really not clear at the minute that you're not
forwarding a patch at the minute, if that were the case there'd be a
missing Signed-off-by here.

--xdWF/UuCWMRSqXrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvQS1YACgkQJNaLcl1U
h9CdmAf/RBZVq2mu96SbISFysTMd4FiSr3nwNfAlxiyxAx/bVBlrpoDAjD7/pyJI
GV5ACm255IOkwCZbymD49D1wN5A6rFOLJ/VC2Mu71NBNUGUJIQ8qLuSzn87hYFhT
v+vwaGT+wJZxQhH+Sx3jhZSsVLfDkK2eunCHb+ABNK2nXlwiosi8EJOITd5di4Pu
ZkRc92UZHBEl4Io6PaMfFyMXeM9We4vnRd/Pujx6mzPe88pEjDWcc8Tk4MulIMEc
wR4K265UraZGsuJRWddNZcRPXyNkAP6TxTtstO8ULWG3vh985MhCUR2we0S4dH7z
RkovkCOK3CZcplbWMHQfeqpCPCiZEg==
=d6CN
-----END PGP SIGNATURE-----

--xdWF/UuCWMRSqXrg--
