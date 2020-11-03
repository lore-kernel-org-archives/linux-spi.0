Return-Path: <SRS0=2vyr=EJ=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154C7C00A89
	for <linux-spi@archiver.kernel.org>; Tue,  3 Nov 2020 02:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE6222264
	for <linux-spi@archiver.kernel.org>; Tue,  3 Nov 2020 02:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKCCPX (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 2 Nov 2020 21:15:23 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41376 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgKCCPX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Nov 2020 21:15:23 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3FE49200293;
        Tue,  3 Nov 2020 03:15:21 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E70EB200145;
        Tue,  3 Nov 2020 03:15:18 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A75FF402BC;
        Tue,  3 Nov 2020 03:15:15 +0100 (CET)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     olteanv@gmail.com, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhao Qiang <qiang.zhao@nxp.com>
Subject: [Patch v2] spi: fsl-dspi: fix wrong pointer in suspend/resume
Date:   Tue,  3 Nov 2020 10:05:46 +0800
Message-Id: <20201103020546.1822-1-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Zhao Qiang <qiang.zhao@nxp.com>

Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in
remove path"), this driver causes a "NULL pointer dereference"
in dspi_suspend/resume.
This is because since this commit, the drivers private data point to
"dspi" instead of "ctlr", the codes in suspend and resume func were
not modified correspondly.

Fixes: 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove path")
Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v2:
	- modify commit msg

 drivers/spi/spi-fsl-dspi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 3967afa..1a08c1d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1080,12 +1080,11 @@ MODULE_DEVICE_TABLE(of, fsl_dspi_dt_ids);
 #ifdef CONFIG_PM_SLEEP
 static int dspi_suspend(struct device *dev)
 {
-	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
+	struct fsl_dspi *dspi = dev_get_drvdata(dev);
 
 	if (dspi->irq)
 		disable_irq(dspi->irq);
-	spi_controller_suspend(ctlr);
+	spi_controller_suspend(dspi->ctlr);
 	clk_disable_unprepare(dspi->clk);
 
 	pinctrl_pm_select_sleep_state(dev);
@@ -1095,8 +1094,7 @@ static int dspi_suspend(struct device *dev)
 
 static int dspi_resume(struct device *dev)
 {
-	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
+	struct fsl_dspi *dspi = dev_get_drvdata(dev);
 	int ret;
 
 	pinctrl_pm_select_default_state(dev);
@@ -1104,7 +1102,7 @@ static int dspi_resume(struct device *dev)
 	ret = clk_prepare_enable(dspi->clk);
 	if (ret)
 		return ret;
-	spi_controller_resume(ctlr);
+	spi_controller_resume(dspi->ctlr);
 	if (dspi->irq)
 		enable_irq(dspi->irq);
 
-- 
2.7.4

