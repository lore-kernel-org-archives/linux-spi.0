Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE8CC49360
	for <linux-spi@archiver.kernel.org>; Mon,  7 Jun 2021 06:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B84611C0
	for <linux-spi@archiver.kernel.org>; Mon,  7 Jun 2021 06:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFGGhl (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 7 Jun 2021 02:37:41 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:44054 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhFGGhl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 02:37:41 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id AD7EDC8291;
        Mon,  7 Jun 2021 14:35:20 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31748T140095280056064S1623047691557189_;
        Mon, 07 Jun 2021 14:35:16 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <620ae70600b98c3cfd257eeb31250fc9>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 7
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     Jon Lin <jon.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/6] spi: rockchip: add compatible string for rv1126 and rk3568
Date:   Mon,  7 Jun 2021 14:34:44 +0800
Message-Id: <20210607063448.29589-3-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607063448.29589-1-jon.lin@rock-chips.com>
References: <20210607063448.29589-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add compatible string for rv1126 and rk3568 for potential applications.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v4: None
Changes in v3: None

 drivers/spi/spi-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 52d6259d96ed..99d66dff8c89 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -921,7 +921,9 @@ static const struct of_device_id rockchip_spi_dt_match[] = {
 	{ .compatible = "rockchip,rk3328-spi", },
 	{ .compatible = "rockchip,rk3368-spi", },
 	{ .compatible = "rockchip,rk3399-spi", },
+	{ .compatible = "rockchip,rk3568-spi", },
 	{ .compatible = "rockchip,rv1108-spi", },
+	{ .compatible = "rockchip,rv1126-spi", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);
-- 
2.17.1



