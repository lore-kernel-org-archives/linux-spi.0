From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH/RFC v2 3/7] spi: core: Add support for registering SPI
 slave controllers
Date: Thu, 15 Dec 2016 17:53:26 +0000
Message-ID: <20161215175326.tbblqe7kto2qgxwz@sirena.org.uk>
References: <1473713446-30366-1-git-send-email-geert+renesas@glider.be>
 <1473713446-30366-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zsv3qa4ecr6bhsmo"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473713446-30366-4-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--zsv3qa4ecr6bhsmo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 12, 2016 at 10:50:42PM +0200, Geert Uytterhoeven wrote:

> TBD:
>   - s/spi_master/spi_controller/ where appropriate,
>   - Provide wrappers (e.g. "#define spi_master spi_controller" until all
>     SPI drivers have been converted),
>   - Do we want a separate spi_register_slave() instead?

This basically looks fine to me - there's these TBDs so I might be
missing things and we probably need some GPIO chip select handling but
that's a separate thing.  Sorry it took me so long to review this.

--zsv3qa4ecr6bhsmo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhS2JUACgkQJNaLcl1U
h9CMhgf+IlALrWqcSwTuJ8TzeKIrn+6yLvpyyUVAHA/+VHuNCOk/fO1wTuDboSQe
An9CsF/If7NfpdOxKpLBS1sQYWJRmX+uhat7jRWLsQ02ULQJDIF5v+IDLQmCMmzi
Ok3PKjRg1KMtbKiQA4tSfWnJrzrk772DkQx5Qacnh1C/AgjLng8Z566kikIYvbi2
DERqgtDHILmRhcffGtKIx8b2s/wGNCKetjoELYszl5XX4C/Rh58Wg9LBAhGp1WzP
Lke0klO0g8BGFtkvi0sRcO1xT97I0o2gDqmJgBPZ6oYDFl414r9WXLNTwZtfzNpJ
hKErrnsL575rbo1wCFGAhnSxB2v4bw==
=8w5B
-----END PGP SIGNATURE-----

--zsv3qa4ecr6bhsmo--
