Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D904C433ED
	for <linux-spi@archiver.kernel.org>; Thu,  6 May 2021 03:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEFFF613BA
	for <linux-spi@archiver.kernel.org>; Thu,  6 May 2021 03:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhEFDBY (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 5 May 2021 23:01:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17133 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhEFDBY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 May 2021 23:01:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FbJC93v2xzmfff;
        Thu,  6 May 2021 10:57:09 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 6 May 2021 11:00:16 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>, <linus.walleij@linaro.org>
CC:     <linux-spi@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linuxarm@huawei.com>, <huangdaode@huawei.com>,
        <tangzihao1@hisilicon.com>
Subject: [PATCH 0/2] spi: Correct CS GPIOs polarity when using GPIO descriptors
Date:   Thu, 6 May 2021 11:00:15 +0800
Message-ID: <1620270017-52643-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series introduces a generic implementation to solve the conflict
between the 'cs-gpios' flags and the optional SPI slaves flags. So we
don't need to add two similar quirks separately for DT and ACPI.

Jay Fang (2):
  spi: Correct CS GPIOs polarity when using GPIO descriptors
  Revert "gpio: of: Handle SPI chipselect legacy bindings"

 drivers/gpio/gpiolib-of.c | 51 ++---------------------------------------------
 drivers/spi/spi.c         | 22 ++++++++++++++++++--
 2 files changed, 22 insertions(+), 51 deletions(-)

-- 
2.7.4

