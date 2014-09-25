From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 21/27] spi: omap2-mcspi: use
 pm_runtime_last_busy_and_autosuspend helper
Date: Thu, 25 Sep 2014 14:03:35 +0100
Message-ID: <20140925130335.GK27755@sirena.org.uk>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
 <1411575342-31048-22-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W2ydbIOJmkm74tJ2"
Cc: linux-kernel@vger.kernel.org, subhransu.s.prusty@intel.com,
	linux-spi@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411575342-31048-22-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--W2ydbIOJmkm74tJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2014 at 09:45:11PM +0530, Vinod Koul wrote:
> Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
> coding the same code

Acked-by: Mark Brown <broonie@kernel.org>

though I have to say that the function name is rather spectacularly long
here.

--W2ydbIOJmkm74tJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJBKmAAoJECTWi3JdVIfQ3JsIAIV5+JNPOGg6gJjmKBjWritA
ZZWkO6riCpOJdbjmoSxZ3WZVd0ahmlZjboCdsDpzgVgqu/9f2nlMBG/HmcRe12kX
bSMnh9NWZuRqc2+4xHBq5xKDkS4PNzl/K01IiRuFAHeH5uRL2nN+8b5uWq8oZ1oB
oOE+ztxw9Ga3WkQ0un3cpt8Rb961Y7AfWdDcz3Aey+Zzs5Z1V+LINDx9bv3QCFfp
j/rv8rVku8SXZNEnHyeIzK2PlvZVijGNtCrxGyiTL4vRQO1ghdnAABc+eH2PzF+U
1o9J+GePWUK0PBi0Cbj3ZyJvf4mJoG5gUQflTC6edbEnF5GuQIzBOqihIjR/7+o=
=weOe
-----END PGP SIGNATURE-----

--W2ydbIOJmkm74tJ2--
