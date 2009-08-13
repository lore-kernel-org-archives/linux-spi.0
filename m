From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 1/7] spi: fix spelling of automatically in documentation
Date: Thu, 13 Aug 2009 11:06:03 +0100
Message-ID: <20090813100638.279654771@fluff.org>
References: <20090813100602.545180197@fluff.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.ne
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754132AbZHMKBw@vger.kernel.org>
Content-Disposition: inline; filename=spi-fix-spello1.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Fix spelling of automatically in Documentation/spi/spi-summary.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---
 Documentation/spi/spi-summary |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/Documentation/spi/spi-summary
===================================================================
--- a/Documentation/spi/spi-summary	2009-07-09 15:07:37.000000000 +0100
+++ b/Documentation/spi/spi-summary	2009-07-09 15:09:41.000000000 +0100
@@ -350,7 +350,7 @@ SPI protocol drivers somewhat resemble p
 		.resume		= CHIP_resume,
 	};
 
-The driver core will autmatically attempt to bind this driver to any SPI
+The driver core will automatically attempt to bind this driver to any SPI
 device whose board_info gave a modalias of "CHIP".  Your probe() code
 might look like this unless you're creating a device which is managing
 a bus (appearing under /sys/class/spi_master).

-- 
