From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: [PATCH 29/44] includecheck fix: drivers/spi, amba-pl022.c
Date: Wed, 08 Jul 2009 21:02:27 +0530
Message-ID: <1247067147.4382.80.camel@ht.satnam>
References: <1247063308.4382.12.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759585AbZGHQGs@vger.kernel.org>
In-Reply-To: <1247063308.4382.12.camel@ht.satnam>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


fix the following 'make includecheck' warnings:

  drivers/spi/amba-pl022.c: linux/delay.h is included more than once.
  drivers/spi/amba-pl022.c: linux/errno.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 drivers/spi/amba-pl022.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index da76797..c0f950a 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -38,14 +38,12 @@
 #include <linux/interrupt.h>
 #include <linux/spi/spi.h>
 #include <linux/workqueue.h>
-#include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl022.h>
 #include <linux/io.h>
-#include <linux/delay.h>
 
 /*
  * This macro is used to define some register default values.
-- 
1.6.0.6
