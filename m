Return-Path: <SRS0=AQmy=AA=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956C9C433DF
	for <linux-spi@archiver.kernel.org>; Fri, 19 Jun 2020 02:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EEA8206FA
	for <linux-spi@archiver.kernel.org>; Fri, 19 Jun 2020 02:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592532018;
	bh=xtbyWEViCfCO3om8YuzmGrFuW18e0Nto1r5OzBvwYV0=;
	h=Subject:From:Date:To:List-ID:From;
	b=T6NmQRHBMhV0EjUbe3t3N7ld+GjUkh/zsgfcHi0WfI1Sl/qkdfVjrCDr6JsILqcDt
	 hnBWq2fa7yTsQjE3cIec4z8Yx80cwORj2nFPc1nBfpKGGm9ZEabD7YB4m9wR24wr0z
	 HaL1+ckU8qspysyTNh/6F+Rb32mduDdj3V8OWGTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgFSCAS (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 18 Jun 2020 22:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgFSCAR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Jun 2020 22:00:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592532017;
        bh=xtbyWEViCfCO3om8YuzmGrFuW18e0Nto1r5OzBvwYV0=;
        h=Subject:From:Date:To:From;
        b=CUe9yVpL/DcApsd8nuKkLf1yocfOoVc9slosto7w5t391jOm/EzH8LsERFb0iLoGa
         4OjHmSfuiQtPPQaBd5sqh0XqDTRz4xmR7L5mW1KNgNcdW4YNAf99rGgg6Mr7VBKQlk
         aWsW9MlgKYKrB95/Xlp506KnSAzCKu5UkTcYHAFI=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159253201728.5371.13859118956273255035.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 19 Jun 2020 02:00:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] add regmap & indirect access support (2020-06-19T01:43:38)
  Superseding: [v2] add regmap & indirect access support (2020-06-18T15:25:10):
    [v2,4/6] spi: altera: use regmap-mmio instead of direct mmio register access
    [v2,5/6] spi: altera: support indirect access to the registers
    [v2,6/6] spi: altera: fix size mismatch on 64 bit processors


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
