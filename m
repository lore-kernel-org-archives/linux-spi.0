Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7B7EB64DA
	for <linux-spi@archiver.kernel.org>; Thu, 20 Jul 2023 14:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjGTOJr (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 20 Jul 2023 10:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjGTOJr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jul 2023 10:09:47 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B97CF211D
        for <linux-spi@vger.kernel.org>; Thu, 20 Jul 2023 07:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=wlX+/bG9wtQy7OljwS
        zIlNKS+RtdC0pslb7nMrGc1Fc=; b=QSbFuQxXVKwGw6GoepQG9woER6W4pcxwgi
        98htsFce59H7srf/H1rYUfzvp0l4DaRDBz+MiZ1jD8/BNrxByS/Ng3r3SVp9NT1J
        RuVWRtQkPa4ywWFPniT/jPqPOHnhFKxfrmWUHK9zJpyUg6qNa2ouHtU+xmutJDMD
        KzqTg74Dg=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wC35ir9P7lkhylJAw--.62162S4;
        Thu, 20 Jul 2023 22:09:05 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-spi@vger.kernel.org
Cc:     Yuanjun Gong <ruc_gongyuanjun@163.com>
Subject: [PATCH 1/1] spi: fix return value check in bcm2835_spi_probe()
Date:   Thu, 20 Jul 2023 22:08:59 +0800
Message-Id: <20230720140859.33883-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wC35ir9P7lkhylJAw--.62162S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4rZFy7Ar1UAr1DCryfWFg_yoWfWFbE9a
        9rWrW3Gr4Ig39Fy3W5K3yrZrZ2gF4kCa10gF1ktayYqrZrGw13WayDXanxG3yDZw40yrWq
        kF13AwsxAr13GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNGYLPUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiUQKy5WDESWmp9QAAsc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

in bcm2835_spi_probe(), clk_prepare_enable() may fail, therefore,
the return value of clk_prepare_enable() should be checked, and
the function should return error if clk_prepare_enable() fails.

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/spi/spi-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 3b253da98c05..7dfa1b3bd069 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1363,7 +1363,9 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	if (bs->irq <= 0)
 		return bs->irq ? bs->irq : -ENODEV;
 
-	clk_prepare_enable(bs->clk);
+	err = clk_prepare_enable(bs->clk);
+	if (err)
+		return err;
 	bs->clk_hz = clk_get_rate(bs->clk);
 
 	err = bcm2835_dma_init(ctlr, &pdev->dev, bs);
-- 
2.17.1

