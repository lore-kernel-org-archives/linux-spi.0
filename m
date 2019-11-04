From: John Garry <john.garry@huawei.com>
Subject: [PATCH 3/3] MAINTAINERS: Add a maintainer for the HiSilicon v3xx SFC driver
Date: Tue, 5 Nov 2019 00:51:37 +0800
Message-ID: <1572886297-45400-4-git-send-email-john.garry@huawei.com>
References: <1572886297-45400-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <xuejiancheng@hisilicon.com>, <fengsheng5@huawei.com>,
        John Garry <john.garry@huawei.com>
To: <broonie@kernel.org>, <marek.vasut@gmail.com>,
        <tudor.ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1572886297-45400-1-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Set John Garry @ Huawei as the maintainer.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e51a68bf8ca8..6c871152934e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7410,6 +7410,12 @@ S:	Supported
 F:	drivers/scsi/hisi_sas/
 F:	Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
 
+HISILICON v3xx SPI NOR FLASH Controller Driver
+M:	John Garry <john.garry@huawei.com>
+W:	http://www.hisilicon.com
+S:	Maintained
+F:	drivers/spi/spi-hisi-sfc-v3xx.c
+
 HISILICON QM AND ZIP Controller DRIVER
 M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.17.1
