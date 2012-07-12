From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 0/6] spi: s3c64xx: add support for device tree
Date: Thu, 12 Jul 2012 14:02:34 +0100
Message-ID: <20120712130234.GE3957@opensource.wolfsonmicro.com>
References: <1342021265-11212-1-git-send-email-thomas.abraham@linaro.org>
 <20120711174908.GP3938@opensource.wolfsonmicro.com>
 <CAJuYYwQA_x112xqOnQmwZjzoXoR-DAvT8YdB90Wm=78CH72uOg@mail.gmail.com>
 <0fae01cd600e$442ed160$cc8c7420$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Cc: 'Thomas Abraham' <thomas.abraham@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, jaswinder.singh@linaro.org
To: Kukjin Kim <kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0fae01cd600e$442ed160$cc8c7420$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 12, 2012 at 06:11:05PM +0900, Kukjin Kim wrote:

> And Mark, this touches various samsung stuff in arch/arm/ so if you're ok,
> I'd like to pick this up in samsung tree. We don't want to see conflicts...

Well, simple conflicts aren't that big a deal...  However, Thomas
mentioned that in order to test this he merged the SPI tree into your
tree so perhaps there is also a dependency on the SPI tree?  If that was
just for good practice testing then I agree that the best thing is to
merge via your tree, otherwise we might need to think harder.

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP/srhAAoJEBus8iNuMP3dxxMP/ROIbrDTIBfVH+Nn/yNnbayf
A0EDAa2zBh1z0xY3XCL3TOPL6S/9SuLvEsQFrohFSF0gjJfOJfn0y5iQEERA1BTS
ITwA46m0I4aKowqfNZpTRrveh8qYIvNmKHODYD5dWGhdrm/0xypSSowzFrZH1lom
pbPjUCr/v9s94XYYh5Qprs+pjuNqn9pqbWTH5nvIgHumZdRvCiJqtacZWVs3IJ4B
vm14546Ox72Bqqpfb+ea54KJMXob0puWJNIVWVFXu8NYrSx9iR8ice2JgSbDw/22
3HOLcP1j6kI4hYVEviF11y9o81HpZVhb64qpoE99jDp8dOu9Mi3TGvo58SOvS2ML
ovrdLgIAZ9JKfMSg1g5t8fPN5XXAJlEsmD8W0PBEtPQcmop2vCySW1It6C7K3UKu
oQARD/Mcp9oSbKO0LJ8st7ag9dOZBRVryfPPKzJwnQkoUtGepEW/QZvIAugGgAqL
g6a1yB6PKDDkRHM+LVAxegqX+nL0OsnPYlH6DNpp/r88cCo3KfIQ7a0z+LFK0h7F
acO4wWu0eaCawR8lk/rEfnkZ13Ks4rMpmFiAdYX3ceJDjwX1MApK1G/6XgM2a8Xq
nQQaxQ0MwbJ2Aph/6y1n7FEKDuPDOmwEjzigpRClIr6liP4Z0cgnaLSg4scgddpo
pNCcaI5umZJiIyFDxTRN
=3YHP
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
