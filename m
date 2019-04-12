From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: Add spi_is_bpw_supported()
Date: Fri, 12 Apr 2019 11:16:52 +0100
Message-ID: <20190412101652.GF6909@sirena.org.uk>
References: <20190412094131.25616-1-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0842659531=="
Cc: dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190412094131.25616-1-noralf@tronnes.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
List-Id: linux-spi.vger.kernel.org


--===============0842659531==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2019 at 11:41:30AM +0200, Noralf Tr=F8nnes wrote:
> This let SPI clients check if the controller supports a particular word
> width. drivers/gpu/drm/tinydrm/mipi-dbi.c will use this to determine if
> the controller supports 16-bit for RGB565 pixels. If it doesn't it will
> swap the bytes before transfer on little endian machines.

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
bpw-is-supported

for you to fetch changes up to e6f3f7e4dc76eb8d8a546dc66621a02c5c84f4ac:

  spi: Add spi_is_bpw_supported() (2019-04-12 11:13:36 +0100)

----------------------------------------------------------------
spi: Add spi_is_bpw_supported()

Lets client drivers check and potentially handle issues.

----------------------------------------------------------------
Noralf Tr=F8nnes (1):
      spi: Add spi_is_bpw_supported()

 include/linux/spi/spi.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywZZMACgkQJNaLcl1U
h9CuNggAgp86JGebZHJT6nnSDJEmlrX5RyuqUtYAKoTAPP1KcNlNXBiiSLR7yBMQ
KtbhHTmn+0HBsYOzoMDqIUabclku9/O1fhi7UYuF0DVdkldEp+Yi1VONasv9147a
lMukJHdqHziI/+/C84jJpYcRqxU50xMkcUabVKv5fXGI/xYLyNo/Si7GDqoFJ/ng
ac1u7jXCOEcDkPxKfZJgZg+jOg1a9MFFndNiVeY8wvji763KgHHKUBigFV2tPivF
ZxAzu6B39a1jNRh1NKjikL3IYsWxlCCGgG082BgIkfA0/F08ZpRVWagUie/QWc7b
qLjeHwTRQOohq6i0jVALoVj3Jpi9GA==
=zxyr
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--

--===============0842659531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0842659531==--
