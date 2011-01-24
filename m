From: Alexis RODET <alexis.rodet-zROAmvwsW6hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/1] Renaming 'struct flash_platform_data' into 'struct
	spi_flash_platform_data' in include/linux/spi/flash.h
Date: Mon, 24 Jan 2011 16:16:47 +0100
Message-ID: <1295882207-17963-1-git-send-email-alexis.rodet__4442.02440926364$1295883530$gmane$org@bvs-tech.com>
References: <4D3D6472.8030505@bvs-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Alexis RODET <alexis.rodet-zROAmvwsW6hWk0Htik3J/w@public.gmane.org>,
	David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: 
In-Reply-To: <4D3D6472.8030505-zROAmvwsW6hWk0Htik3J/w@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Here is the command line used for doing this:
find . \( -name .git -prune -false -o -path ./include/linux/spi/flash.h -o \( -name \*.c -execdir grep -q '#include <linux/spi/flash.h>' \{\} \; \) \) -execdir sed -i -e 's/struct flash_platform_data/struct spi_flash_platform_data/' \{\} \+ -execdir git add \{\} \+ -print
I didn't test all compilation as I don't have blackfin compiler installed and I'm quite lasy and also busy.
I compiled for my x86 with allyesconfig and for Freescale mx27 with allyesconfig minus a number of buggy drivers.

Signed-off-by: Alexis RODET <alexis.rodet-zROAmvwsW6hWk0Htik3J/w@public.gmane.org>
---
 arch/arm/mach-at91/board-cam60.c               |    2 +-
 arch/arm/mach-at91/board-ecbat91.c             |    2 +-
 arch/arm/mach-dove/cm-a510.c                   |    2 +-
 arch/arm/mach-dove/dove-db-setup.c             |    2 +-
 arch/arm/mach-kirkwood/lacie_v2-common.c       |    2 +-
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c |    2 +-
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c   |    2 +-
 arch/arm/mach-kirkwood/t5325-setup.c           |    2 +-
 arch/arm/mach-kirkwood/tsx1x-common.c          |    2 +-
 arch/arm/mach-mx5/board-mx51_efikamx.c         |    2 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c   |    2 +-
 arch/arm/mach-w90x900/dev.c                    |    2 +-
 arch/blackfin/mach-bf518/boards/ezbrd.c        |    2 +-
 arch/blackfin/mach-bf518/boards/tcm-bf518.c    |    2 +-
 arch/blackfin/mach-bf527/boards/ad7160eval.c   |    2 +-
 arch/blackfin/mach-bf527/boards/cm_bf527.c     |    2 +-
 arch/blackfin/mach-bf527/boards/ezbrd.c        |    2 +-
 arch/blackfin/mach-bf527/boards/ezkit.c        |    2 +-
 arch/blackfin/mach-bf527/boards/tll6527m.c     |    2 +-
 arch/blackfin/mach-bf533/boards/H8606.c        |    2 +-
 arch/blackfin/mach-bf533/boards/blackstamp.c   |    2 +-
 arch/blackfin/mach-bf533/boards/cm_bf533.c     |    2 +-
 arch/blackfin/mach-bf533/boards/ezkit.c        |    2 +-
 arch/blackfin/mach-bf533/boards/stamp.c        |    2 +-
 arch/blackfin/mach-bf537/boards/cm_bf537e.c    |    2 +-
 arch/blackfin/mach-bf537/boards/cm_bf537u.c    |    2 +-
 arch/blackfin/mach-bf537/boards/dnp5370.c      |    2 +-
 arch/blackfin/mach-bf537/boards/minotaur.c     |    2 +-
 arch/blackfin/mach-bf537/boards/pnav10.c       |    2 +-
 arch/blackfin/mach-bf537/boards/stamp.c        |    4 ++--
 arch/blackfin/mach-bf537/boards/tcm_bf537.c    |    2 +-
 arch/blackfin/mach-bf538/boards/ezkit.c        |    2 +-
 arch/blackfin/mach-bf548/boards/cm_bf548.c     |    2 +-
 arch/blackfin/mach-bf548/boards/ezkit.c        |    2 +-
 arch/blackfin/mach-bf561/boards/acvilon.c      |    2 +-
 arch/blackfin/mach-bf561/boards/cm_bf561.c     |    2 +-
 arch/mips/alchemy/devboards/db1200/platform.c  |    2 +-
 drivers/mtd/devices/m25p80.c                   |    2 +-
 drivers/mtd/devices/mtd_dataflash.c            |    2 +-
 drivers/mtd/devices/sst25l.c                   |    2 +-
 drivers/spi/spi_butterfly.c                    |    2 +-
 include/linux/spi/flash.h                      |    4 ++--
 42 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index b54e3e6..50780b2 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -98,7 +98,7 @@ static struct mtd_partition cam60_spi_partitions[] = {
 	},
 };
 
-static struct flash_platform_data cam60_spi_flash_platform_data = {
+static struct spi_flash_platform_data cam60_spi_flash_platform_data = {
 	.name		= "spi_flash",
 	.parts		= cam60_spi_partitions,
 	.nr_parts	= ARRAY_SIZE(cam60_spi_partitions)
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index de2fd04..077c095 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -110,7 +110,7 @@ static struct mtd_partition __initdata my_flash0_partitions[] =
 	}
 };
 
-static struct flash_platform_data __initdata my_flash0_platform = {
+static struct spi_flash_platform_data __initdata my_flash0_platform = {
 	.name		= "Removable flash card",
 	.parts		= my_flash0_partitions,
 	.nr_parts	= ARRAY_SIZE(my_flash0_partitions)
diff --git a/arch/arm/mach-dove/cm-a510.c b/arch/arm/mach-dove/cm-a510.c
index 96e0e94..28d21cf 100644
--- a/arch/arm/mach-dove/cm-a510.c
+++ b/arch/arm/mach-dove/cm-a510.c
@@ -38,7 +38,7 @@ static struct mv_sata_platform_data cm_a510_sata_data = {
  * SPI Devices:
  * SPI0: 1M Flash Winbond w25q32bv
  */
-static const struct flash_platform_data cm_a510_spi_flash_data = {
+static const struct spi_flash_platform_data cm_a510_spi_flash_data = {
 	.type		= "w25q32bv",
 };
 
diff --git a/arch/arm/mach-dove/dove-db-setup.c b/arch/arm/mach-dove/dove-db-setup.c
index 95925aa..90f8f95 100644
--- a/arch/arm/mach-dove/dove-db-setup.c
+++ b/arch/arm/mach-dove/dove-db-setup.c
@@ -40,7 +40,7 @@ static struct mv_sata_platform_data dove_db_sata_data = {
  * SPI Devices:
  * 	SPI0: 4M Flash ST-M25P32-VMF6P
  ****************************************************************************/
-static const struct flash_platform_data dove_db_spi_flash_data = {
+static const struct spi_flash_platform_data dove_db_spi_flash_data = {
 	.type		= "m25p64",
 };
 
diff --git a/arch/arm/mach-kirkwood/lacie_v2-common.c b/arch/arm/mach-kirkwood/lacie_v2-common.c
index 285edab..b60003f 100644
--- a/arch/arm/mach-kirkwood/lacie_v2-common.c
+++ b/arch/arm/mach-kirkwood/lacie_v2-common.c
@@ -33,7 +33,7 @@ static struct mtd_partition lacie_v2_flash_parts[] = {
 	},
 };
 
-static const struct flash_platform_data lacie_v2_flash = {
+static const struct spi_flash_platform_data lacie_v2_flash = {
 	.type		= "mx25l4005a",
 	.name		= "spi_flash",
 	.parts		= lacie_v2_flash_parts,
diff --git a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
index 1e5266f..16356c8 100644
--- a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
+++ b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
@@ -52,7 +52,7 @@ static struct dsa_platform_data mv88f6281gtw_ge_switch_plat_data = {
 	.chip		= &mv88f6281gtw_ge_switch_chip_data,
 };
 
-static const struct flash_platform_data mv88f6281gtw_ge_spi_slave_data = {
+static const struct spi_flash_platform_data mv88f6281gtw_ge_spi_slave_data = {
 	.type		= "mx25l12805d",
 };
 
diff --git a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
index 0049614..d3b706f 100644
--- a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
@@ -32,7 +32,7 @@ static struct mv_sata_platform_data rd88f6192_sata_data = {
 	.n_ports	= 2,
 };
 
-static const struct flash_platform_data rd88F6192_spi_slave_data = {
+static const struct spi_flash_platform_data rd88F6192_spi_slave_data = {
 	.type		= "m25p128",
 };
 
diff --git a/arch/arm/mach-kirkwood/t5325-setup.c b/arch/arm/mach-kirkwood/t5325-setup.c
index ce50e61..d086983 100644
--- a/arch/arm/mach-kirkwood/t5325-setup.c
+++ b/arch/arm/mach-kirkwood/t5325-setup.c
@@ -59,7 +59,7 @@ struct mtd_partition hp_t5325_partitions[] = {
 	},
 };
 
-const struct flash_platform_data hp_t5325_flash = {
+const struct spi_flash_platform_data hp_t5325_flash = {
 	.type		= "mx25l8005",
 	.name		= "spi_flash",
 	.parts		= hp_t5325_partitions,
diff --git a/arch/arm/mach-kirkwood/tsx1x-common.c b/arch/arm/mach-kirkwood/tsx1x-common.c
index f781164..14c7825 100644
--- a/arch/arm/mach-kirkwood/tsx1x-common.c
+++ b/arch/arm/mach-kirkwood/tsx1x-common.c
@@ -59,7 +59,7 @@ struct mtd_partition qnap_tsx1x_partitions[] = {
 	},
 };
 
-const struct flash_platform_data qnap_tsx1x_flash = {
+const struct spi_flash_platform_data qnap_tsx1x_flash = {
 	.type		= "m25p128",
 	.name		= "spi_flash",
 	.parts		= qnap_tsx1x_partitions,
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index b7946f8..312816c 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -278,7 +278,7 @@ static struct mtd_partition mx51_efikamx_spi_nor_partitions[] = {
 	},
 };
 
-static struct flash_platform_data mx51_efikamx_spi_flash_data = {
+static struct spi_flash_platform_data mx51_efikamx_spi_flash_data = {
 	.name		= "spi_flash",
 	.parts		= mx51_efikamx_spi_nor_partitions,
 	.nr_parts	= ARRAY_SIZE(mx51_efikamx_spi_nor_partitions),
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index 02ff45f..b18bb24 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -65,7 +65,7 @@ static struct mtd_partition rd88f6183ap_ge_partitions[] = {
 	},
 };
 
-static struct flash_platform_data rd88f6183ap_ge_spi_slave_data = {
+static struct spi_flash_platform_data rd88f6183ap_ge_spi_slave_data = {
 	.type		= "m25p64",
 	.nr_parts	= ARRAY_SIZE(rd88f6183ap_ge_partitions),
 	.parts		= rd88f6183ap_ge_partitions,
diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index 7a1fa6a..12d7f7c 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -246,7 +246,7 @@ static struct mtd_partition nuc900_spi_flash_partitions[] = {
 	},
 };
 
-static struct flash_platform_data nuc900_spi_flash_data = {
+static struct spi_flash_platform_data nuc900_spi_flash_data = {
 	.name = "m25p80",
 	.parts =  nuc900_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(nuc900_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf518/boards/ezbrd.c b/arch/blackfin/mach-bf518/boards/ezbrd.c
index c0ccadc..0e994ad 100644
--- a/arch/blackfin/mach-bf518/boards/ezbrd.c
+++ b/arch/blackfin/mach-bf518/boards/ezbrd.c
@@ -177,7 +177,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf518/boards/tcm-bf518.c b/arch/blackfin/mach-bf518/boards/tcm-bf518.c
index 50fc5c8..11a1032 100644
--- a/arch/blackfin/mach-bf518/boards/tcm-bf518.c
+++ b/arch/blackfin/mach-bf518/boards/tcm-bf518.c
@@ -128,7 +128,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf527/boards/ad7160eval.c b/arch/blackfin/mach-bf527/boards/ad7160eval.c
index ccab4c6..bb410f9 100644
--- a/arch/blackfin/mach-bf527/boards/ad7160eval.c
+++ b/arch/blackfin/mach-bf527/boards/ad7160eval.c
@@ -255,7 +255,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf527/boards/cm_bf527.c b/arch/blackfin/mach-bf527/boards/cm_bf527.c
index c9d6dc8..845501f 100644
--- a/arch/blackfin/mach-bf527/boards/cm_bf527.c
+++ b/arch/blackfin/mach-bf527/boards/cm_bf527.c
@@ -344,7 +344,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf527/boards/ezbrd.c b/arch/blackfin/mach-bf527/boards/ezbrd.c
index b7101aa..31c9f87 100644
--- a/arch/blackfin/mach-bf527/boards/ezbrd.c
+++ b/arch/blackfin/mach-bf527/boards/ezbrd.c
@@ -243,7 +243,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
index 2cd2ff6..58cdd25 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -437,7 +437,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf527/boards/tll6527m.c b/arch/blackfin/mach-bf527/boards/tll6527m.c
index 18d303d..7a4312e 100644
--- a/arch/blackfin/mach-bf527/boards/tll6527m.c
+++ b/arch/blackfin/mach-bf527/boards/tll6527m.c
@@ -304,7 +304,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf533/boards/H8606.c b/arch/blackfin/mach-bf533/boards/H8606.c
index d4bfcea..e4ea336 100644
--- a/arch/blackfin/mach-bf533/boards/H8606.c
+++ b/arch/blackfin/mach-bf533/boards/H8606.c
@@ -149,7 +149,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf533/boards/blackstamp.c b/arch/blackfin/mach-bf533/boards/blackstamp.c
index 87b5af3..db7442e 100644
--- a/arch/blackfin/mach-bf533/boards/blackstamp.c
+++ b/arch/blackfin/mach-bf533/boards/blackstamp.c
@@ -92,7 +92,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf533/boards/cm_bf533.c b/arch/blackfin/mach-bf533/boards/cm_bf533.c
index 4d5604e..f1641bc 100644
--- a/arch/blackfin/mach-bf533/boards/cm_bf533.c
+++ b/arch/blackfin/mach-bf533/boards/cm_bf533.c
@@ -49,7 +49,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf533/boards/ezkit.c b/arch/blackfin/mach-bf533/boards/ezkit.c
index b67b91d..5ee8905 100644
--- a/arch/blackfin/mach-bf533/boards/ezkit.c
+++ b/arch/blackfin/mach-bf533/boards/ezkit.c
@@ -200,7 +200,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf533/boards/stamp.c b/arch/blackfin/mach-bf533/boards/stamp.c
index 43224ef..0b1e7c3 100644
--- a/arch/blackfin/mach-bf533/boards/stamp.c
+++ b/arch/blackfin/mach-bf533/boards/stamp.c
@@ -162,7 +162,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf537/boards/cm_bf537e.c b/arch/blackfin/mach-bf537/boards/cm_bf537e.c
index 2c776e1..bfe12ed 100644
--- a/arch/blackfin/mach-bf537/boards/cm_bf537e.c
+++ b/arch/blackfin/mach-bf537/boards/cm_bf537e.c
@@ -51,7 +51,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf537/boards/cm_bf537u.c b/arch/blackfin/mach-bf537/boards/cm_bf537u.c
index 0856611..4895f10 100644
--- a/arch/blackfin/mach-bf537/boards/cm_bf537u.c
+++ b/arch/blackfin/mach-bf537/boards/cm_bf537u.c
@@ -52,7 +52,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf537/boards/dnp5370.c b/arch/blackfin/mach-bf537/boards/dnp5370.c
index e1e9ea0..34b0137 100644
--- a/arch/blackfin/mach-bf537/boards/dnp5370.c
+++ b/arch/blackfin/mach-bf537/boards/dnp5370.c
@@ -171,7 +171,7 @@ static struct mtd_partition bfin_spi_dataflash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_dataflash_data = {
+static struct spi_flash_platform_data bfin_spi_dataflash_data = {
 	.name     = "mtd_dataflash",
 	.parts    = bfin_spi_dataflash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_dataflash_partitions),
diff --git a/arch/blackfin/mach-bf537/boards/minotaur.c b/arch/blackfin/mach-bf537/boards/minotaur.c
index bfb3671..46a6120 100644
--- a/arch/blackfin/mach-bf537/boards/minotaur.c
+++ b/arch/blackfin/mach-bf537/boards/minotaur.c
@@ -149,7 +149,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf537/boards/pnav10.c b/arch/blackfin/mach-bf537/boards/pnav10.c
index 9389f03..88f88e2 100644
--- a/arch/blackfin/mach-bf537/boards/pnav10.c
+++ b/arch/blackfin/mach-bf537/boards/pnav10.c
@@ -174,7 +174,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index 2c69785..a486292 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -526,7 +526,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
@@ -1003,7 +1003,7 @@ static struct mtd_partition bfin_spi_dataflash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_dataflash_data = {
+static struct spi_flash_platform_data bfin_spi_dataflash_data = {
 	.name = "SPI Dataflash",
 	.parts = bfin_spi_dataflash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_dataflash_partitions),
diff --git a/arch/blackfin/mach-bf537/boards/tcm_bf537.c b/arch/blackfin/mach-bf537/boards/tcm_bf537.c
index 0761b20..13ff1ac 100644
--- a/arch/blackfin/mach-bf537/boards/tcm_bf537.c
+++ b/arch/blackfin/mach-bf537/boards/tcm_bf537.c
@@ -52,7 +52,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf538/boards/ezkit.c b/arch/blackfin/mach-bf538/boards/ezkit.c
index e61424e..2d73490 100644
--- a/arch/blackfin/mach-bf538/boards/ezkit.c
+++ b/arch/blackfin/mach-bf538/boards/ezkit.c
@@ -493,7 +493,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf548/boards/cm_bf548.c b/arch/blackfin/mach-bf548/boards/cm_bf548.c
index d11502a..328503b 100644
--- a/arch/blackfin/mach-bf548/boards/cm_bf548.c
+++ b/arch/blackfin/mach-bf548/boards/cm_bf548.c
@@ -852,7 +852,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf548/boards/ezkit.c b/arch/blackfin/mach-bf548/boards/ezkit.c
index ce5a2bb..2a27868 100644
--- a/arch/blackfin/mach-bf548/boards/ezkit.c
+++ b/arch/blackfin/mach-bf548/boards/ezkit.c
@@ -960,7 +960,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/blackfin/mach-bf561/boards/acvilon.c b/arch/blackfin/mach-bf561/boards/acvilon.c
index 3926cd9..40d99f3 100644
--- a/arch/blackfin/mach-bf561/boards/acvilon.c
+++ b/arch/blackfin/mach-bf561/boards/acvilon.c
@@ -359,7 +359,7 @@ static struct mtd_partition bfin_spi_dataflash_partitions[] = {
 	 }
 };
 
-static struct flash_platform_data bfin_spi_dataflash_data = {
+static struct spi_flash_platform_data bfin_spi_dataflash_data = {
 	.name = "SPI Dataflash",
 	.parts = bfin_spi_dataflash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_dataflash_partitions),
diff --git a/arch/blackfin/mach-bf561/boards/cm_bf561.c b/arch/blackfin/mach-bf561/boards/cm_bf561.c
index 3b67929..aaae6ca 100644
--- a/arch/blackfin/mach-bf561/boards/cm_bf561.c
+++ b/arch/blackfin/mach-bf561/boards/cm_bf561.c
@@ -50,7 +50,7 @@ static struct mtd_partition bfin_spi_flash_partitions[] = {
 	}
 };
 
-static struct flash_platform_data bfin_spi_flash_data = {
+static struct spi_flash_platform_data bfin_spi_flash_data = {
 	.name = "m25p80",
 	.parts = bfin_spi_flash_partitions,
 	.nr_parts = ARRAY_SIZE(bfin_spi_flash_partitions),
diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
index fbb5593..ea9bf90 100644
--- a/arch/mips/alchemy/devboards/db1200/platform.c
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -50,7 +50,7 @@ static struct mtd_partition db1200_spiflash_parts[] = {
 	},
 };
 
-static struct flash_platform_data db1200_spiflash_data = {
+static struct spi_flash_platform_data db1200_spiflash_data = {
 	.name		= "s25fl001",
 	.parts		= db1200_spiflash_parts,
 	.nr_parts	= ARRAY_SIZE(db1200_spiflash_parts),
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index e4eba6c..ec836ab 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -797,7 +797,7 @@ static const struct spi_device_id *__devinit jedec_probe(struct spi_device *spi)
 static int __devinit m25p_probe(struct spi_device *spi)
 {
 	const struct spi_device_id	*id = spi_get_device_id(spi);
-	struct flash_platform_data	*data;
+	struct spi_flash_platform_data	*data;
 	struct m25p			*flash;
 	struct flash_info		*info;
 	unsigned			i;
diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index c5015cc..9cb2727 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -634,7 +634,7 @@ add_dataflash_otp(struct spi_device *spi, char *name,
 {
 	struct dataflash		*priv;
 	struct mtd_info			*device;
-	struct flash_platform_data	*pdata = spi->dev.platform_data;
+	struct spi_flash_platform_data	*pdata = spi->dev.platform_data;
 	char				*otp_tag = "";
 	int				err = 0;
 
diff --git a/drivers/mtd/devices/sst25l.c b/drivers/mtd/devices/sst25l.c
index c163e61..c902c4f 100644
--- a/drivers/mtd/devices/sst25l.c
+++ b/drivers/mtd/devices/sst25l.c
@@ -379,7 +379,7 @@ static int __devinit sst25l_probe(struct spi_device *spi)
 {
 	struct flash_info *flash_info;
 	struct sst25l_flash *flash;
-	struct flash_platform_data *data;
+	struct spi_flash_platform_data *data;
 	int ret, i;
 
 	flash_info = sst25l_match_device(spi);
diff --git a/drivers/spi/spi_butterfly.c b/drivers/spi/spi_butterfly.c
index 0d4ceba..a9ac6b2 100644
--- a/drivers/spi/spi_butterfly.c
+++ b/drivers/spi/spi_butterfly.c
@@ -183,7 +183,7 @@ static struct mtd_partition partitions[] = { {
 	.size		= MTDPART_SIZ_FULL,
 } };
 
-static struct flash_platform_data flash = {
+static struct spi_flash_platform_data flash = {
 	.name		= "butterflash",
 	.parts		= partitions,
 	.nr_parts	= ARRAY_SIZE(partitions),
diff --git a/include/linux/spi/flash.h b/include/linux/spi/flash.h
index 3f22932..946145e 100644
--- a/include/linux/spi/flash.h
+++ b/include/linux/spi/flash.h
@@ -4,7 +4,7 @@
 struct mtd_partition;
 
 /**
- * struct flash_platform_data: board-specific flash data
+ * struct spi_flash_platform_data: board-specific flash data
  * @name: optional flash device name (eg, as used with mtdparts=)
  * @parts: optional array of mtd_partitions for static partitioning
  * @nr_parts: number of mtd_partitions for static partitoning
@@ -18,7 +18,7 @@ struct mtd_partition;
  * Note that for DataFlash, sizes for pages, blocks, and sectors are
  * rarely powers of two; and partitions should be sector-aligned.
  */
-struct flash_platform_data {
+struct spi_flash_platform_data {
 	char		*name;
 	struct mtd_partition *parts;
 	unsigned int	nr_parts;
-- 
1.7.1


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
