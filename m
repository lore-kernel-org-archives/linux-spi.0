From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH 2/2] spidev: use DECLARE_BITMAP instead of declaring the array
Date: Thu, 22 Oct 2009 17:38:17 -0200
Message-ID: <1256240297-29419-1-git-send-email-cascardo@holoscopio.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Andrea Paterniani <a.paterniani@swapp-eng.it>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756835AbZJVTiY@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
---
 drivers/spi/spidev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index d9b4100..10fc42f 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -54,7 +54,7 @@
 #define SPIDEV_MAJOR			153	/* assigned */
 #define N_SPI_MINORS			32	/* ... up to 256 */
 
-static unsigned long	minors[N_SPI_MINORS / BITS_PER_LONG];
+static DECLARE_BITMAP(minors,N_SPI_MINORS);
 
 
 /* Bit masks for spi_device.mode management.  Note that incorrect
-- 
1.6.3.3
