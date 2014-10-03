From: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: [PATCH 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1 parameter RAM
Date: Fri,  3 Oct 2014 14:56:09 +0200 (CEST)
Message-ID: <20141003125609.5BEA11AB276@localhost.localdomain>
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

On CPM1, the SPI parameter RAM has a default location. In order to use SPI while
using SCC2 with features like QMC or Ethernet, it is necessary to relocate SPI
parameter RAM in a free location in the CPM dual port RAM. With this patch,
when CONFIG_CPM1_RELOCSPI is set, the parameter RAM for SPI is dynamically
allocated with cpm_muram_alloc().

Signed-off-by: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>

---
 arch/powerpc/platforms/8xx/Kconfig | 11 +++++++++++
 drivers/spi/spi-fsl-cpm.c          |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 7c1690b..3b76a3f 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -203,4 +203,15 @@ config UCODE_PATCH
 	default y
 	depends on !NO_UCODE_PATCH
 
+config CPM1_RELOCSPI
+	bool "Dynamic SPI relocation"
+	default n
+	help
+	  On recent MPC8xx (at least MPC866 and MPC885) SPI can be relocated
+	  without micropatch. This activates relocation to a dynamically
+	  allocated area in the CPM Dual port RAM.
+	  When combined with SPI relocation patch (for older MPC8xx) it avoids
+	  the "loss" of additional Dual port RAM space just above the patch,
+	  which might be needed for example when using the CPM QMC.
+
 endmenu
diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 0f3a912..f33820e 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -262,6 +262,10 @@ static unsigned long fsl_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
 		pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
 		out_be16(spi_base, pram_ofs);
 	} else {
+#ifdef CONFIG_CPM1_RELOCSPI
+		pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 32);
+		out_be16(spi_base, pram_ofs);
+#else
 		u16 rpbase = in_be16(spi_base);
 
 		/* Microcode relocation patch applied | rpbase set by default */
@@ -271,6 +275,7 @@ static unsigned long fsl_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
 			pram_ofs = offsetof(cpm8xx_t, cp_dparam[PROFF_SPI]) -
 				   offsetof(cpm8xx_t, cp_dpmem[0]);
 		}
+#endif
 	}
 
 	iounmap(spi_base);
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
