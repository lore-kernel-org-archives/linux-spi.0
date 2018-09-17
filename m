From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
Date: Mon, 17 Sep 2018 10:57:53 -0700
Message-ID: <20180917175753.GE2471@sirena.org.uk>
References: <20180917113559.11101-1-lkundrak@v3.sk>
 <20180917113559.11101-2-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180917113559.11101-2-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 17, 2018 at 01:35:55PM +0200, Lubomir Rintel wrote:
> This is the SPI controller found on Marvel MMP2 and perhaps more
> platforms.

I'm missing patches 2 and 5 from this series.  What's going on with
them, are there any dependencies?

> Changes since v1:
> - s/ssp@d4035000/spi@d4035000/

As covered in SubmittingPatches please put inter-version changelogs
after the --- so they don't end up in the commits.

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluf6yAACgkQJNaLcl1U
h9DOQAf8Cv3fHKVpMtxvJzFX3pBXWcxF+8T6rJK1pzP5vPMEtdwL+liUyN2xbcyn
sa3gE6JVmJ5EdBSFX+GiAw0iCPobbIlTV+k4a1ggJIAuRM94LD/cIgcCbSxFW8/S
wskVlYdpdBlc2zis+99q7LAGVFnvbdQOe58PU4ZHRzlWSL3BGRitwL0lVrSvm3Yn
AK3AT+EO4/U9gPntJDnNHlEZFdPXEA+ji7Y1OFrx3x54QgTxjlXSnY/1MT2tlb6q
WUTtrcWBVVijOU3pZPUmgQTBEdekclIbjrfJZsZiIdcGBC5Msd1R6QP/yvp0tMGL
radg15LAoOSaw66F8Qf0lOMaG0lZzQ==
=g2nQ
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
