From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 23/27] spi: ti-qspi: use
 pm_runtime_last_busy_and_autosuspend helper
Date: Thu, 25 Sep 2014 14:04:07 +0100
Message-ID: <20140925130407.GM27755@sirena.org.uk>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
 <1411575342-31048-24-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yklP1rR72f9kjNtc"
Cc: linux-kernel@vger.kernel.org, subhransu.s.prusty@intel.com,
	linux-spi@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411575342-31048-24-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--yklP1rR72f9kjNtc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2014 at 09:45:13PM +0530, Vinod Koul wrote:
> Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
> coding the same code

Acked-by: Mark Brown <broonie@kernel.org>

--yklP1rR72f9kjNtc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJBLGAAoJECTWi3JdVIfQ93UH/0Q77ezZ7u8WTStyFUfdDjqT
azulxjSmrDra8ZvymPrjRSfdABorXErBDEMZQhPA7A/y/7TvmWn8yTnexRe8+7gH
+EWALgzIVv8ZSxGSz7a9f9XND0ZEtrbcEpLHslDIORtDMe7QyQ8Mt/Fk0oynYbQp
KbkUrKHaEAhQqDlXtm9KuaT26VjsBWnJmVk54UUjEO5/EDUpfzUE+iO9eNvmRqAU
4kwKwW2vXuqv5LW/aKeLhEqplbUGT+AmkijxM//efq1KbwRERrHi80hgNzwvasRH
ODOcbcSyOok2tcKVptHVYkhnXJGNPNcNm7LgsdH4XlTmUBkKe+bf/0IeweOeRuE=
=34Kj
-----END PGP SIGNATURE-----

--yklP1rR72f9kjNtc--
