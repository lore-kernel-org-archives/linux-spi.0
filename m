Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BE8C433E9
	for <linux-spi@archiver.kernel.org>; Thu, 11 Mar 2021 19:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62AF964EFE
	for <linux-spi@archiver.kernel.org>; Thu, 11 Mar 2021 19:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCKTMv (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 11 Mar 2021 14:12:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42272 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhCKTMf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:12:35 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BJCMBG123822;
        Thu, 11 Mar 2021 13:12:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615489942;
        bh=K10iL76Rgk2W/O4gIBcHwJ90W5MxbdgPMg2+TPXlU58=;
        h=From:To:CC:Subject:Date;
        b=U0Gg9VpIDlC5XhTwNU5ZcXVGc0e4yE6p72o3dGXDfKhIEpPaOrzft/ZrAYp0Ce7tF
         WYtqiP0mHXUJa3hg1kZWSHKB8ctox+3fwEkjSXaEEVg+RIUWEOxyv8uAkcOZiFkhl7
         8ajsTiqpSAgfgrWluhKM5zMPqFDWxjDWFuDab7Dg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BJCM8t112956
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 13:12:22 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 13:12:22 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 13:12:22 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BJCHvR080816;
        Thu, 11 Mar 2021 13:12:17 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [RFC PATCH 0/6] spi: Add OSPI PHY calibration support for spi-cadence-quadspi
Date:   Fri, 12 Mar 2021 00:42:10 +0530
Message-ID: <20210311191216.7363-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This series adds support for OSPI PHY calibration on the Cadence OSPI
controller. This calibration procedure is needed to allow high clock
speeds in 8D-8D-8D mode. The procedure reads some pre-determined pattern
data from the flash and runs a sequence of test reads to find out the
optimal delays for high speed transfer. More details on the calibration
procedure in patch 5/6.

The main problem here is telling the controller where to find the
pattern and how to read it. This RFC uses nvmem cells which point to a
fixed partition containing the data to do the reads. It depends on [0]
and [1].

The obvious problem with this is it won't work when the partitions are
defined via command line. I don't see any good way to add nvmem cells to
command line partitions. I would like some help or ideas here. We don't
necessarily have to use nvmem either. Any way that can cleanly and
consistently let the controller find out where the pattern is stored is
good.

The dts patch depends on [2].

Tested on TI's J721E EVM.

[0] https://patchwork.ozlabs.org/project/linux-mtd/patch/20210302190012.1255-1-zajec5@gmail.com/
[1] https://patchwork.ozlabs.org/project/linux-mtd/patch/20210308011853.19360-1-ansuelsmth@gmail.com/
[2] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210305153926.3479-2-p.yadav@ti.com/

Pratyush Yadav (6):
  spi: spi-mem: Tell controller when device is ready for calibration
  mtd: spi-nor: core: consolidate read op creation
  mtd: spi-nor: core: run calibration when initialization is done
  spi: cadence-qspi: Use PHY for DAC reads if possible
  spi: cadence-qspi: Tune PHY to allow running at higher frequencies
  arm64: dts: ti: k3-j721e-som-p0: Enable PHY calibration

 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi |  55 ++
 drivers/mtd/spi-nor/core.c                  |  74 +-
 drivers/spi/spi-cadence-quadspi.c           | 820 +++++++++++++++++++-
 drivers/spi/spi-mem.c                       |  12 +
 include/linux/spi/spi-mem.h                 |   8 +
 5 files changed, 916 insertions(+), 53 deletions(-)

--
2.30.0

