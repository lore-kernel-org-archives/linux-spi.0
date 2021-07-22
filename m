Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995A5C6377D
	for <linux-spi@archiver.kernel.org>; Thu, 22 Jul 2021 05:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC8460FDB
	for <linux-spi@archiver.kernel.org>; Thu, 22 Jul 2021 05:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGVEyE (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 22 Jul 2021 00:54:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:49349 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhGVEyB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Jul 2021 00:54:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="297132153"
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="297132153"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 22:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="632868433"
Received: from ubuntu18.png.intel.com ([10.88.229.69])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2021 22:34:33 -0700
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: =?utf-8?q?=5B=E2=80=9CPATCH=E2=80=9D=200/2=5D=20Add=20support=20for=20Intel=20Thunder=20Bay=20SPI?=
Date:   Thu, 22 Jul 2021 13:33:56 +0800
Message-Id: <20210722053358.29682-1-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Hi,

This patch set enables the support for Designware SPI on the Intel Thunder Bay SoC.

Patch 1: SPI DT bindings for Intel Thunder Bay SoC
Patch 2: Adds support for Designware SPI on Intel Thunderbay SoC

Please help to review this patch set.

Thanks & Regards,
Nandhini

Nandhini Srikandan (2):
  dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
  spi: dw: Add support for Intel Thunder Bay SPI

 .../bindings/spi/snps,dw-apb-ssi.yaml         |  2 ++
 drivers/spi/spi-dw-core.c                     |  6 ++++++
 drivers/spi/spi-dw-mmio.c                     | 20 +++++++++++++++++++
 drivers/spi/spi-dw.h                          | 15 ++++++++++++++
 4 files changed, 43 insertions(+)

-- 
2.17.1

