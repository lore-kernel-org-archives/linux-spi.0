From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 4/6] spi: octeon: Move include file from arch/mips to drivers/spi
Date: Sat, 23 Jul 2016 12:42:53 +0200
Message-ID: <b1c9628171224d3c28946f6d559376618cd3633d.1469174814.git.jglauber@cavium.com>
References: <cover.1469174814.git.jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	"Steven J. Hill" <steven.hill@cavium.com>,
	David Daney <david.daney@cavium.com>,
	Jan Glauber <jglauber@cavium.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1469174814.git.jglauber@cavium.com>
In-Reply-To: <cover.1469174814.git.jglauber@cavium.com>
References: <cover.1469174814.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Move the register definitions to the drivers directory because they
are only used there.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Tested-by: Steven J. Hill <steven.hill@cavium.com>
---
 .../cvmx-mpi-defs.h => drivers/spi/spi-cavium.h    | 32 +---------------------
 drivers/spi/spi-octeon.c                           |  3 +-
 2 files changed, 3 insertions(+), 32 deletions(-)
 rename arch/mips/include/asm/octeon/cvmx-mpi-defs.h => drivers/spi/spi-cavium.h (84%)

diff --git a/arch/mips/include/asm/octeon/cvmx-mpi-defs.h b/drivers/spi/spi-cavium.h
similarity index 84%
rename from arch/mips/include/asm/octeon/cvmx-mpi-defs.h
rename to drivers/spi/spi-cavium.h
index 4615b10..d41dba5 100644
--- a/arch/mips/include/asm/octeon/cvmx-mpi-defs.h
+++ b/drivers/spi/spi-cavium.h
@@ -1,32 +1,4 @@
-/***********************license start***************
- * Author: Cavium Networks
- *
- * Contact: support@caviumnetworks.com
- * This file is part of the OCTEON SDK
- *
- * Copyright (c) 2003-2012 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- *
- * This file is distributed in the hope that it will be useful, but
- * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
- * NONINFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this file; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
- * or visit http://www.gnu.org/licenses/.
- *
- * This file may also be available under a different license from Cavium.
- * Contact Cavium Networks for more information
- ***********************license end**************************************/
-
-#ifndef __CVMX_MPI_DEFS_H__
-#define __CVMX_MPI_DEFS_H__
+/* MPI register descriptions */
 
 #define CVMX_MPI_CFG (CVMX_ADD_IO_SEG(0x0001070000001000ull))
 #define CVMX_MPI_DATX(offset) (CVMX_ADD_IO_SEG(0x0001070000001080ull) + ((offset) & 15) * 8)
@@ -324,5 +296,3 @@ union cvmx_mpi_tx {
 	struct cvmx_mpi_tx_s cn66xx;
 	struct cvmx_mpi_tx_cn61xx cnf71xx;
 };
-
-#endif
diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
index 209eddc..2180176 100644
--- a/drivers/spi/spi-octeon.c
+++ b/drivers/spi/spi-octeon.c
@@ -15,7 +15,8 @@
 #include <linux/of.h>
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-mpi-defs.h>
+
+#include "spi-cavium.h"
 
 #define OCTEON_SPI_MAX_BYTES 9
 
-- 
2.9.0.rc0.21.g7777322
