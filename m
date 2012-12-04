From: Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH 2/2] spi: sparc: Allow of_register_spi_devices for sparc
Date: Tue,  4 Dec 2012 15:09:38 +0100
Message-ID: <1354630178-25387-3-git-send-email-andreas@gaisler.com>
References: <1354630178-25387-1-git-send-email-andreas@gaisler.com>
Cc: grant.likely@secretlab.ca, w.sang@pengutronix.de, sam@ravnborg.org,
	sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	spi-devel-general@lists.sourceforge.net, linux-i2c@vger.kernel.org,
	software@gaisler.com
To: davem@davemloft.net
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <1354630178-25387-1-git-send-email-andreas@gaisler.com>
Sender: sparclinux-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/spi/spi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c4f7d71..d8339fe 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -812,7 +812,7 @@ err_init_queue:
 
 /*-------------------------------------------------------------------------*/
 
-#if defined(CONFIG_OF) && !defined(CONFIG_SPARC)
+#if defined(CONFIG_OF)
 /**
  * of_register_spi_devices() - Register child devices onto the SPI bus
  * @master:	Pointer to spi_master device
-- 
1.7.0.4

