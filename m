Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68329C48BCF
	for <linux-spi@archiver.kernel.org>; Mon,  7 Jun 2021 10:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528196124C
	for <linux-spi@archiver.kernel.org>; Mon,  7 Jun 2021 10:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFGLAT (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:00:19 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:57238 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhFGLAR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 07:00:17 -0400
Received: from localhost (unknown [192.168.167.105])
        by lucky1.263xmail.com (Postfix) with ESMTP id 89166CD684;
        Mon,  7 Jun 2021 18:58:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26721T140687081854720S1623063484717111_;
        Mon, 07 Jun 2021 18:58:09 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8358e8e0d781dbfc305596f17130c079>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 9
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     jon.lin@rock-chips.com, heiko@sntech.de, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 2/6] spi: rockchip: add compatible string for rv1126 and rk3568
Date:   Mon,  7 Jun 2021 18:57:58 +0800
Message-Id: <20210607105802.23796-3-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607105802.23796-1-jon.lin@rock-chips.com>
References: <20210607105802.23796-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add compatible string for rv1126 and rk3568 for potential applications.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None

 drivers/spi/spi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 52d6259d96ed..bbeed3ae4ee1 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -922,6 +922,7 @@ static const struct of_device_id rockchip_spi_dt_match[] = {
 	{ .compatible = "rockchip,rk3368-spi", },
 	{ .compatible = "rockchip,rk3399-spi", },
 	{ .compatible = "rockchip,rv1108-spi", },
+	{ .compatible = "rockchip,rv1126-spi", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);
-- 
2.17.1



