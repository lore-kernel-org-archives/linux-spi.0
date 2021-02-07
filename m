Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53A4C433E6
	for <linux-spi@archiver.kernel.org>; Sun,  7 Feb 2021 03:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5A764E90
	for <linux-spi@archiver.kernel.org>; Sun,  7 Feb 2021 03:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBGDK4 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sat, 6 Feb 2021 22:10:56 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39627 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229536AbhBGDKz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 6 Feb 2021 22:10:55 -0500
X-UUID: cf7bdd3aca7c4a5f845f02ee3baf42fb-20210207
X-UUID: cf7bdd3aca7c4a5f845f02ee3baf42fb-20210207
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 585972220; Sun, 07 Feb 2021 11:10:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 7 Feb 2021 11:10:10 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 7 Feb 2021 11:10:10 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <fparent@baylibre.com>
Subject: [PATCH 0/3] spi: add set_cs_timing support for HW/SW CS mode
Date:   Sun, 7 Feb 2021 11:09:50 +0800
Message-ID: <20210207030953.9297-1-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some controllers only have one HW CS, if support multiple devices, other devices need
to use SW CS.
This patch adds the support of both HW and SW CS via cs_gpio.

leilk.liu (3):
  spi: add power control when set_cs_timing
  spi: support CS timing for HW & SW mode
  spi: mediatek: add set_cs_timing support

 drivers/spi/spi-mt65xx.c | 72 +++++++++++++++++++++++++++++++---------
 drivers/spi/spi.c        | 32 +++++++++++++++---
 2 files changed, 83 insertions(+), 21 deletions(-)

-- 
2.18.0



