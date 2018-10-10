From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Date: Wed, 10 Oct 2018 11:18:25 +0100
Message-ID: <20181010101825.GA6294@sirena.org.uk>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Cc: linux-spi@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ronenk@amazon.com, barakw@amazon.com,
        David Woodhouse <dwmw@amazon.co.uk>
To: Talel Shenhar <talel@amazon.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539155293-21750-1-git-send-email-talel@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 10, 2018 at 10:08:12AM +0300, Talel Shenhar wrote:

> The dw spi controller has an auto-deselect of Chip-Select, in case there is
> no data inside the Tx FIFO. While working on platforms with Alpine chips,

Why would we ever want to use this behaviour?  It will be broken for any
non-trivial SPI message such as those made with multiple transfers
anyway.  Why not just unconditionally control it manually?

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu90e4ACgkQJNaLcl1U
h9Bw6gf/QW1tmWlXcmNLTdpo0qIz7z7c3z3/ydzStF3ZHJLeoS6YHY0bu8R5MtlQ
FkYVdvvF7/Zfqlr8tkOHFjnBh+fiT2+6EKvDu8zyPMZJNxDWBkllWxkdVhHUc75u
4/l5n9vgzCiedfz1SXfqDmBeBoKZBLl+vmu1w2a3InRcLhKqsDGsnENKdrfGEttO
0Vc946hptVhHjOKQ3I/XBotjOhqogZ4cr8QwOwLEJK7iBcQq6qhq2zP4EaBf0irD
aTew8Rff3BJJjASRVpP9EUULMUuhlt93Zea9cFfp8ildUt2sYXVaupf5HTpv+azb
BNuY0SoMbROx7VARMhHTEfgL1qmK4w==
=VGYE
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
