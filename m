Return-Path: <SRS0=w6ou=B5=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA75C433DF
	for <linux-spi@archiver.kernel.org>; Wed, 19 Aug 2020 13:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34243208A9
	for <linux-spi@archiver.kernel.org>; Wed, 19 Aug 2020 13:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgHSNGM (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgHSNAO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 09:00:14 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9625C061359
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 05:59:15 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id HQz6230064C55Sk01Qz62X; Wed, 19 Aug 2020 14:59:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NgI-0002bc-03; Wed, 19 Aug 2020 14:59:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NgH-0005SY-U6; Wed, 19 Aug 2020 14:59:05 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/7] spi: rspi: Bit rate improvements
Date:   Wed, 19 Aug 2020 14:58:57 +0200
Message-Id: <20200819125904.20938-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

	Hi Mark,

This patch series contains several improvements for the Renesas SPI/QSPI
driver related to bit rate configuration.

Changes compared to v1
(https://lore.kernel.org/r/20200608095940.30516-1-geert+renesas@glider.be):
  - Drop accepted patch.

This has been tested on RSK+RZA1 (RSPI) and R-Car M2-W/Koelsch (QSPI),
using a scope and logic analyzer, except for the by-one divider on QSPI.
This has not been tested on legacy SuperH, due to lack of hardware.

Thanks for your comments!

Geert Uytterhoeven (7):
  spi: rspi: Remove useless .set_config_register() check
  spi: rspi: Clean up Bit Rate Division Setting handling
  spi: rspi: Increase bit rate accuracy on RZ/A
  spi: rspi: Increase bit rate range for RSPI on SH
  spi: rspi: Increase bit rate range for QSPI
  spi: rspi: Fill in spi_transfer.effective_speed_hz
  spi: rspi: Fill in controller speed limits

 drivers/spi/spi-rspi.c | 81 +++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 29 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
