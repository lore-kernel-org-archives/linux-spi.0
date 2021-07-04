Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F469C11F67
	for <linux-spi@archiver.kernel.org>; Sun,  4 Jul 2021 23:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C095613F6
	for <linux-spi@archiver.kernel.org>; Sun,  4 Jul 2021 23:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhGDXJ7 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 4 Jul 2021 19:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231509AbhGDXJQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 4 Jul 2021 19:09:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90A73613F6;
        Sun,  4 Jul 2021 23:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625440000;
        bh=D1SZFDaMxPzzvYQFmKOyEyui/MyeIasJrxDmGU7ek9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+iXzOs3SrSba5GYjz4jI7wk9roZBaz/Zsv7xBNExeVOjYdyGLldVZeIAGfz+Fceu
         MiwGeJfEbbtWpDLAexT95vw2b3iSiIDvDTkySSpcwGA04EUfgVDBboyJoK2Htyqqcq
         bqoqpiXdIIoH2kjcBQJs+zyQ3I4K6pUUpdw2R3k7I6vAyRANSFGsuKacLqz4q5XOtx
         FvzCAMWGchjCnk6G5ZE0oA7TrPQeWHBuIvKcRc6CfoNoHBZZLOz6g1whRRH+esVQFQ
         ZajGKoIGBEkCS853RArkcOianj4orclPTBkP3TGDtEdTu67XAWI5uFMKIcWdq61155
         AKvoumpgqGVpQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tian Tao <tiantao6@hisilicon.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 18/80] spi: omap-100k: Fix the length judgment problem
Date:   Sun,  4 Jul 2021 19:05:14 -0400
Message-Id: <20210704230616.1489200-18-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210704230616.1489200-1-sashal@kernel.org>
References: <20210704230616.1489200-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Tian Tao <tiantao6@hisilicon.com>

[ Upstream commit e7a1a3abea373e41ba7dfe0fbc93cb79b6a3a529 ]

word_len should be checked in the omap1_spi100k_setup_transfer
function to see if it exceeds 32.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Link: https://lore.kernel.org/r/1619695248-39045-1-git-send-email-tiantao6@hisilicon.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-omap-100k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index ccd817ee4917..0d0cd061d356 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -241,7 +241,7 @@ static int omap1_spi100k_setup_transfer(struct spi_device *spi,
 	else
 		word_len = spi->bits_per_word;
 
-	if (spi->bits_per_word > 32)
+	if (word_len > 32)
 		return -EINVAL;
 	cs->word_len = word_len;
 
-- 
2.30.2

