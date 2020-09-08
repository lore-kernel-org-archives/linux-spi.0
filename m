Return-Path: <SRS0=Lsrg=CR=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6ABC43461
	for <linux-spi@archiver.kernel.org>; Tue,  8 Sep 2020 20:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE23920936
	for <linux-spi@archiver.kernel.org>; Tue,  8 Sep 2020 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599596420;
	bh=C/Dvlb+DhQF67ePBK/OM+pYPeHs5tqHwj3aMdcpDejY=;
	h=Subject:From:Date:To:List-ID:From;
	b=XLav6WWZ2m93JwUndtJLZu27g6QPZ9Sxhvwg9K6VP/iyXOXRC2cJO01S5SEte72e4
	 wR7c9dr3Dcaq2sgkkEf05uBLZjAUDlHZLmAcSDHVzUDZkIznAopimv28JO5It2BQOY
	 Csi6p8zwXYrRlvL6ObZQQIdCsa+7F8K+x/DBFXPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgIHUUU (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729305AbgIHUUP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Sep 2020 16:20:15 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599596415;
        bh=C/Dvlb+DhQF67ePBK/OM+pYPeHs5tqHwj3aMdcpDejY=;
        h=Subject:From:Date:To:From;
        b=jy6Y7yJb9txK9BaCKx1HtRQcHRRgftyK+krws/AhK009O5vOhizxydi2Xx6i26xui
         4miIXb4cUhF9g0ZT2azHSPv+8JR1EeZlw8U1hjAEGozL1grU1mQA49UQ4ZsTTxdXem
         ua+tNAq2iIeHbH6OCL7grwDDdt2OJHB3yexuXB1M=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159959641554.20005.11228331488530014992.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 08 Sep 2020 20:20:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: Fix memory leak on splited transfers (2020-09-08T15:11:29)
  Superseding: [v2] spi: Fix memory leak on splited transfers (2020-09-08T09:17:36):
    [v2] spi: Fix memory leak on splited transfers


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
