Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3744FC433DB
	for <linux-spi@archiver.kernel.org>; Thu,  7 Jan 2021 16:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5ADC22C9F
	for <linux-spi@archiver.kernel.org>; Thu,  7 Jan 2021 16:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbhAGQtb (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:49:31 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33596 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726073AbhAGQtb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Jan 2021 11:49:31 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 107GfxHG029295;
        Thu, 7 Jan 2021 10:48:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=DHyLUk80bPAUFzI+JpiNtaZNx0l+NW7rtrnD/LRyaXo=;
 b=kJSbwBeho7ZEJJwQZ5+3jjVD5dF+PNIFZd2Cw5EdR+SbtMGMp55oVxSbvPE8DP7/QM2P
 CRctzzB6KE+we83oG7zXEMoEAfpA0IYBATmXXq/Z/jF7XFPiZgZbkPbRTJ60cNfA1ECC
 msxJN/X254VJB0GnNYHYX3knOp7ixkPZ1X8fril2PcGUHTVBTmP2NFceCGNQwauYfvnf
 IOojR0hbwzSvhWOCu/I/jqnY68dOr/nLEHkmOA9S/ZIgxwSeQrjOUnuUjqMcqCGIP7VX
 fBCOWicjV/fsb7veZHSeEiX025SLSAF2i8e7le4bd1ZUhJH9DrE5jbFfulFup2zKfYaf lw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 35wqjm13md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 07 Jan 2021 10:48:37 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 7 Jan 2021
 16:48:35 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 7 Jan 2021 16:48:35 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.226])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 125BC11CB;
        Thu,  7 Jan 2021 16:48:29 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <nsaenzjulienne@suse.de>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>
CC:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-spi@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] spi: bcm2835: Set controller max_speed_hz
Date:   Thu, 7 Jan 2021 16:48:25 +0000
Message-ID: <20210107164825.21919-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070099
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Set the struct spi_controller max_speed_hz. This is based on the
reported source clock frequency during probe. The maximum bus clock
is half the source clock (as per the code in bcm2835_spi_transfer_one).

If the controller max_speed_hz is not set, the spi core will limit all
transfers to 0 Hz so only the minimum possible bus frequency would be used.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/spi/spi-bcm2835.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 197485f2c2b2..8e161f4f7766 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1307,6 +1307,8 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(bs->clk),
 				     "could not get clk\n");
 
+	ctlr->max_speed_hz = clk_get_rate(bs->clk) / 2;
+
 	bs->irq = platform_get_irq(pdev, 0);
 	if (bs->irq <= 0)
 		return bs->irq ? bs->irq : -ENODEV;
-- 
2.20.1

