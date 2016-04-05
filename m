From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI fixes for v4.6
Date: Tue, 5 Apr 2016 11:36:32 -0700
Message-ID: <20160405183632.GI1924@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h22Fi9ANawrtbNPX"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--h22Fi9ANawrtbNPX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:

  Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fi=
x-v4.6-rc2

for you to fetch changes up to cb39f732abbe4f38d2bef8e0a1c8bd5c242fc1b7:

  Merge remote-tracking branches 'spi/fix/omap2' and 'spi/fix/rockchip' int=
o spi-linus (2016-04-04 10:05:49 -0700)

----------------------------------------------------------------
spi: Fixes for v4.6

A couple of driver specific fixes here that came in since the merge
window plus one core fix for locking in cases where a client driver
grabs a lock on the whole bus for an extended series of operations that
was introduced by the changes to support accelerated flash operations.

----------------------------------------------------------------
Akinobu Mita (1):
      spi: omap2-mcspi: fix dma transfer for vmalloced buffer

Geert Uytterhoeven (1):
      spi: rockchip: Spelling s/divsor/divisor/

Heiko St=FCbner (1):
      spi: fix possible deadlock between internal bus locks and bus_lock_fl=
ag

Knut Wohlrab (1):
      spi: imx: only do necessary changes to ECSPIx_CONFIGREG

Mark Brown (3):
      Merge remote-tracking branch 'spi/fix/core' into spi-linus
      Merge remote-tracking branch 'spi/fix/imx' into spi-linus
      Merge remote-tracking branches 'spi/fix/omap2' and 'spi/fix/rockchip'=
 into spi-linus

Sascha Hauer (1):
      spi: imx: Fix possible NULL pointer deref

Shawn Lin (1):
      spi: rockchip: fix probe deferral handling

 drivers/spi/spi-imx.c         | 16 +++++++++--
 drivers/spi/spi-omap2-mcspi.c | 62 ++++++++++++---------------------------=
----
 drivers/spi/spi-rockchip.c    | 16 ++++++-----
 drivers/spi/spi.c             |  4 +--
 4 files changed, 43 insertions(+), 55 deletions(-)

--h22Fi9ANawrtbNPX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXBAWvAAoJECTWi3JdVIfQR9QH/AtRK/cH/XfbwGeYgzVBhBiS
pxtiYyeo3DPEn4nGA2fuQe/6Q8+ND4AKzEh2XqVKNeAcklw4wTob3waDwKlN7Yxr
nvQmVtwxXbE3412hBdzE8V9iew48UF4ji9YSzWzNS5FjhSrOrUBu+nJ+XmMUcsVz
Ti9XKOgaTnDRi+iEyaBnSxya2iTHh20Zn3MdHNtlTeJXldaRhCQlJpnye+Fs55Dh
bE9d7RFpTTlksNfdsZZDv8uA77fCxw/Qwdt2NKGRECoPx/sTULQInjD+dJOFfGLr
PMe5ryQRXXI01IEjQlSLURmQWfyDbAOg132FCRgCq1uVjihfXtpS6+yX+qtD17I=
=rRU1
-----END PGP SIGNATURE-----

--h22Fi9ANawrtbNPX--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
