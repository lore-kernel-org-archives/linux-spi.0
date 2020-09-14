Return-Path: <SRS0=909V=CX=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B01C43461
	for <linux-spi@archiver.kernel.org>; Mon, 14 Sep 2020 14:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70ABE207EA
	for <linux-spi@archiver.kernel.org>; Mon, 14 Sep 2020 14:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600094113;
	bh=E2UGo2sQGtP/cvqzed6Qm48vWtNdhAPdX997cI1qKDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fga0Kkl7ssd2rTXtyJ/Xk/pkFKAW3Hc5H/9ZyCMRDVssd5BxyW5L6iiRMfghxEzsh
	 GauPWZaMnhYrqPXA2OsrNjnLZTiD1olht5fzfX2nGxoqEg7mCuKOqlkE6A9JK6cTEr
	 8ssegOm7YwPmuqiTrInhEmao/BX2/Urw03kgKc7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgINOcO (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 14 Sep 2020 10:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgINNGA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Sep 2020 09:06:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1E721BE5;
        Mon, 14 Sep 2020 13:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600088710;
        bh=E2UGo2sQGtP/cvqzed6Qm48vWtNdhAPdX997cI1qKDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z6KIFh9F+BSHA5FPDyQwx8gId5pZqA3HdqpnftR+zQSvAhce/W3fyfacOxZbieWHM
         AOgO/M5+NvyVdiKXx2sVFsVJrpMLwKtMGF6m+HY5vGtNGBXqcsW+jj054JUQM8A5No
         ajQnnNz4nCBR7+rRjWWL2a0/2daIxjcmaUCt42M0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/19] spi: spi-loopback-test: Fix out-of-bounds read
Date:   Mon, 14 Sep 2020 09:04:49 -0400
Message-Id: <20200914130502.1804708-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914130502.1804708-1-sashal@kernel.org>
References: <20200914130502.1804708-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

[ Upstream commit 837ba18dfcd4db21ad58107c65bfe89753aa56d7 ]

The "tx/rx-transfer - crossing PAGE_SIZE" test always fails when
len=131071 and rx_offset >= 5:

 spi-loopback-test spi0.0: Running test tx/rx-transfer - crossing PAGE_SIZE
 ...
   with iteration values: len = 131071, tx_off = 0, rx_off = 3
   with iteration values: len = 131071, tx_off = 0, rx_off = 4
   with iteration values: len = 131071, tx_off = 0, rx_off = 5
 loopback strangeness - rx changed outside of allowed range at: ...a4321000
   spi_msg@ffffffd5a4157690
     frame_length:  131071
     actual_length: 131071
     spi_transfer@ffffffd5a41576f8
       len:    131071
       tx_buf: ffffffd5a4340ffc

Note that rx_offset > 3 can only occur if the SPI controller driver sets
->dma_alignment to a higher value than 4, so most SPI controller drivers
are not affect.

The allocated Rx buffer is of size SPI_TEST_MAX_SIZE_PLUS, which is 132
KiB (assuming 4 KiB pages).  This test uses an initial offset into the
rx_buf of PAGE_SIZE - 4, and a len of 131071, so the range expected to
be written in this transfer ends at (4096 - 4) + 5 + 131071 == 132 KiB,
which is also the end of the allocated buffer.  But the code which
verifies the content of the buffer reads a byte beyond the allocated
buffer and spuriously fails because this out-of-bounds read doesn't
return the expected value.

Fix this by using ITERATE_LEN instead of ITERATE_MAX_LEN to avoid
testing sizes which cause out-of-bounds reads.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Link: https://lore.kernel.org/r/20200902132341.7079-1-vincent.whitchurch@axis.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-loopback-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index bed7403bb6b3a..b9a7117b6dce3 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -99,7 +99,7 @@ static struct spi_test spi_tests[] = {
 	{
 		.description	= "tx/rx-transfer - crossing PAGE_SIZE",
 		.fill_option	= FILL_COUNT_8,
-		.iterate_len    = { ITERATE_MAX_LEN },
+		.iterate_len    = { ITERATE_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
 		.iterate_rx_align = ITERATE_ALIGN,
 		.transfer_count = 1,
-- 
2.25.1

