From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 3/8] powerpc/cpm: Move CPMFCR_* defines into cpm.h
Date: Sat, 15 Aug 2009 02:25:40 +0400
Message-ID: <20090814222540.GC14458@oksana.dev.rtsoft.ru>
References: <20090814222453.GA9568@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kumar Gala <galak@kernel.crashing.org>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
To: David Brownell <dbrownell@users.sourceforge.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757183AbZHNWZl@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090814222453.GA9568@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The bits are generic to CPM devices, so let's move them to the
common header file, so drivers won't need to privately reintroduce
another bunch of the same bits (as we can't include cpm2.h header
together with cpm1.h).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/include/asm/cpm.h  |   16 ++++++++++++++++
 arch/powerpc/include/asm/cpm2.h |    8 --------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/cpm.h b/arch/powerpc/include/asm/cpm.h
index b5f1534..ea3fdb9 100644
--- a/arch/powerpc/include/asm/cpm.h
+++ b/arch/powerpc/include/asm/cpm.h
@@ -27,6 +27,22 @@ struct usb_ctlr {
 	u8	res6[0x22];
 } __attribute__ ((packed));
 
+/*
+ * Function code bits, usually generic to devices.
+ */
+#ifdef CONFIG_CPM1
+#define CPMFCR_GBL	((u_char)0x00)	/* Flag doesn't exist in CPM1 */
+#define CPMFCR_TC2	((u_char)0x00)	/* Flag doesn't exist in CPM1 */
+#define CPMFCR_DTB	((u_char)0x00)	/* Flag doesn't exist in CPM1 */
+#define CPMFCR_BDB	((u_char)0x00)	/* Flag doesn't exist in CPM1 */
+#else
+#define CPMFCR_GBL	((u_char)0x20)	/* Set memory snooping */
+#define CPMFCR_TC2	((u_char)0x04)	/* Transfer code 2 value */
+#define CPMFCR_DTB	((u_char)0x02)	/* Use local bus for data when set */
+#define CPMFCR_BDB	((u_char)0x01)	/* Use local bus for BD when set */
+#endif
+#define CPMFCR_EB	((u_char)0x10)	/* Set big endian byte order */
+
 /* Opcodes common to CPM1 and CPM2
 */
 #define CPM_CR_INIT_TRX		((ushort)0x0000)
diff --git a/arch/powerpc/include/asm/cpm2.h b/arch/powerpc/include/asm/cpm2.h
index 236cfa3..f42e9ba 100644
--- a/arch/powerpc/include/asm/cpm2.h
+++ b/arch/powerpc/include/asm/cpm2.h
@@ -124,14 +124,6 @@ static inline void cpm2_fastbrg(uint brg, uint rate, int div16)
 	__cpm2_setbrg(brg, rate, CPM2_BRG_INT_CLK, div16, CPM_BRG_EXTC_INT);
 }
 
-/* Function code bits, usually generic to devices.
-*/
-#define CPMFCR_GBL	((u_char)0x20)	/* Set memory snooping */
-#define CPMFCR_EB	((u_char)0x10)	/* Set big endian byte order */
-#define CPMFCR_TC2	((u_char)0x04)	/* Transfer code 2 value */
-#define CPMFCR_DTB	((u_char)0x02)	/* Use local bus for data when set */
-#define CPMFCR_BDB	((u_char)0x01)	/* Use local bus for BD when set */
-
 /* Parameter RAM offsets from the base.
 */
 #define PROFF_SCC1		((uint)0x8000)
-- 
1.6.3.3
