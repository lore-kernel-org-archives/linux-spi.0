From: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: [PATCH 0/2] fsl: fsl-spi: Fix CMP1 pram allocation and allow dynamic allocation
Date: Fri,  3 Oct 2014 14:56:08 +0200 (CEST)
Message-ID: <20141003125608.A3E7E1AB274@localhost.localdomain>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>,
	scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Marcelo Tosatti <marcelo-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>,
	Vitaly Bordug <vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patchset:
1) Fix parameter ram offset setup for CPM1
2) Allow dynamic allocation of CPM1 parameter RAM

Tested on MPC885.

Signed-off-by: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>

---
 linux/arch/powerpc/platforms/8xx/Kconfig | 11 +++++++++++
 linux/drivers/spi/spi-fsl-cpm.c          | 14 +++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
