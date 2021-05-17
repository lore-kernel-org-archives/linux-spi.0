Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC991C433B4
	for <linux-spi@archiver.kernel.org>; Mon, 17 May 2021 14:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB6361074
	for <linux-spi@archiver.kernel.org>; Mon, 17 May 2021 14:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbhEQOFD (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 17 May 2021 10:05:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:52755 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237701AbhEQOEz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 May 2021 10:04:55 -0400
IronPort-SDR: y4E76X64FNwMfIeqN5yZeZbYSN7sz48CG6cwiTWod8kgdE7BncpUpwDShGxtcfY+96u/SlluyS
 31U9X+2WJniQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="180069938"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="180069938"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 07:03:39 -0700
IronPort-SDR: 83O4XpwY87zfbWy9otwwwHtt2q2eWehqjauZk9l8PffRPkopx7zW+MlqURrlYpfMGHVI+a8tWz
 RvgNCNMeEqjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="393527862"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2021 07:03:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6E6099A1; Mon, 17 May 2021 17:03:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 9/9] spi: pxa2xx: Use predefined mask when programming FIFO thresholds
Date:   Mon, 17 May 2021 17:03:51 +0300
Message-Id: <20210517140351.901-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
References: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The predefined mask for threshold modification can be used
in case of Intel Merrifield SPI. Replace open-coded value
with predefined mask when programming FIFO thresholds.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 94b1585de203..bdf9a283efc3 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1083,12 +1083,13 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 	}
 
 	if (is_mrfld_ssp(drv_data)) {
+		u32 mask = SFIFOTT_RFT | SFIFOTT_TFT;
 		u32 thresh = 0;
 
 		thresh |= SFIFOTT_RxThresh(chip->lpss_rx_threshold);
 		thresh |= SFIFOTT_TxThresh(chip->lpss_tx_threshold);
 
-		pxa2xx_spi_update(drv_data, SFIFOTT, 0xffffffff, thresh);
+		pxa2xx_spi_update(drv_data, SFIFOTT, mask, thresh);
 	}
 
 	if (is_quark_x1000_ssp(drv_data))
-- 
2.30.2

