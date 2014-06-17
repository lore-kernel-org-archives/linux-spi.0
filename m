From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI fix for v3.16
Date: Tue, 17 Jun 2014 12:29:06 +0100
Message-ID: <20140617112906.GN5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iTrWFMUu8wG1LMqc"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--iTrWFMUu8wG1LMqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 69e25c755722056b57892bebeb1892e3a6fe8774:

  Merge remote-tracking branch 'spi/topic/workqueue' into spi-next (2014-06-02 17:08:43 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v3.16-rc1

for you to fetch changes up to 01d7aafb3fbaafe2403780ef9ed497b3289ab1b9:

  spi/pxa2xx: change default supported DMA burst size to 1 (2014-06-06 10:52:46 +0100)

----------------------------------------------------------------
spi: Fix for v3.16

A single bugfix from the merge window, fixing an issue with DMA at slow
speeds on Intel hardware.

----------------------------------------------------------------
Chew, Chiau Ee (1):
      spi/pxa2xx: change default supported DMA burst size to 1

 drivers/spi/spi-pxa2xx-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--iTrWFMUu8wG1LMqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJToCZ/AAoJELSic+t+oim99u4QAIHnpYe3K/n/lOIaKOpozy9V
g61/jZNBHLVzFc2TePRm7Fff5XL6svqvWJQtXMN0hEV3dj6ASNdxk5wWYd3HM2IS
8ZJg9FYluZRm6RufbFVehYcsasehkDgayPrQ3dR4n/slNhKar5wnnVDht652bb+C
cph85dXFsRIZCuQwT2IVsekDhF/C327KGcZsaaye6ACL63IQo+fPb/vihoL3cmmU
dBOgY/XqdsGU9O7Y8W6AqT31YZwKtt3gA1KBiOU6cLfKEysPs3S0M306nHI0ArZh
aaX6Tb5kGe7OXTGdU93lLcUUxVsyaDjhuaUztOZaWCbIrGQ++bQS+brV9zteBjd9
pnAt3Ij/vBKpxDuJbL8oDdV4mlAZ7WYfOxjPQypQhO8q/SB7K9uyOlvuF5CVzvEq
jp+1xsew1oa9/tQU0LgO3YrOUBbuWPcsAYPPqmA+Prn4DO+pPGkg953ew+DPUyf5
NMVljEaiSGNu94OmO7YczFK6GQZRlfD9hl3SQWPRd+1Mic4RG25C49sjUbbDLl+A
OlEjc0/J/tFFnZJ1r5riNkHx2pxO6/VUiTpRqQn1Z+oNIBWBvAVOzkgiYeHHzunF
97LAZMDmiHh0SzETqrZCxbp3+8pK0WEC64UbruzVxBr+5yLuCWtGEWCDqYYevN9O
oMBlytmp1jAk+GJPIzNE
=OAQi
-----END PGP SIGNATURE-----

--iTrWFMUu8wG1LMqc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
