From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH 1/2] trivial: fix double "of of" in comment in spidev code
Date: Thu, 22 Oct 2009 17:34:29 -0200
Message-ID: <1256240069-25223-1-git-send-email-cascardo@holoscopio.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: trivial@kernel.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756808AbZJVTfE@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
---
 drivers/spi/spidev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 5d23983..d9b4100 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -42,7 +42,7 @@
  * This supports acccess to SPI devices using normal userspace I/O calls.
  * Note that while traditional UNIX/POSIX I/O semantics are half duplex,
  * and often mask message boundaries, full SPI support requires full duplex
- * transfers.  There are several kinds of of internal message boundaries to
+ * transfers.  There are several kinds of internal message boundaries to
  * handle chipselect management and other protocol options.
  *
  * SPI has a character major number assigned.  We allocate minor numbers
-- 
1.6.3.3
