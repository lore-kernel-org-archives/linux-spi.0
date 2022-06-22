Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745FDC433EF
	for <linux-spi@archiver.kernel.org>; Wed, 22 Jun 2022 09:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352467AbiFVJmv (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 22 Jun 2022 05:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353024AbiFVJmu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jun 2022 05:42:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5041B39B95;
        Wed, 22 Jun 2022 02:42:47 -0700 (PDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4LSdj2219wz4xYD;
        Wed, 22 Jun 2022 19:42:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LSdhv20GYz4xZb;
        Wed, 22 Jun 2022 19:42:39 +1000 (AEST)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 0/2] spi: aspeed: Fix division by zero
Date:   Wed, 22 Jun 2022 11:42:31 +0200
Message-Id: <20220622094233.3681843-1-clg@kaod.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

Here is a small series adding some debug and fixing a division by zero
on a board using normal speed reads.

Thanks,

C.


Cédric Le Goater (2):
  spi: aspeed: Add pr_debug in aspeed_spi_dirmap_create()
  spi: aspeed: Fix division by zero

 drivers/spi/spi-aspeed-smc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.35.3

