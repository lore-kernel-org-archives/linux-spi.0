Return-Path: <SRS0=1/NZ=EL=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B181AC00A89
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 09:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A76C20684
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 09:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="YeVVtnn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgKEJGd (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 5 Nov 2020 04:06:33 -0500
Received: from first.geanix.com ([116.203.34.67]:41956 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbgKEJGc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Nov 2020 04:06:32 -0500
Received: from zen.localdomain (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id CBB19EC4CD9;
        Thu,  5 Nov 2020 09:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1604567190; bh=UbM8Yd9BDcaDrqhzOEsBaU3gI3qMZVu6V25NKV/MxtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YeVVtnn0FzVaiTclO10f9Uk3k005fENPUCr5N5gK0HOChJEKnktkOXQwI5xUBb/Nq
         qni7FgfKNu1ljTdJw0Nlj1C40dEu0xM3J59xO5ACl25Hw3oWPmxAV5seCdPY+wfpin
         Mm/Y9DzGgRMwBCdT3jOuO2BJaeKGJoEerkpru6vmyrYIYMdLK5lzCKnG+0OnyOS4Om
         tfuBLG4CXDWCpwocslovnToYfOitfBTOl5QP1B4Q+YsgsPZ5C8QSlzgT74J7Y0MPiX
         DY9kDlBDulsPapSMwH91+XJ2rbx4XgfS7a9uCG6w2/+0u4kWOVAGL9409IUr2AuAJD
         7M8ASi0QXiHDw==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH] spi: bcm2835: remove use of uninitialized gpio flags variable
Date:   Thu,  5 Nov 2020 10:06:15 +0100
Message-Id: <20201105090615.620315-1-martin@geanix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014090230.2706810-1-martin@geanix.com>
References: <20201014090230.2706810-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Removing the duplicate gpio chip select level handling in
bcm2835_spi_setup() left the lflags variable uninitialized. Avoid trhe
use of such variable by passing default flags to
gpiochip_request_own_desc().

Fixes: 5e31ba0c0543 ("spi: bcm2835: fix gpio cs level inversion")
Signed-off-by: Martin Hundebøll <martin@geanix.com>
---

Feel free to squash this commit with my previous patch, if rebasing
for-next is allowed.

 drivers/spi/spi-bcm2835.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 9b6ba94fe878..7104cf17b848 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1193,7 +1193,6 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	struct spi_controller *ctlr = spi->controller;
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	struct gpio_chip *chip;
-	enum gpio_lookup_flags lflags;
 	u32 cs;
 
 	/*
@@ -1261,7 +1260,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 
 	spi->cs_gpiod = gpiochip_request_own_desc(chip, 8 - spi->chip_select,
 						  DRV_NAME,
-						  lflags,
+						  GPIO_LOOKUP_FLAGS_DEFAULT,
 						  GPIOD_OUT_LOW);
 	if (IS_ERR(spi->cs_gpiod))
 		return PTR_ERR(spi->cs_gpiod);
-- 
2.28.0

