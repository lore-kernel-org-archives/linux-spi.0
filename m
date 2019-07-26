From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] dt-bindings: spi: sprd: Change the hwlock support to
 be optional
Date: Fri, 26 Jul 2019 12:29:01 +0100
Message-ID: <20190726112901.GC4902@sirena.org.uk>
References: <cover.1564125131.git.baolin.wang@linaro.org>
 <23d51f5d9c9cc647ad0c5a1fb950d3d9fb9c1303.1564125131.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Cc: robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, weicx@spreadst.com, sherry.zong@unisoc.com,
        vincent.guittot@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <23d51f5d9c9cc647ad0c5a1fb950d3d9fb9c1303.1564125131.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2019 at 03:20:53PM +0800, Baolin Wang wrote:
> No need to add hardware spinlock proctection due to add multiple
> msater channel, so change it to be optional in documentation.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl064/wACgkQJNaLcl1U
h9B7bgf/fakNc6GhblvBArHGpWpC8q89Ra3uoMipte1qypILuTKN7E62daZdcjYe
Gj8ANmdKpEkZw01Qst3bSW52x/rxSnP4/FHF/GJCtxtVd/KhM9n+JMMiA4qelyOM
cY9P5GmhDNrVFj1j0rVN0fJ9AIs2ac1dZi8J6CjLsQplr6EoxsimMv2Ajx3eE5rc
p2NLuwvU4iWW4IFm08HME8zJU5vJQB9kLRZedpZMl8ICP4O2gAbR34mHXmvaXdBE
NLETx7mZtKpC1l9H5DSE0t9172tDOceqcJIYwx+4grk8uwDPLvqXZ4UBk2ukvWSI
fgisQ7kn7VuWXe5GeA7R3roV8LUciw==
=6yRt
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
