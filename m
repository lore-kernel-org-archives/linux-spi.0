Return-Path: <SRS0=I8nA=CC=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E949C433E3
	for <linux-spi@archiver.kernel.org>; Mon, 24 Aug 2020 16:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529B522CAD
	for <linux-spi@archiver.kernel.org>; Mon, 24 Aug 2020 16:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598286925;
	bh=az4yEgrjHgkf2SWPtDXY2R7EE5T2ZGVFoKkZLQuw5V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VxlGd8PiQcwtlbUpBCzHUVkuhtGIbunL+6PaLFm/PgT32dWJs15HdgasVF04AWOtg
	 jkfXKB3Hmba9Okv0Pf9DNvVz/lIqEIF6nPFPjLiD3kA17/i0aGGp33DR/nf6YuVH/s
	 iTxNedJnkKleQJZasaMgFQc7pJCmsWx4FuQJsXP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgHXQfX (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbgHXQfV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 Aug 2020 12:35:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9434C22CA1;
        Mon, 24 Aug 2020 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286921;
        bh=az4yEgrjHgkf2SWPtDXY2R7EE5T2ZGVFoKkZLQuw5V0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHfhXnsW5T6T91LYzT5fHJSNKL9vyrFDBi94YJ1CF9GYUXwKN+x/dD7LJ1vdgcVdu
         1q6EXrVQCI+Ei+c6B/ne/dbOPa+lyaJRz/I1iWa+ngLTqGX1SZtdTO7BoXt8Le/aIA
         W/AB7ioCVi8fF5KpZMQ6l8YKEyx3SxBpyzj3PJdI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Antonio Borneo <antonio.borneo@st.com>,
        Alain Volmat <alain.volmat@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.8 13/63] spi: stm32h7: fix race condition at end of transfer
Date:   Mon, 24 Aug 2020 12:34:13 -0400
Message-Id: <20200824163504.605538-13-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163504.605538-1-sashal@kernel.org>
References: <20200824163504.605538-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Antonio Borneo <antonio.borneo@st.com>

[ Upstream commit 135dd873d3c76d812ae64c668adef3f2c59ed27f ]

The caller of stm32_spi_transfer_one(), spi_transfer_one_message(),
is waiting for us to call spi_finalize_current_transfer() and will
eventually schedule a new transfer, if available.
We should guarantee that the spi controller is really available
before calling spi_finalize_current_transfer().

Move the call to spi_finalize_current_transfer() _after_ the call
to stm32_spi_disable().

Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
Link: https://lore.kernel.org/r/1597043558-29668-2-git-send-email-alain.volmat@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4a21feae0103d..814a3ec3b8ada 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -971,8 +971,8 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	spin_unlock_irqrestore(&spi->lock, flags);
 
 	if (end) {
-		spi_finalize_current_transfer(master);
 		stm32h7_spi_disable(spi);
+		spi_finalize_current_transfer(master);
 	}
 
 	return IRQ_HANDLED;
-- 
2.25.1

