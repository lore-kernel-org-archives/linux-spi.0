From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.24 6/6] spi_bfin: headers are not
	for changelogs
Date: Thu, 31 Jan 2008 12:22:28 -0800
Message-ID: <200801311222.28308.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

From: Mike Frysinger <michael.frysinger-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Use simpler comment headers, and strip out information that
is maintained in GIT history

Signed-off-by: Mike Frysinger <michael.frysinger-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

--- g26.orig/drivers/spi/spi_bfin5xx.c	2008-01-31 11:52:02.000000000 -0800
+++ g26/drivers/spi/spi_bfin5xx.c	2008-01-31 11:52:03.000000000 -0800
@@ -1,37 +1,11 @@
 /*
- * File:	drivers/spi/bfin5xx_spi.c
- * Maintainer:
- *		Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
- * Original Author:
- *		Luke Yang (Analog Devices Inc.)
- *
- * Created:	March. 10th 2006
- * Description:	SPI controller driver for Blackfin BF5xx
- * Bugs:	Enter bugs at http://blackfin.uclinux.org/
- *
- * Modified:
- *	March 10, 2006  bfin5xx_spi.c Created. (Luke Yang)
- *      August 7, 2006  added full duplex mode (Axel Weiss & Luke Yang)
- *      July  17, 2007  add support for BF54x SPI0 controller (Bryan Wu)
- *      July  30, 2007  add platfrom_resource interface to support multi-port
- *                      SPI controller (Bryan Wu)
+ * Blackfin On-Chip SPI Driver
  *
  * Copyright 2004-2007 Analog Devices Inc.
  *
- * This program is free software ;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation ;  either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY ;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * Enter bugs at http://blackfin.uclinux.org/
  *
- * You should have received a copy of the GNU General Public License
- * along with this program ;  see the file COPYING.
- * If not, write to the Free Software Foundation,
- * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * Licensed under the GPL-2 or later.
  */
 
 #include <linux/init.h>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
