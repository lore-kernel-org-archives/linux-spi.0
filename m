Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1111C48BE0
	for <linux-spi@archiver.kernel.org>; Fri, 11 Jun 2021 19:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB886613CD
	for <linux-spi@archiver.kernel.org>; Fri, 11 Jun 2021 19:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhFKTEz (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 11 Jun 2021 15:04:55 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:56307 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhFKTEy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Jun 2021 15:04:54 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 77FEA40003;
        Fri, 11 Jun 2021 19:02:53 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     patrice.chotard@foss.st.com, Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     christophe.kerello@foss.st.com
Subject: Re: [PATCH v5 2/3] mtd: spinand: Add spinand_init_flash() helper
Date:   Fri, 11 Jun 2021 21:02:52 +0200
Message-Id: <20210611190252.226505-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210602094913.26472-3-patrice.chotard@foss.st.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'bd50dc4befae732f7fb827eccddb2219f9745b91'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 2021-06-02 at 09:49:12 UTC,  wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Add spinand_init_flash() helper which implement
> all needed init for future SPI-NAND resume ops.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
