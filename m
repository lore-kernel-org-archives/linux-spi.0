From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 4/8] powerpc/qe&cpm: Implement static
 inline stubs for non-QE/CPM builds
Date: Mon, 12 Oct 2009 20:49:20 +0400
Message-ID: <20091012164920.GD4578@oksana.dev.rtsoft.ru>
References: <20091012164841.GA32214@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091012164841.GA32214-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is needed to avoid ugly #ifdefs in drivers. Also update fsl_qe_udc
driver so that now it doesn't define its own versions that cause build
breakage when the generic stubs are used.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Acked-by: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
---
 arch/powerpc/include/asm/cpm.h  |   44 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/qe.h   |   11 ++++++++-
 drivers/usb/gadget/fsl_qe_udc.h |   15 -------------
 3 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/cpm.h b/arch/powerpc/include/asm/cpm.h
index ea3fdb9..0835eb9 100644
--- a/arch/powerpc/include/asm/cpm.h
+++ b/arch/powerpc/include/asm/cpm.h
@@ -3,6 +3,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/errno.h>
 #include <linux/of.h>
 
 /*
@@ -131,13 +132,56 @@ typedef struct cpm_buf_desc {
 #define BD_I2C_START		(0x0400)
 
 int cpm_muram_init(void);
+
+#if defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE)
 unsigned long cpm_muram_alloc(unsigned long size, unsigned long align);
 int cpm_muram_free(unsigned long offset);
 unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size);
 void __iomem *cpm_muram_addr(unsigned long offset);
 unsigned long cpm_muram_offset(void __iomem *addr);
 dma_addr_t cpm_muram_dma(void __iomem *addr);
+#else
+static inline unsigned long cpm_muram_alloc(unsigned long size,
+					    unsigned long align)
+{
+	return -ENOSYS;
+}
+
+static inline int cpm_muram_free(unsigned long offset)
+{
+	return -ENOSYS;
+}
+
+static inline unsigned long cpm_muram_alloc_fixed(unsigned long offset,
+						  unsigned long size)
+{
+	return -ENOSYS;
+}
+
+static inline void __iomem *cpm_muram_addr(unsigned long offset)
+{
+	return NULL;
+}
+
+static inline unsigned long cpm_muram_offset(void __iomem *addr)
+{
+	return -ENOSYS;
+}
+
+static inline dma_addr_t cpm_muram_dma(void __iomem *addr)
+{
+	return 0;
+}
+#endif /* defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE) */
+
+#ifdef CONFIG_CPM
 int cpm_command(u32 command, u8 opcode);
+#else
+static inline int cpm_command(u32 command, u8 opcode)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_CPM */
 
 int cpm2_gpiochip_add32(struct device_node *np);
 
diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
index f388f0a..d013d7e 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
@@ -145,8 +145,17 @@ static inline void qe_pin_set_gpio(struct qe_pin *qe_pin) {}
 static inline void qe_pin_set_dedicated(struct qe_pin *pin) {}
 #endif /* CONFIG_QE_GPIO */
 
-/* QE internal API */
+#ifdef CONFIG_QUICC_ENGINE
 int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input);
+#else
+static inline int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol,
+			       u32 cmd_input)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_QUICC_ENGINE */
+
+/* QE internal API */
 enum qe_clock qe_clock_source(const char *source);
 unsigned int qe_get_brg_clk(void);
 int qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier);
diff --git a/drivers/usb/gadget/fsl_qe_udc.h b/drivers/usb/gadget/fsl_qe_udc.h
index 31b2710..bea5b82 100644
--- a/drivers/usb/gadget/fsl_qe_udc.h
+++ b/drivers/usb/gadget/fsl_qe_udc.h
@@ -419,19 +419,4 @@ struct qe_udc {
 #define CPM_USB_RESTART_TX_OPCODE 0x0b
 #define CPM_USB_EP_SHIFT 5
 
-#ifndef CONFIG_CPM
-inline int cpm_command(u32 command, u8 opcode)
-{
-	return -EOPNOTSUPP;
-}
-#endif
-
-#ifndef CONFIG_QUICC_ENGINE
-inline int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol,
-	u32 cmd_input)
-{
-	return -EOPNOTSUPP;
-}
-#endif
-
 #endif  /* __FSL_QE_UDC_H */
-- 
1.6.3.3


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
