From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 49/49] spi: davinci: kconfig: add manufacturer name to prompt
	string
Date: Wed, 17 Nov 2010 16:14:21 +0530
Message-ID: <1289990661-30126-50-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
	<1289990661-30126-4-git-send-email-nsekhar@ti.com>
	<1289990661-30126-5-git-send-email-nsekhar@ti.com>
	<1289990661-30126-6-git-send-email-nsekhar@ti.com>
	<1289990661-30126-7-git-send-email-nsekhar@ti.com>
	<1289990661-30126-8-git-send-email-nsekhar@ti.com>
	<1289990661-30126-9-git-send-email-nsekhar@ti.com>
	<1289990661-30126-10-git-send-email-nsekhar@ti.com>
	<1289990661-30126-11-git-send-email-nsekhar@ti.com>
	<1289990661-30126-12-git-send-email-nsekhar@ti.com>
	<1289990661-30126-13-git-send-email-nsekhar@ti.com>
	<1289990661-30126-14-git-send-email-nsekhar@ti.com>
	<1289990661-30126-15-git-send-email-nsekhar@ti.com>
	<1289990661-30126-16-git-send-email-nsekhar@ti.com>
	<1289990661-30126-17-git-send-email-nsekhar@ti.com>
	<1289990661-30126-18-git-send-email-nsekhar@ti.com>
	<1289990661-30126-19-git-send-email-nsekhar@ti.com>
	<1289990661-30126-20-git-send-email-nsekhar@ti.com>
	<1289990661-30126-21-git-send-email-nsekhar@ti.com>
	<1289990661-30126-22-git-send-email-nsekhar@ti.com>
	<1289990661-30126-23-git-send-email-nsekhar@ti.com>
	<1289990661-30126-24-git-send-email-nsekhar@ti.com>
	<1289990661-30126-25-git-send-email-nsekhar@ti.com>
	<1289990661-30126-26-git-send-email-nsekhar@ti.com>
	<1289990661-30126-27-git-send-email-nsekhar@ti.com>
	<1289990661-30126-28-git-send-email-nsekhar@ti.com>
	<1289990661-30126-29-git-send-email-nsekhar@ti.com>
	<1289990661-30126-30-git-send-email-nsekhar@ti.com>
	<1289990661-30126-31-git-send-email-nsekhar@ti.com>
	<1289990661-30126-32-git-send-email-nsekhar@ti.com>
	<1289990661-30126-33-git-send-email-nsekhar@ti.com>
	<1289990661-30126-34-git-send-email-nsekhar@ti.com>
	<1289990661-30126-35-git-send-email-nsekhar@ti.com>
	<1289990661-30126-36-git-send-email-nsekhar@ti.com>
	<1289990661-30126-37-git-send-email-nsekhar@ti.com>
	<1289990661-30126-38-git-send-email-nsekhar@ti.com>
	<1289990661-30126-39-git-send-email-nsekhar@ti.com>
	<1289990661-30126-40-git-send-email-nsekhar@ti.com>
	<1289990661-30126-41-git-send-email-nsekhar@ti.com>
	<1289990661-30126-42-git-send-email-nsekhar@ti.com>
	<1289990661-30126-43-git-send-email-nsekhar@ti.com>
	<1289990661-30126-44-git-send-email-nsekhar@ti.com>
	<1289990661-30126-45-git-send-email-nsekhar@ti.com>
	<1289990661-30126-46-git-send-email-nsekhar@ti.com>
	<1289990661-30126-47-git-send-email-nsekhar@ti.com>
	<1289990661-30126-48-git-send-email-nsekhar@ti.com>
	<1289990661-30126-49-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-49-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add manufacturer name to the Kconfig prompt string and move
the controller name to the begining of the prompt.

This helps locate the driver easily among the list of existing
drivers.

While at it, also add information about being able to build
the driver as module.

Tested-By: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/Kconfig |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 78f9fd0..a32796e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -111,11 +111,14 @@ config SPI_COLDFIRE_QSPI
 	  will be called coldfire_qspi.
 
 config SPI_DAVINCI
-	tristate "SPI controller driver for DaVinci/DA8xx SoC's"
+	tristate "Texas Instruments DaVinci/DA8x/OMAP-L/AM1x SoC SPI controller"
 	depends on SPI_MASTER && ARCH_DAVINCI
 	select SPI_BITBANG
 	help
-	  SPI master controller for DaVinci and DA8xx SPI modules.
+	  SPI master controller for DaVinci/DA8x/OMAP-L/AM1x SPI modules.
+
+	  This driver can also be built as a module. The module will be called
+	  davinci_spi.
 
 config SPI_EP93XX
 	tristate "Cirrus Logic EP93xx SPI controller"
-- 
1.7.3.2
