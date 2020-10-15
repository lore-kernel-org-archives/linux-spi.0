Return-Path: <SRS0=2ph6=DW=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B107C43457
	for <linux-spi@archiver.kernel.org>; Thu, 15 Oct 2020 14:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E4EC22267
	for <linux-spi@archiver.kernel.org>; Thu, 15 Oct 2020 14:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbgJOOZr (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 15 Oct 2020 10:25:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388099AbgJOOZr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Oct 2020 10:25:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 25B96C6838B07580676D;
        Thu, 15 Oct 2020 22:25:44 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 15 Oct 2020 22:25:33 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <sashal@kernel.org>, <gregkh@linuxfoundation.org>,
        <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <stable@vger.kernel.org>,
        <yangerkun@huawei.com>, <yi.zhang@huawei.com>,
        <chenwenyong2@huawei.com>
Subject: [PATCH] spi: unbinding slave before calling spi_destroy_queue
Date:   Thu, 15 Oct 2020 22:29:51 +0800
Message-ID: <20201015142951.1133415-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We make a mistake while backport 'commit 84855678add8 ("spi: Fix
controller unregister order")'. What we should do is call __unreigster
for each device before spi_destroy_queue. This problem exist in
linux-4.4.y/linux-4.9.y.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fe03771da5124..18031b755c376 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1957,13 +1957,13 @@ static int __unregister(struct device *dev, void *null)
  */
 void spi_unregister_master(struct spi_master *master)
 {
+	device_for_each_child(&master->dev, NULL, __unregister);
+
 	if (master->queued) {
 		if (spi_destroy_queue(master))
 			dev_err(&master->dev, "queue remove failed\n");
 	}
 
-	device_for_each_child(&master->dev, NULL, __unregister);
-
 	mutex_lock(&board_lock);
 	list_del(&master->list);
 	mutex_unlock(&board_lock);
-- 
2.25.4

