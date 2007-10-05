From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 7/7] [POWERPC][SPI] spi_mpc83xx: allow
	use on any	processors with QUICC Engine
Date: Fri, 5 Oct 2007 21:46:33 +0400
Message-ID: <20071005174633.GA32145@localhost.localdomain>
References: <20071005174015.GA11016@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20071005174015.GA11016-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Currently, all QE SPI controllers are almost the same comparing to
MPC83xx's, thus let's use that driver for them.

Tested to work on MPC85xx in loopback mode.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---

This is respin. Hope this time it will get ack from the
PowerPC team.

 drivers/spi/Kconfig |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b915711..a77ede5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -124,16 +124,17 @@ config SPI_MPC52xx_PSC
 	  Controller in master SPI mode.
 
 config SPI_MPC83xx
-	tristate "Freescale MPC83xx SPI controller"
-	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
+	tristate "Freescale MPC83xx/QUICC Engine SPI controller"
+	depends on SPI_MASTER && (PPC_83xx || QUICC_ENGINE) && EXPERIMENTAL
 	select SPI_BITBANG
 	help
-	  This enables using the Freescale MPC83xx SPI controller in master
-	  mode.
+	  This enables using the Freescale MPC83xx and QUICC Engine SPI
+	  controllers in master mode.
 
 	  Note, this driver uniquely supports the SPI controller on the MPC83xx
-	  family of PowerPC processors.  The MPC83xx uses a simple set of shift
-	  registers for data (opposed to the CPM based descriptor model).
+	  family of PowerPC processors, plus processors with QUICC Engine
+	  technology. This driver uses a simple set of shift registers for data
+	  (opposed to the CPM based descriptor model).
 
 config SPI_OMAP_UWIRE
 	tristate "OMAP1 MicroWire"
-- 
1.5.0.6

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
