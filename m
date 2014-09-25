From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 24/27] spi: core: use
 pm_runtime_last_busy_and_autosuspend helper
Date: Thu, 25 Sep 2014 14:04:19 +0100
Message-ID: <20140925130419.GN27755@sirena.org.uk>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
 <1411575342-31048-25-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qi3SIpffvxS/TM8d"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, subhransu.s.prusty-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411575342-31048-25-git-send-email-vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qi3SIpffvxS/TM8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2014 at 09:45:14PM +0530, Vinod Koul wrote:
> Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
> coding the same code

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--qi3SIpffvxS/TM8d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJBLSAAoJECTWi3JdVIfQT8cH/0x56LoEjkklCIPaqF8gCwVv
fwQPlYLkWAWgP/lVqr7aB2QkBX5Fh0O8VGGnjSePcWoAW5ufS1AXwqpcvmKLNBs1
WKxD/SDXDN3+eKIgwbIe/cNvhbAIOW6EZTeBpybBwgYhFdh9Kn4d5TjS7WaOrIZY
ugz4rFBXBT3xrw+PM6x6biGpWsLmbCsqXV0P9gsslBrml8CDcYj2zjOSZlcacz+h
wZugtOM/g68jSfVmeOmcCcewDwENDpOP9vaustW6H+iqZq5lGnauVmh6HEG29kk/
qxj1Rcs/dhP/JHVj+IRfeBUB7q/rzMgW/04u7ahn/00OqMb0Fpqf9Z6o9gS86mA=
=GJ5j
-----END PGP SIGNATURE-----

--qi3SIpffvxS/TM8d--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
