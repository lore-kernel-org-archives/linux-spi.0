Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010ACC48BD1
	for <linux-spi@archiver.kernel.org>; Fri, 11 Jun 2021 19:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D729D613CD
	for <linux-spi@archiver.kernel.org>; Fri, 11 Jun 2021 19:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhFKTEs (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 11 Jun 2021 15:04:48 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49813 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhFKTEr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Jun 2021 15:04:47 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 8FA0760002;
        Fri, 11 Jun 2021 19:02:46 +0000 (UTC)
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
Subject: Re: [PATCH v5 3/3] mtd: spinand: add SPI-NAND MTD resume handler
Date:   Fri, 11 Jun 2021 21:02:43 +0200
Message-Id: <20210611190243.226413-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210602094913.26472-4-patrice.chotard@foss.st.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9cc910f4c03847b44ff8d60e76b42d529374495a'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 2021-06-02 at 09:49:13 UTC,  wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> After power up, all SPI NAND's blocks are locked. Only read operations
> are allowed, write and erase operations are forbidden.
> The SPI NAND framework unlocks all the blocks during its initialization.
> 
> During a standby low power, the memory is powered down, losing its
> configuration.
> During the resume, the QSPI driver state is restored but the SPI NAND
> framework does not reconfigured the memory.
> 
> This patch adds SPI-NAND MTD PM handlers for resume ops.
> SPI NAND resume op re-initializes SPI NAND flash to its probed state.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
