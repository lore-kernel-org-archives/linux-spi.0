Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F729C433E0
	for <linux-spi@archiver.kernel.org>; Wed, 17 Mar 2021 09:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC9164F6E
	for <linux-spi@archiver.kernel.org>; Wed, 17 Mar 2021 09:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCQJjp (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 17 Mar 2021 05:39:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49034 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhCQJji (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Mar 2021 05:39:38 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lMSeP-0005aZ-3i; Wed, 17 Mar 2021 09:39:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: Fix spelling mistake "softwade" -> "software"
Date:   Wed, 17 Mar 2021 09:39:36 +0000
Message-Id: <20210317093936.5572-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0706832bffda..2fe3c3a50866 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -679,7 +679,7 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 	if (chip->swnode) {
 		status = device_add_software_node(&proxy->dev, chip->swnode);
 		if (status) {
-			dev_err(&ctlr->dev, "failed to add softwade node to '%s': %d\n",
+			dev_err(&ctlr->dev, "failed to add software node to '%s': %d\n",
 				chip->modalias, status);
 			goto err_dev_put;
 		}
-- 
2.30.2

