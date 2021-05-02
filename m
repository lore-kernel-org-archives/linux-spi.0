Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714B9C43462
	for <linux-spi@archiver.kernel.org>; Sun,  2 May 2021 14:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5895C6120D
	for <linux-spi@archiver.kernel.org>; Sun,  2 May 2021 14:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhEBOIS (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 2 May 2021 10:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233299AbhEBOH2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 2 May 2021 10:07:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF55F6161E;
        Sun,  2 May 2021 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619964375;
        bh=OLJOTzW1FsSNMsOn5GPJtnZwbeOeAm854hzNbQlR3GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bisv1vAKkgSDF+soe7bE+t/qmC+V9VqHvN3KORclxyRCH9NClCGyxQj9rwLZqYnfS
         pFSfDZ9mxGfYH9ll8YG7lLT9KjcZ7C97Qz4ysUEvEliYcJIBR2URwjarZX4IV+0a2G
         KUMjUy0WYJfmX0cPy9jG8MkKCUy6QgZ1fHvFOslsA1GEAsVf4NHgJ5pigzl1xYDWUy
         DIKQ3sUfn+KvTAKQW/cjgAT9DvzhaR8k4R2jHvPKZYzRYI5TlwTRYwEb9infrUDKu2
         CJAmS6iNmBv0eq8pPxxwLSNJiv3x1r8ALuN4rFaRSl49YGBNlFjaAgPXyUBFl7uOZ4
         P55ymGejDmEDw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 07/12] spi: dln2: Fix reference leak to master
Date:   Sun,  2 May 2021 10:06:01 -0400
Message-Id: <20210502140606.2720323-7-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210502140606.2720323-1-sashal@kernel.org>
References: <20210502140606.2720323-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 9b844b087124c1538d05f40fda8a4fec75af55be ]

Call spi_master_get() holds the reference count to master device, thus
we need an additional spi_master_put() call to reduce the reference
count, otherwise we will leak a reference to master.

This commit fix it by removing the unnecessary spi_master_get().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Link: https://lore.kernel.org/r/20210409082955.2907950-1-weiyongjun1@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-dln2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index b62a99caacc0..a41adea48618 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -783,7 +783,7 @@ static int dln2_spi_probe(struct platform_device *pdev)
 
 static int dln2_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
+	struct spi_master *master = platform_get_drvdata(pdev);
 	struct dln2_spi *dln2 = spi_master_get_devdata(master);
 
 	pm_runtime_disable(&pdev->dev);
-- 
2.30.2

