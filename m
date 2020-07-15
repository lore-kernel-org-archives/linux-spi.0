Return-Path: <SRS0=sEtw=A2=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E869C433FB
	for <linux-spi@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB6E2065D
	for <linux-spi@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RH7cBJ2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgGOPGx (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgGOPGw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 11:06:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2340C08C5DB
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so3096791wrm.4
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=42oj6jbSoGTF/ydaYibmpIO6VIJqDyq5aw5c0LpPRTc=;
        b=RH7cBJ2WlhKQHMXBNizOzo0T2ahy8XU3B6sEARR+uPl/o4nKI3IuEZJ8uLvbbZC5t4
         l+AQ8s+3lqDbOapGH58ozWtwg6v2+RT2FZ/JrwPNhkDFeWKYhdds3OJIy2j/3nVpUHrf
         vghBDZGIJosR4XixZz0e228Ju4WbUGTyTYT3ukz5dmafd9HXsLrkhYug7ZwpZ93bHTAP
         2QenT/NInodOgQnlQXZhCDNVS3NG0xHeAslNgHrC3Z4fXIrCBuLGhlx+eqnWpBg6zyd6
         SI4SMBZdEt6nG3WgD8giZCqQmEn/lEzYF4u8dFu5sOWMyxqNUNeH2E/mOMwRTNvnggql
         BEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=42oj6jbSoGTF/ydaYibmpIO6VIJqDyq5aw5c0LpPRTc=;
        b=bGWsd/rwE+DPdNTcIkZzu4KRrd94ZRGLF41Ooq+w1I6+L9tl5hpuSpGIABPHEVCKJZ
         L2UjnhuZKYJWSKHlT4acD6q8GTof1O3sy3kBVCX32p79JJlOMLSudG+rheCWUUq7YZCG
         BVjf+DHVBT75G2rd6eH2RTnLvsGu5SwqpdUIiKA4KxYl0CUTVfaWpwTrrV83kDn839rU
         cD4f9iOIdOm+pqHOp8D4CECndO1M6PBPpYU7NNhIfKQjokpvb56qcTDGyZIHggOJigtP
         +Ao6tETLmXusT5PG5awn1fI7VrlRs0/tSswp0b1zdlaacvd5o8JCaK0mopa4QFty+ywH
         XdVA==
X-Gm-Message-State: AOAM533lyrDAu5+38EtE3P9cwxuV0WRFWDC3UsidpF7GprZlt5Qgo/hl
        FXuTZTH288uypysrX+7RiAWZaA==
X-Google-Smtp-Source: ABdhPJxc3qUeyfFWGzOmf9reFa92XgdB27XAAzFJpjdbVd7jj+ddsAHBcS7KpBUlsilZ+jYr/eF36A==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr11986837wrs.228.1594825610727;
        Wed, 15 Jul 2020 08:06:50 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 12/14] spi: spi-at91-usart: Make use of the defined 'struct of_device_id'
Date:   Wed, 15 Jul 2020 16:06:30 +0100
Message-Id: <20200715150632.409077-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It's there so why not use it.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-at91-usart.c:684:34: warning: ‘at91_usart_spi_dt_ids’ defined but not used [-Wunused-const-variable=]
 684 | static const struct of_device_id at91_usart_spi_dt_ids[] = {
 | ^~~~~~~~~~~~~~~~~~~~~

Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-at91-usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 88033422a42ae..d47a20be43ccd 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -692,6 +692,7 @@ static struct platform_driver at91_usart_spi_driver = {
 	.driver = {
 		.name = "at91_usart_spi",
 		.pm = &at91_usart_spi_pm_ops,
+		.of_match_table = at91_usart_spi_dt_ids,
 	},
 	.probe = at91_usart_spi_probe,
 	.remove = at91_usart_spi_remove,
-- 
2.25.1

