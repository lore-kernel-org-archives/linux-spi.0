From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH -next] spi: tegra: slink: make symbol static
Date: Fri, 5 Apr 2013 15:45:12 +0800
Message-ID: <CAPgLHd_oC4z6YbswNOo-bpObgH7v420DupSgx_pmmB6B29HjEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

symbol '' was not declared. It should be static.

Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/spi/spi-tegra20-slink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 4e58b53..b224a82 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1087,11 +1087,11 @@ static struct tegra_spi_platform_data *tegra_slink_parse_dt(
 	return pdata;
 }
 
-const struct tegra_slink_chip_data tegra30_spi_cdata = {
+static const struct tegra_slink_chip_data tegra30_spi_cdata = {
 	.cs_hold_time = true,
 };
 
-const struct tegra_slink_chip_data tegra20_spi_cdata = {
+static const struct tegra_slink_chip_data tegra20_spi_cdata = {
 	.cs_hold_time = false,
 };
 
