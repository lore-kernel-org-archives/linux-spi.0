From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 5/9] spi_mpc83xx: Fix checkpatch issues
Date: Fri, 1 May 2009 03:48:27 +0400
Message-ID: <20090430234827.GE7901@oksana.dev.rtsoft.ru>
References: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090430234739.GA27709-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Checkpatch is spitting errors when seeing the rename patch, so fix
the errors prior to moving.

Following errors and warnings were fixed:

WARNING: Use #include <linux/io.h> instead of <asm/io.h>
#1027: FILE: drivers/spi/spi_mpc8xxx.c:37:
+#include <asm/io.h>

ERROR: "foo * bar" should be "foo *bar"
#1111: FILE: drivers/spi/spi_mpc8xxx.c:121:
+static inline void mpc83xx_spi_write_reg(__be32 __iomem * reg, u32 val)

ERROR: "foo * bar" should be "foo *bar"
#1116: FILE: drivers/spi/spi_mpc8xxx.c:126:
+static inline u32 mpc83xx_spi_read_reg(__be32 __iomem * reg)

ERROR: "foo * bar" should be "foo *bar"
#1125: FILE: drivers/spi/spi_mpc8xxx.c:135:
+       type * rx = mpc83xx_spi->rx;                                      \

ERROR: "foo * bar" should be "foo *bar"
#1135: FILE: drivers/spi/spi_mpc8xxx.c:145:
+       const type * tx = mpc83xx_spi->tx;                      \

WARNING: suspect code indent for conditional statements (16, 25)
#1504: FILE: drivers/spi/spi_mpc8xxx.c:514:
+               while (((event =
[...]
+                        cpu_relax();

Following warnings were left over, since fixing them will
hurt the readability. We'd better fix them by lowering
the indentation level by splitting mpc83xx_spi_work function
into two parts.

WARNING: line over 80 characters
#1371: FILE: drivers/spi/spi_mpc8xxx.c:381:
+                                       status = mpc83xx_spi_setup_transfer(spi, t);

WARNING: line over 80 characters
#1392: FILE: drivers/spi/spi_mpc8xxx.c:402:
+                               mpc83xx_spi_chipselect(spi, BITBANG_CS_INACTIVE);

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 drivers/spi/spi_mpc83xx.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index d378d5e..40f7448 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -17,6 +17,7 @@
 #include <linux/bug.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -34,7 +35,6 @@
 
 #include <sysdev/fsl_soc.h>
 #include <asm/irq.h>
-#include <asm/io.h>
 
 /* SPI Controller registers */
 struct mpc83xx_spi_reg {
@@ -118,12 +118,12 @@ struct spi_mpc83xx_cs {
 	u32 hw_mode;		/* Holds HW mode register settings */
 };
 
-static inline void mpc83xx_spi_write_reg(__be32 __iomem * reg, u32 val)
+static inline void mpc83xx_spi_write_reg(__be32 __iomem *reg, u32 val)
 {
 	out_be32(reg, val);
 }
 
-static inline u32 mpc83xx_spi_read_reg(__be32 __iomem * reg)
+static inline u32 mpc83xx_spi_read_reg(__be32 __iomem *reg)
 {
 	return in_be32(reg);
 }
@@ -132,7 +132,7 @@ static inline u32 mpc83xx_spi_read_reg(__be32 __iomem * reg)
 static									  \
 void mpc83xx_spi_rx_buf_##type(u32 data, struct mpc83xx_spi *mpc83xx_spi) \
 {									  \
-	type * rx = mpc83xx_spi->rx;					  \
+	type *rx = mpc83xx_spi->rx;					  \
 	*rx++ = (type)(data >> mpc83xx_spi->rx_shift);			  \
 	mpc83xx_spi->rx = rx;						  \
 }
@@ -142,7 +142,7 @@ static								\
 u32 mpc83xx_spi_tx_buf_##type(struct mpc83xx_spi *mpc83xx_spi)	\
 {								\
 	u32 data;						\
-	const type * tx = mpc83xx_spi->tx;			\
+	const type *tx = mpc83xx_spi->tx;			\
 	if (!tx)						\
 		return 0;					\
 	data = *tx++ << mpc83xx_spi->tx_shift;			\
@@ -516,7 +516,7 @@ static irqreturn_t mpc83xx_spi_irq(s32 irq, void *context_data)
 		while (((event =
 			 mpc83xx_spi_read_reg(&mpc83xx_spi->base->event)) &
 						SPIE_NF) == 0)
-			 cpu_relax();
+			cpu_relax();
 
 	mpc83xx_spi->count -= 1;
 	if (mpc83xx_spi->count) {
-- 
1.6.2.2


------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
