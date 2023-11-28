Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41547DE
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:22 -0800 (PST)
Received: from dggpemm100018.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SfcWd4yS4zvRHB;
	Tue, 28 Nov 2023 17:25:49 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100018.china.huawei.com (7.185.36.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:20 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:19 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 02/26] spi: sprd: switch to use modern name
Date: Tue, 28 Nov 2023 17:30:07 +0800
Message-ID: <20231128093031.3707034-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128093031.3707034-1-yangyingliang@huawei.com>
References: <20231128093031.3707034-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-sprd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 95377cf748c0..831ebae10fe0 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -578,7 +578,7 @@ static void sprd_spi_dma_release(struct sprd_spi *ss)
 static int sprd_spi_dma_txrx_bufs(struct spi_device *sdev,
 				  struct spi_transfer *t)
 {
-	struct sprd_spi *ss = spi_master_get_devdata(sdev->master);
+	struct sprd_spi *ss = spi_controller_get_devdata(sdev->controller);
 	u32 trans_len = ss->trans_len;
 	int ret, write_size = 0;
 
@@ -923,7 +923,7 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	int ret;
 
 	pdev->id = of_alias_get_id(pdev->dev.of_node, "spi");
-	sctlr = spi_alloc_master(&pdev->dev, sizeof(*ss));
+	sctlr = spi_alloc_host(&pdev->dev, sizeof(*ss));
 	if (!sctlr)
 		return -ENOMEM;
 
-- 
2.25.1

