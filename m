From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 7/7] [POWERPC][SPI] spi_mpc83xx: allow
	use on any	processors with QUICC Engine
Date: Wed, 26 Sep 2007 17:15:21 +0400
Message-ID: <20070926131521.GA4034@localhost.localdomain>
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143531.GG5323@localhost.localdomain>
	<16E78F0E-B57B-4084-887E-5D2F9C1D0331@kernel.crashing.org>
	<20070925151819.GA6757@localhost.localdomain>
	<20070925165845.40B0E2397FB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<7881139C-EEF1-41DC-AB0F-115632E892B8@kernel.crashing.org>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7881139C-EEF1-41DC-AB0F-115632E892B8-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
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

On Tue, Sep 25, 2007 at 11:00:38PM -0500, Kumar Gala wrote:
> I'm still in favor of making it PPC_83xx || QUICC_ENGINE.

Submitting... ;-)

- - - -
From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [POWERPC][SPI] spi_mpc83xx: allow use on any processors with QUICC Engine

Currently, all QE SPI controllers are almost the same comparing to
MPC83xx's, thus let's use that driver for them.

Tested to work on MPC85xx in loopback mode.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
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
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
