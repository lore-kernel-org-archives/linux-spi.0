From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] spi: sprd: Change to use
 devm_hwspin_lock_request_specific()
Date: Mon, 25 Jun 2018 13:47:58 +0100
Message-ID: <20180625124758.GN9413@sirena.org.uk>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
 <1662400fb204bbbe9a36edf580ea267079a2a02e.1529654288.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UExESr5xZTMxdOWv"
Cc: ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-spi@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1662400fb204bbbe9a36edf580ea267079a2a02e.1529654288.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--UExESr5xZTMxdOWv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 22, 2018 at 04:09:05PM +0800, Baolin Wang wrote:
> Change to use devm_hwspin_lock_request_specific() instead of
> freeing the hwlock explicitly when unbound the device.

Acked-by: Mark Brown <broonie@kernel.org>

--UExESr5xZTMxdOWv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsw5H0ACgkQJNaLcl1U
h9Bbnwf+I+AYIS79+tNB+hmEicRXydey0TKXbPL7tuLJM4PGz2Wu41MYSHCrMPhF
Q+QALphCYNa3gGMvmaSxg5DEV04QK9+v6wXnPk4q/5XdVXb4v54Mo5o6PV5rZpFw
BgqwXL91oQ+7FzqZQiJscj+Jvf5bQFajy47ItPo+1fFHK1fE2kUmIcQs2VetgBz6
ZUBVkOgPs374xVoOL2Kzbkf7wu7FJn9HNdaOwmHi6kWDLy/pCtsSZJC7OqacBgKX
6UIg56z+LAZDqt0kRY4zp60hOwzTp4lQ7ZVTZ43H7Cyl7kwVInIpURyOEr+ujIBY
IrHYSDa8o71lCkZGQ8dbCRMppEY4iQ==
=kvuL
-----END PGP SIGNATURE-----

--UExESr5xZTMxdOWv--
