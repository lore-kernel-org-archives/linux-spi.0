Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072FFC433F5
	for <linux-spi@archiver.kernel.org>; Tue, 15 Feb 2022 13:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiBONvi (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 15 Feb 2022 08:51:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbiBONvi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Feb 2022 08:51:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EC725A;
        Tue, 15 Feb 2022 05:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644933086; x=1676469086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zv+6j7DA++nKuf+1imlUXac7YUZj4G6vcjRBGLnjSIw=;
  b=hW/rywcZJtY8uubMnAhwtyxRdpSP7A8hNEdCrKGIwwxBfaBH/I0D5XbV
   5K2ggzs23Q4eFvHFxer2RUAGqFsFTtv34kZPlGL94TSbaNV2O2/Q/q9Pb
   Lj4r1A+34OG798ourKoN+YiwRQICv2tgm/4bu5k+IbOWB5LMmtOtg0PAK
   ArSujRQpEnGl/9du+Lr73qYjDe5rCH+oRfc4SgM0G45Xv5IJj2QWTGPyP
   iVGxshHhPAA/fic2iNLwbVI7W2Lszap3q6mKRbYdIbqOIElS8QktC37VK
   ldKOut0uDefMcVJWrGrPhoySq4Vj3R6T/0zPINF+Q+/P9QjL7oCYPgAP6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="336784798"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="336784798"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 05:51:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="775848019"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 15 Feb 2022 05:51:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C77EF15B; Tue, 15 Feb 2022 15:51:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/1] spi: intel-pci: Add support for Intel Ice Lake-N SPI serial flash
Date:   Tue, 15 Feb 2022 15:51:39 +0200
Message-Id: <20220215135139.4328-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Intel Ice Lake-N has the same SPI serial flash controller as Ice Lake-LP.
Add Ice Lake-N PCI ID to the driver list of supported devices.

The device can be found on MacBookPro16,2 [1].

[1]: https://linux-hardware.org/?probe=f1c5cf0c43

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on top of spi-mem conversion series (Michael Walle)
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index a9cb4d77ffe3..a5ef7a526a7f 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -66,6 +66,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x19e0), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x1bca), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x34a4), (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x38a4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x43a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x4b24), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x4da4), (unsigned long)&bxt_info },
-- 
2.34.1

