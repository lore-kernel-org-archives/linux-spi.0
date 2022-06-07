Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF79CC43334
	for <linux-spi@archiver.kernel.org>; Tue,  7 Jun 2022 07:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbiFGHko (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 7 Jun 2022 03:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237758AbiFGHkk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jun 2022 03:40:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1198DBA9AF;
        Tue,  7 Jun 2022 00:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654587641; x=1686123641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IIzNUwsPeY1RReNMe2C/kRZYXKUGZUuwGKlpnOb09GU=;
  b=gjZ1obDUZYNS781Nv58/MYHOv4P92esQog21y7pZGsOLBfaZ/VPLeefq
   SJ275WezUENGVEqvaUlWhJYjHU7ukwtGZ5LZBibnJDsm0yT0dAFxmTU8Q
   KiF8BtSNSxtCHzeOmTYZAJbNPBIhJKDGc+06TOdaR3dRlxelOP0/k1epe
   70Q+u5R/u/tXnGFdkjpyQVvFzc2+IQt6FOdA3+YspW9raoP38fXzZ90d2
   2TT/mnJ4vPJvkRGw5s6IRM1CAq+Ru+iZdHlWywQAOxc8MQUAE1uaBqqn8
   75BHpagjDOkSh2c58GY5tMsw5FPNm0pcUGvbqf/8kdlzRxvVJWdTPFccl
   g==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="167043056"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 00:40:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 00:40:38 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Jun 2022 00:40:36 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 2/2] MAINTAINERS: add spi to PolarFire SoC entry
Date:   Tue, 7 Jun 2022 08:38:34 +0100
Message-ID: <20220607073833.2331539-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607073833.2331539-1-conor.dooley@microchip.com>
References: <20220607073833.2331539-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add the newly introduced spi driver to the existing PolarFire SoC entry.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f468864fd268..279a25065942 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16955,6 +16955,7 @@ S:	Supported
 F:	arch/riscv/boot/dts/microchip/
 F:	drivers/mailbox/mailbox-mpfs.c
 F:	drivers/soc/microchip/
+F:	drivers/spi/spi-microchip-core.c
 F:	include/soc/microchip/mpfs.h
 
 RNBD BLOCK DRIVERS
-- 
2.36.1

