From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] spi: fix spi.h kernel-doc warning
Date: Tue, 17 Apr 2012 17:03:50 -0700
Message-ID: <4F8E04E6.60005@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc warning in spi.h (copy/pasto):

Warning(include/linux/spi/spi.h:365): No description found for parameter 'unprepare_transfer_hardware'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/linux/spi/spi.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-34-rc3.orig/include/linux/spi/spi.h
+++ lnx-34-rc3/include/linux/spi/spi.h
@@ -254,7 +254,7 @@ static inline void spi_unregister_driver
  *	driver is finished with this message, it must call
  *	spi_finalize_current_message() so the subsystem can issue the next
  *	transfer
- * @prepare_transfer_hardware: there are currently no more messages on the
+ * @unprepare_transfer_hardware: there are currently no more messages on the
  *	queue so the subsystem notifies the driver that it may relax the
  *	hardware by issuing this call
  *
