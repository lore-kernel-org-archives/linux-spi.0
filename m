Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AD1C43461
	for <linux-spi@archiver.kernel.org>; Tue, 27 Apr 2021 07:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7227361042
	for <linux-spi@archiver.kernel.org>; Tue, 27 Apr 2021 07:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhD0Hkq (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 27 Apr 2021 03:40:46 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:34114 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbhD0HjJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Apr 2021 03:39:09 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 3BA1DC7F48;
        Tue, 27 Apr 2021 15:38:23 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26232T140422993086208S1619509101181570_;
        Tue, 27 Apr 2021 15:38:23 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <1879818975a4bae328804936da9a64ba>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 8
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@esmil.dk, Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v2 7/8] spi: rockchip: Add compatible string for rk3568
Date:   Tue, 27 Apr 2021 15:38:19 +0800
Message-Id: <20210427073820.31797-2-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427073820.31797-1-jon.lin@rock-chips.com>
References: <20210427073733.31419-1-jon.lin@rock-chips.com>
 <20210427073820.31797-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add compatible string for rv1126 to applications for potential
applications.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---
 drivers/spi/spi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 3b05c1ed6308..2b68691157d0 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -979,6 +979,7 @@ static const struct of_device_id rockchip_spi_dt_match[] = {
 	{ .compatible = "rockchip,rk3328-spi", },
 	{ .compatible = "rockchip,rk3368-spi", },
 	{ .compatible = "rockchip,rk3399-spi", },
+	{ .compatible = "rockchip,rk3568-spi", },
 	{ .compatible = "rockchip,rv1108-spi", },
 	{ .compatible = "rockchip,rv1126-spi", },
 	{ },
-- 
2.17.1



