From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI fixes for v3.15
Date: Wed, 14 May 2014 17:08:38 +0100
Message-ID: <20140514160838.GJ12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYSHSYKTlyb6iK5t"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zYSHSYKTlyb6iK5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit d6d211db37e75de2ddc3a4f979038c40df7cc79c:

  Linux 3.15-rc5 (2014-05-09 13:10:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git spi-v3.15-rc5

for you to fetch changes up to fd30c37331ad8ed7c7e0e4c21f5ee309fec21d7d:

  Merge remote-tracking branches 'spi/fix/pxa2xx' and 'spi/fix/qup' into spi-linus (2014-05-13 19:08:34 +0100)

----------------------------------------------------------------

spi: Fixes for v3.15

A few core fixes around outlying cases here, nothing that should affect
most users but useful fixes.  The diffstat is rather larger than one
might hope due some simple code motion in the fix for !CONFIG_DMA, the
actual meaningful change is much smaller.

 - Fix handling of unsupported dual and quad mode support on slave
   registration so that drivers that can degrade gracefully do so,
   preventing regressions for drivers this is added.
 - Fix build in !CONFIG_DMA cases following addition of generic DMA
   mapping support.
 - Fix error handling for queue creation which due to wider kernel
   changes can be triggered more easily.
 - A couple of driver specific fixes.

----------------------------------------------------------------
Axel Lin (1):
      spi: qup: Fix return value checking for pm_runtime_get_sync()

Geert Uytterhoeven (2):
      spi: core: Ignore unsupported Dual/Quad Transfer Mode bits
      spi: core: Protect DMA code by #ifdef CONFIG_HAS_DMA

Mark Brown (3):
      spi: core: Don't destroy master queue if we fail to create it
      Merge remote-tracking branch 'spi/fix/core' into spi-linus
      Merge remote-tracking branches 'spi/fix/pxa2xx' and 'spi/fix/qup' into spi-linus

Mika Westerberg (1):
      spi/pxa2xx: Prevent DMA from transferring too many bytes

 drivers/spi/spi-pxa2xx-dma.c |  16 ------
 drivers/spi/spi-qup.c        |   2 +-
 drivers/spi/spi.c            | 124 +++++++++++++++++++++++++++----------------
 3 files changed, 78 insertions(+), 64 deletions(-)

--zYSHSYKTlyb6iK5t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTc5UDAAoJELSic+t+oim9sS8QAIrS1XDwmv1B5VsFNnXjqWpg
+Q7XH14PZ6h9KZZy5UMrBsKwr5NmPYwz/8d6q8i3tZbmwHy8jqUxI00Lyf+k8L3L
y73mq9jHDrsPt0kbPDmryDHvt9bTzonZS6rr1zRV8MxDYte/PJWZkMQN+DZ9WLQ9
JuPcvQKdKAkLj/iPDahr+YlJbwkEwO26nA4Kbp3fTLROBBjTWyqr9i+tXMUrk2pA
pW0HB8/tH8arJnW+EkCMLlI/TIBbd/uSib5a6qb8b9okYECu+hbX8sbhahjyNjAG
ZgD+EpoxDf8AIBK24DkLyrNcaN9ADs9n1YMZhpuNlAtaJVjrpKM1uj1eKXONa8GB
yJ5C0Wl5XzQ1ha4qE/fN40Ue7sVrIne8/0dc2Me8TDez96EZS8wnSY05JZ//1/Ja
d1XSRKBvTMjGpjeOiRFizQycLJk0XH+EXZHro0hR1YR4rebcnW97L3hMwE/j/YqG
PYHZic5XKUxvDN7UHMy4UFYMvJwk9uNzrzF0AzNC0vgaP6hXilXYah05DngsPvJN
aFECv90bjDWLFKRNHWweXLPRP6k1SzhasZFb/5+4pCg+3MPc2EHoh2wU4ZT685Lq
oAP9+Ja5OC6VQ6J3l6bONZJocPoEr7v+4radV2V3JVFsiUs8uOGJBnUPorD0Re2y
hUwj6me5WFhkqq9oyfG9
=r1wU
-----END PGP SIGNATURE-----

--zYSHSYKTlyb6iK5t--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
