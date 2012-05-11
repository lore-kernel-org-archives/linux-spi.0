From: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] MIPS: OCTEON: Add register definitions for SPI host
	hardware.
Date: Fri, 11 May 2012 14:34:45 -0700
Message-ID: <1336772086-17248-2-git-send-email-ddaney.cavm@gmail.com>
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1336772086-17248-1-git-send-email-ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

Needed by SPI driver.

Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---
 arch/mips/include/asm/octeon/cvmx-mpi-defs.h |  328 ++++++++++++++++++++++++++
 1 files changed, 328 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-mpi-defs.h

diff --git a/arch/mips/include/asm/octeon/cvmx-mpi-defs.h b/arch/mips/include/asm/octeon/cvmx-mpi-defs.h
new file mode 100644
index 0000000..4615b10
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-mpi-defs.h
@@ -0,0 +1,328 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2012 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_MPI_DEFS_H__
+#define __CVMX_MPI_DEFS_H__
+
+#define CVMX_MPI_CFG (CVMX_ADD_IO_SEG(0x0001070000001000ull))
+#define CVMX_MPI_DATX(offset) (CVMX_ADD_IO_SEG(0x0001070000001080ull) + ((offset) & 15) * 8)
+#define CVMX_MPI_STS (CVMX_ADD_IO_SEG(0x0001070000001008ull))
+#define CVMX_MPI_TX (CVMX_ADD_IO_SEG(0x0001070000001010ull))
+
+union cvmx_mpi_cfg {
+	uint64_t u64;
+	struct cvmx_mpi_cfg_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_29_63:35;
+		uint64_t clkdiv:13;
+		uint64_t csena3:1;
+		uint64_t csena2:1;
+		uint64_t csena1:1;
+		uint64_t csena0:1;
+		uint64_t cslate:1;
+		uint64_t tritx:1;
+		uint64_t idleclks:2;
+		uint64_t cshi:1;
+		uint64_t csena:1;
+		uint64_t int_ena:1;
+		uint64_t lsbfirst:1;
+		uint64_t wireor:1;
+		uint64_t clk_cont:1;
+		uint64_t idlelo:1;
+		uint64_t enable:1;
+#else
+		uint64_t enable:1;
+		uint64_t idlelo:1;
+		uint64_t clk_cont:1;
+		uint64_t wireor:1;
+		uint64_t lsbfirst:1;
+		uint64_t int_ena:1;
+		uint64_t csena:1;
+		uint64_t cshi:1;
+		uint64_t idleclks:2;
+		uint64_t tritx:1;
+		uint64_t cslate:1;
+		uint64_t csena0:1;
+		uint64_t csena1:1;
+		uint64_t csena2:1;
+		uint64_t csena3:1;
+		uint64_t clkdiv:13;
+		uint64_t reserved_29_63:35;
+#endif
+	} s;
+	struct cvmx_mpi_cfg_cn30xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_29_63:35;
+		uint64_t clkdiv:13;
+		uint64_t reserved_12_15:4;
+		uint64_t cslate:1;
+		uint64_t tritx:1;
+		uint64_t idleclks:2;
+		uint64_t cshi:1;
+		uint64_t csena:1;
+		uint64_t int_ena:1;
+		uint64_t lsbfirst:1;
+		uint64_t wireor:1;
+		uint64_t clk_cont:1;
+		uint64_t idlelo:1;
+		uint64_t enable:1;
+#else
+		uint64_t enable:1;
+		uint64_t idlelo:1;
+		uint64_t clk_cont:1;
+		uint64_t wireor:1;
+		uint64_t lsbfirst:1;
+		uint64_t int_ena:1;
+		uint64_t csena:1;
+		uint64_t cshi:1;
+		uint64_t idleclks:2;
+		uint64_t tritx:1;
+		uint64_t cslate:1;
+		uint64_t reserved_12_15:4;
+		uint64_t clkdiv:13;
+		uint64_t reserved_29_63:35;
+#endif
+	} cn30xx;
+	struct cvmx_mpi_cfg_cn31xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_29_63:35;
+		uint64_t clkdiv:13;
+		uint64_t reserved_11_15:5;
+		uint64_t tritx:1;
+		uint64_t idleclks:2;
+		uint64_t cshi:1;
+		uint64_t csena:1;
+		uint64_t int_ena:1;
+		uint64_t lsbfirst:1;
+		uint64_t wireor:1;
+		uint64_t clk_cont:1;
+		uint64_t idlelo:1;
+		uint64_t enable:1;
+#else
+		uint64_t enable:1;
+		uint64_t idlelo:1;
+		uint64_t clk_cont:1;
+		uint64_t wireor:1;
+		uint64_t lsbfirst:1;
+		uint64_t int_ena:1;
+		uint64_t csena:1;
+		uint64_t cshi:1;
+		uint64_t idleclks:2;
+		uint64_t tritx:1;
+		uint64_t reserved_11_15:5;
+		uint64_t clkdiv:13;
+		uint64_t reserved_29_63:35;
+#endif
+	} cn31xx;
+	struct cvmx_mpi_cfg_cn30xx cn50xx;
+	struct cvmx_mpi_cfg_cn61xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_29_63:35;
+		uint64_t clkdiv:13;
+		uint64_t reserved_14_15:2;
+		uint64_t csena1:1;
+		uint64_t csena0:1;
+		uint64_t cslate:1;
+		uint64_t tritx:1;
+		uint64_t idleclks:2;
+		uint64_t cshi:1;
+		uint64_t reserved_6_6:1;
+		uint64_t int_ena:1;
+		uint64_t lsbfirst:1;
+		uint64_t wireor:1;
+		uint64_t clk_cont:1;
+		uint64_t idlelo:1;
+		uint64_t enable:1;
+#else
+		uint64_t enable:1;
+		uint64_t idlelo:1;
+		uint64_t clk_cont:1;
+		uint64_t wireor:1;
+		uint64_t lsbfirst:1;
+		uint64_t int_ena:1;
+		uint64_t reserved_6_6:1;
+		uint64_t cshi:1;
+		uint64_t idleclks:2;
+		uint64_t tritx:1;
+		uint64_t cslate:1;
+		uint64_t csena0:1;
+		uint64_t csena1:1;
+		uint64_t reserved_14_15:2;
+		uint64_t clkdiv:13;
+		uint64_t reserved_29_63:35;
+#endif
+	} cn61xx;
+	struct cvmx_mpi_cfg_cn66xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_29_63:35;
+		uint64_t clkdiv:13;
+		uint64_t csena3:1;
+		uint64_t csena2:1;
+		uint64_t reserved_12_13:2;
+		uint64_t cslate:1;
+		uint64_t tritx:1;
+		uint64_t idleclks:2;
+		uint64_t cshi:1;
+		uint64_t reserved_6_6:1;
+		uint64_t int_ena:1;
+		uint64_t lsbfirst:1;
+		uint64_t wireor:1;
+		uint64_t clk_cont:1;
+		uint64_t idlelo:1;
+		uint64_t enable:1;
+#else
+		uint64_t enable:1;
+		uint64_t idlelo:1;
+		uint64_t clk_cont:1;
+		uint64_t wireor:1;
+		uint64_t lsbfirst:1;
+		uint64_t int_ena:1;
+		uint64_t reserved_6_6:1;
+		uint64_t cshi:1;
+		uint64_t idleclks:2;
+		uint64_t tritx:1;
+		uint64_t cslate:1;
+		uint64_t reserved_12_13:2;
+		uint64_t csena2:1;
+		uint64_t csena3:1;
+		uint64_t clkdiv:13;
+		uint64_t reserved_29_63:35;
+#endif
+	} cn66xx;
+	struct cvmx_mpi_cfg_cn61xx cnf71xx;
+};
+
+union cvmx_mpi_datx {
+	uint64_t u64;
+	struct cvmx_mpi_datx_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_8_63:56;
+		uint64_t data:8;
+#else
+		uint64_t data:8;
+		uint64_t reserved_8_63:56;
+#endif
+	} s;
+	struct cvmx_mpi_datx_s cn30xx;
+	struct cvmx_mpi_datx_s cn31xx;
+	struct cvmx_mpi_datx_s cn50xx;
+	struct cvmx_mpi_datx_s cn61xx;
+	struct cvmx_mpi_datx_s cn66xx;
+	struct cvmx_mpi_datx_s cnf71xx;
+};
+
+union cvmx_mpi_sts {
+	uint64_t u64;
+	struct cvmx_mpi_sts_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_13_63:51;
+		uint64_t rxnum:5;
+		uint64_t reserved_1_7:7;
+		uint64_t busy:1;
+#else
+		uint64_t busy:1;
+		uint64_t reserved_1_7:7;
+		uint64_t rxnum:5;
+		uint64_t reserved_13_63:51;
+#endif
+	} s;
+	struct cvmx_mpi_sts_s cn30xx;
+	struct cvmx_mpi_sts_s cn31xx;
+	struct cvmx_mpi_sts_s cn50xx;
+	struct cvmx_mpi_sts_s cn61xx;
+	struct cvmx_mpi_sts_s cn66xx;
+	struct cvmx_mpi_sts_s cnf71xx;
+};
+
+union cvmx_mpi_tx {
+	uint64_t u64;
+	struct cvmx_mpi_tx_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_22_63:42;
+		uint64_t csid:2;
+		uint64_t reserved_17_19:3;
+		uint64_t leavecs:1;
+		uint64_t reserved_13_15:3;
+		uint64_t txnum:5;
+		uint64_t reserved_5_7:3;
+		uint64_t totnum:5;
+#else
+		uint64_t totnum:5;
+		uint64_t reserved_5_7:3;
+		uint64_t txnum:5;
+		uint64_t reserved_13_15:3;
+		uint64_t leavecs:1;
+		uint64_t reserved_17_19:3;
+		uint64_t csid:2;
+		uint64_t reserved_22_63:42;
+#endif
+	} s;
+	struct cvmx_mpi_tx_cn30xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_17_63:47;
+		uint64_t leavecs:1;
+		uint64_t reserved_13_15:3;
+		uint64_t txnum:5;
+		uint64_t reserved_5_7:3;
+		uint64_t totnum:5;
+#else
+		uint64_t totnum:5;
+		uint64_t reserved_5_7:3;
+		uint64_t txnum:5;
+		uint64_t reserved_13_15:3;
+		uint64_t leavecs:1;
+		uint64_t reserved_17_63:47;
+#endif
+	} cn30xx;
+	struct cvmx_mpi_tx_cn30xx cn31xx;
+	struct cvmx_mpi_tx_cn30xx cn50xx;
+	struct cvmx_mpi_tx_cn61xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_21_63:43;
+		uint64_t csid:1;
+		uint64_t reserved_17_19:3;
+		uint64_t leavecs:1;
+		uint64_t reserved_13_15:3;
+		uint64_t txnum:5;
+		uint64_t reserved_5_7:3;
+		uint64_t totnum:5;
+#else
+		uint64_t totnum:5;
+		uint64_t reserved_5_7:3;
+		uint64_t txnum:5;
+		uint64_t reserved_13_15:3;
+		uint64_t leavecs:1;
+		uint64_t reserved_17_19:3;
+		uint64_t csid:1;
+		uint64_t reserved_21_63:43;
+#endif
+	} cn61xx;
+	struct cvmx_mpi_tx_s cn66xx;
+	struct cvmx_mpi_tx_cn61xx cnf71xx;
+};
+
+#endif
-- 
1.7.2.3


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
