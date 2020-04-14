Return-Path: <SRS0=dGVP=56=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F03C2BB86
	for <linux-spi@archiver.kernel.org>; Tue, 14 Apr 2020 11:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFB3206D5
	for <linux-spi@archiver.kernel.org>; Tue, 14 Apr 2020 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586864421;
	bh=SaNMYuHrz/RvPIb18oFaTs9R29zuRVeA6bZlOmfD5hU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=kAsGSEC7Gg4iNqpQ2HyV8r+SbzOyPnDt/8QcVfDjSiMSYV4BXQmhhwwsemxZgJ/Kf
	 IsN/ueRyU7xrOmDrxDX2TeaosWcfzTAWQojgiF96L6JYGVglbOux5MqazEprw9SBdy
	 9tZXRs/YFQCowA7irFjPyHSctccLHtx2gnoxgCPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439441AbgDNLkO (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729841AbgDNLkF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Apr 2020 07:40:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF85720768;
        Tue, 14 Apr 2020 11:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586864405;
        bh=SaNMYuHrz/RvPIb18oFaTs9R29zuRVeA6bZlOmfD5hU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J7Ds1y8kxiHqwdoF+J4q2IdNfDIma7GNSFEUx4As/us7CdvINCH24oJbjskV5kjyU
         mAlQYxNOmdq/No6kiuw3GCQdufc/WXXE2unX8wT4RG/PwwESk0Blg1qE3V9RpkbRkB
         vh0hbLjfNkBvUc79iz/PjNt9qGUhWiAAQIYDP+sQ=
Date:   Tue, 14 Apr 2020 12:40:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Respect DataBitLength field of SpiSerialBusV2() ACPI resource" to the spi tree
In-Reply-To:  <20200413180406.1826-1-andriy.shevchenko@linux.intel.com>
Message-Id:  <applied-20200413180406.1826-1-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Respect DataBitLength field of SpiSerialBusV2() ACPI resource

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 0dadde344d965566589cd82797893d5aa06557a3 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 13 Apr 2020 21:04:06 +0300
Subject: [PATCH] spi: Respect DataBitLength field of SpiSerialBusV2() ACPI
 resource

By unknown reason the commit 64bee4d28c9e
  ("spi / ACPI: add ACPI enumeration support")
missed the DataBitLength property to encounter when parse SPI slave
device data from ACPI.

Fill the gap here.

Fixes: 64bee4d28c9e ("spi / ACPI: add ACPI enumeration support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20200413180406.1826-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0996d238f61e..531d1de85f7f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2111,6 +2111,7 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 			}
 
 			lookup->max_speed_hz = sb->connection_speed;
+			lookup->bits_per_word = sb->data_bit_length;
 
 			if (sb->clock_phase == ACPI_SPI_SECOND_PHASE)
 				lookup->mode |= SPI_CPHA;
-- 
2.20.1

