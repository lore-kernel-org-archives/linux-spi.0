Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A34C433ED
	for <linux-spi@archiver.kernel.org>; Mon, 10 May 2021 06:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC266105A
	for <linux-spi@archiver.kernel.org>; Mon, 10 May 2021 06:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhEJG7j (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 10 May 2021 02:59:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2609 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhEJG7j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 May 2021 02:59:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FdsKK5pjzzmVTQ;
        Mon, 10 May 2021 14:56:21 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 14:58:23 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linuxarm@huawei.com>,
        <huangdaode@huawei.com>
Subject: [PATCH 0/4] spi: Set of cleanups
Date:   Mon, 10 May 2021 14:58:19 +0800
Message-ID: <1620629903-15493-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some cleanups of SPI drivers. No functional change.


Thanks,
Jay

Jay Fang (4):
  spi: ppc4xx: include <linux/io.h> instead of <asm/io.h>
  spi: omap-100k: Clean the value of 'status' is not used
  spi: delete repeated words in comments
  spi: spi-loopback-test: Fix 'tx_buf' might be 'rx_buf'

 drivers/spi/spi-bcm2835aux.c    | 2 +-
 drivers/spi/spi-dw-mmio.c       | 2 +-
 drivers/spi/spi-geni-qcom.c     | 4 ++--
 drivers/spi/spi-loopback-test.c | 2 +-
 drivers/spi/spi-omap-100k.c     | 2 --
 drivers/spi/spi-pl022.c         | 4 ++--
 drivers/spi/spi-ppc4xx.c        | 4 ++--
 7 files changed, 9 insertions(+), 11 deletions(-)

-- 
2.7.4

