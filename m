From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: Generalize SPI "master" to "controller"
Date: Fri, 26 May 2017 18:35:28 +0100
Message-ID: <20170526173528.fgdda6u4tzw3g7rr@sirena.org.uk>
References: <1493920140-32497-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7lmh6k6ytdq3zahu"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1493920140-32497-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7lmh6k6ytdq3zahu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 04, 2017 at 07:49:00PM +0200, Geert Uytterhoeven wrote:
> Now struct spi_master is used for both SPI master and slave controllers,
> it makes sense to rename it to struct spi_controller, and replace
> "master" by "controller" where appropriate.

> For now this conversion is done for SPI core infrastructure only.
> Wrappers are provided for backwards compatibility, until all SPI drivers
> have been converted.

This makes sense to me.  The patch needs a rebase though.

> I guess we don't need an spi_busnum_to_slave()?
> There's also only one user of spi_busnum_to_master(), in
> drivers/staging/fbtft/fbtft_device.c

Hrm, I'm not sure that either of those functions has a strong use case.
I'm not quite sure from a quick glance at that staging driver what
exactly it's trying to do there, it looks like it's something that'd
need refactoring to go out of staging.

--7lmh6k6ytdq3zahu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkoZ2AACgkQJNaLcl1U
h9Ctsgf9HL2kNHGtIsO6sX3az/7tpAhwuM2OMVKBzZEpn3oVFCm5umxXyxmmZeF8
i07hMkbl3slXGDdFv12lGvFk+3RtfIpAFSywlBLN4HYJ5tpvjVr6ZWlnNeJqLeKM
XZ7RnSeK/mLgQUZp+d86HWQrkY24w0TBiCHWyfTMm739h0M0BbgH7qclyOpZSAUz
27H3f1XqdfyfJUl8XeRRGsi6POekcjvZz/R48yNSDdcQG9cST1EEYplIipN2HnkU
+BO2R33fuvjl5Jfo/AGmYpwhNc4rgiTwnNwmyw9s7g75856fPC60oBcq8og/9x1a
qJhPNRKjWHYLcylGz16gltxyDVKObA==
=tBUQ
-----END PGP SIGNATURE-----

--7lmh6k6ytdq3zahu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
