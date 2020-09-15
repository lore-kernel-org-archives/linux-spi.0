Return-Path: <SRS0=Dyv7=CZ=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283C2C43461
	for <linux-spi@archiver.kernel.org>; Wed, 16 Sep 2020 00:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAF320771
	for <linux-spi@archiver.kernel.org>; Wed, 16 Sep 2020 00:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600217745;
	bh=84BJXmxD9h5jJhWLEJGH+YyluaLTIjldx9W1Ik1bP2M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=o29IXbxDaS0PTR5TyCVNwv0O5IAmZaPUAepm5dc1181jElyKimYDImBsagSCM7ZMs
	 0Gifho7md0Mt8wXuIF/b1BCFbmUSrMhU5nC6VJKXCQa+8wIuk7GawfVH9WFSFlhyKD
	 gMsOypm4s0fmohAuli7Ttlb9ryCaw1ogP+ugAOig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgIPAzZ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 15 Sep 2020 20:55:25 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:39147 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgIOLbW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Sep 2020 07:31:22 -0400
Received: by mail-ej1-f67.google.com with SMTP id p9so4503207ejf.6;
        Tue, 15 Sep 2020 04:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQsMdph5TWkiB/OAm5VzP4BU7+j9iIC7fVgWcyn6y08=;
        b=f2nBeb1swZoSUqWk7IcZBdphX86IWW2HBx641EexHTgHutbEu1KE7GLuTyMD9Y+3IR
         +b0WzVIQ9jBbb5waRVq80LtjDT9qk1hthkWkAQBdnEGkn54sQDu8K37isP+2Oclmg+cY
         RrP6QtyJTvxVCZ0QbnoL3XmYN8TGr+ruolKmf6lE8rVZniAHD+b6C/TctrYT8+LLyJRH
         Lsw5E0kN/SX7vTHFNupRydm7fb1KahhiupmyDhztiS90Sx1FjcodHAX97XDKHpMBEWAu
         7F1fa5L3OkSrAAGI2ToBYsDmClJ544VVnYKi4ch95QVP++pCDcQpNbLqAU3GmLD8O+Ks
         j63g==
X-Gm-Message-State: AOAM531ljpjInuladTQyqLOAz21n/2xH+8qtkFUAQiZ1FM1Atvar8AR2
        q8A3ogDWlrgvIJPnLNRadOg=
X-Google-Smtp-Source: ABdhPJykVDdbtJhhfjNLLwUBVCI49KMHfL6a3WshFxnn4/dYGha4kqeFCjpgt5AepM9SSQca4QYKuA==
X-Received: by 2002:a17:906:49cb:: with SMTP id w11mr7865688ejv.530.1600169379610;
        Tue, 15 Sep 2020 04:29:39 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id s30sm12024077edc.8.2020.09.15.04.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:29:38 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@kernel.org>
Subject: [PATCH] spi: xilinx: Fix info message during probe
Date:   Tue, 15 Sep 2020 13:29:36 +0200
Message-Id: <20200915112936.320647-1-ribalda@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The info message was showing the mapped address of the device. To avoid
security problems, all virtual addresses are converted to __ptrval__, so
the message was useless/ugly:

[    2.304949] xilinx_spi b0010000.spi-flash: at 0xB0010000 mapped to 0x(____ptrval____), irq=37

Use %pR instead:

[   15.021354] xilinx_spi b0010000.spi-flash: at [mem 0xb0010000-0xb001ffff], irq=37

Signed-off-by: Ricardo Ribalda <ribalda@kernel.org>
---
 drivers/spi/spi-xilinx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 8dd2bb99cb4d..523edfdf5dcd 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -491,8 +491,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		goto put_master;
 	}
 
-	dev_info(&pdev->dev, "at 0x%08llX mapped to 0x%p, irq=%d\n",
-		(unsigned long long)res->start, xspi->regs, xspi->irq);
+	dev_info(&pdev->dev, "at %pR, irq=%d\n", res, xspi->irq);
 
 	if (pdata) {
 		for (i = 0; i < pdata->num_devices; i++)
-- 
2.28.0

