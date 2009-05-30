From: Jiri Pirko <jpirko@redhat.com>
Subject: [PATCH] spi: fix spi_write_then_read() comment
Date: Sat, 30 May 2009 18:39:07 +0200
Message-ID: <20090530163906.GB3427@psychotron.englab.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: dbrownell@users.sourceforge.net
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932760AbZE3QjQ@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

[PATCH] spi: fix spi_write_then_read() comment

Spotted a tiny mislead. I guess buffer need not be dma-safe, not rx data length.

Signed-off-by: Jiri Pirko <jpirko@redhat.com>

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8eba98c..85a46c7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -636,8 +636,8 @@ static u8	*buf;
  * @spi: device with which data will be exchanged
  * @txbuf: data to be written (need not be dma-safe)
  * @n_tx: size of txbuf, in bytes
- * @rxbuf: buffer into which data will be read
- * @n_rx: size of rxbuf, in bytes (need not be dma-safe)
+ * @rxbuf: buffer into which data will be read (need not be dma-safe)
+ * @n_rx: size of rxbuf, in bytes
  * Context: can sleep
  *
  * This performs a half duplex MicroWire style transaction with the
