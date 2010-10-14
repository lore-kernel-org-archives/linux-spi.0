From: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] spi/fsl_spi: Fix compile errors when building on ppc64
Date: Thu, 14 Oct 2010 08:55:47 -0500
Message-ID: <1287064547-8876-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
To: grant.likely@secretlab.ca
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

We get the following when building on ppc64 due to lack of include of
<asm/io.h>:

In file included from drivers/spi/spi_fsl_espi.c:25:0:
drivers/spi/spi_fsl_lib.h: In function 'mpc8xxx_spi_write_reg':
drivers/spi/spi_fsl_lib.h:88:2: error: implicit declaration of function 'out_be32'
drivers/spi/spi_fsl_lib.h: In function 'mpc8xxx_spi_read_reg':
drivers/spi/spi_fsl_lib.h:93:2: error: implicit declaration of function 'in_be32'
drivers/spi/spi_fsl_espi.c: In function 'fsl_espi_remove':
drivers/spi/spi_fsl_espi.c:571:2: error: implicit declaration of function 'iounmap'
drivers/spi/spi_fsl_espi.c: In function 'fsl_espi_probe':
drivers/spi/spi_fsl_espi.c:602:2: error: implicit declaration of function 'ioremap'
drivers/spi/spi_fsl_espi.c:602:24: warning: assignment makes pointer from integer without a cast

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/spi/spi_fsl_lib.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_fsl_lib.h b/drivers/spi/spi_fsl_lib.h
index 15aa6c2..281e060 100644
--- a/drivers/spi/spi_fsl_lib.h
+++ b/drivers/spi/spi_fsl_lib.h
@@ -18,6 +18,8 @@
 #ifndef __SPI_FSL_LIB_H__
 #define __SPI_FSL_LIB_H__
 
+#include <asm/io.h>
+
 /* SPI/eSPI Controller driver's private data. */
 struct mpc8xxx_spi {
 	struct device *dev;
-- 
1.7.2.3
