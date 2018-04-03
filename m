From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] spi: spi-ti-qspi: Fix parameters order in
 regmap_update_bits calls
Date: Tue, 3 Apr 2018 10:09:20 +0100
Message-ID: <20180403090920.GA30411@sirena.org.uk>
References: <496c162d-5e3c-e008-a14b-6b990e253e64@ti.com>
 <1522402884-26790-1-git-send-email-arkadiusz.kwiatkowski@aptiv.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Cc: vigneshr@ti.com, sourav.poddar@ti.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1522402884-26790-1-git-send-email-arkadiusz.kwiatkowski@aptiv.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 30, 2018 at 11:41:23AM +0200, Arkadiusz Kwiatkowski wrote:
> This commit fixes the order of parameters passed to regmap_update_bits
> function inside spi-ti-qspi driver. Accidentally the code worked
> correctly when cs=0, but it is not the case for other values.

This doesn't apply against current code, please check and resend.

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrDRL8ACgkQJNaLcl1U
h9BZ9Qf/a5Ds2OxypkXyedwPwkzkiJA32hBqEh1HiWQvPtOljc1wvKMFNFlAG2Lf
FPCSJWyOiSIMbrN48SMKUn0zshOpY5fOxavHpI16GE0EFlP36Pf9TS9u8N6Qy3nS
+lrmWdVysrUia/d9sg6hNLLs2YNRdfmBijX6XPGaOPqnpGyPSP3y5hXZr9AdKscG
q1JDPiqtk1NFagiLb4BmO6PJ3CawZQ5jod5qu029BPi8wL/zffLyYaBQRYBfbp8U
nmHEcrn+urMpmmgmFVSSqMb/puaYx5MbMtngWE6yXTY4Pp8PC/16zBE2/O2gExuw
JEKYpnq11LWoVGJt+e6O8WUI8eK+vw==
=CoBX
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
