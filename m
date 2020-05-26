Return-Path: <SRS0=TAp4=7I=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D582CC433E0
	for <linux-spi@archiver.kernel.org>; Tue, 26 May 2020 15:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0B22078C
	for <linux-spi@archiver.kernel.org>; Tue, 26 May 2020 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590506416;
	bh=woyPG8irQcZtXgE+2L2sU5qtKBrg1udD0ZLraO6+mnE=;
	h=Subject:From:Date:To:List-ID:From;
	b=LrJSsaq9Ssd6WtJQN2rbGQF9RIpP8PadWbzoD7M1cH5Yi+p0ZPgFKIBTyL6QZDjwZ
	 irI77AtEkoYNhI0g3hKMsZTahUD1voiQNOSKcu7UVc+W/htoUfLV9fpUrlgVAr+6nC
	 GE96wu3ni2HjN9vC29FoRx+H+4bOcBYyrQwPpmZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgEZPUQ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 26 May 2020 11:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgEZPUQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 11:20:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590506416;
        bh=woyPG8irQcZtXgE+2L2sU5qtKBrg1udD0ZLraO6+mnE=;
        h=Subject:From:Date:To:From;
        b=JCxRTrxcKZSl5LUfVnm0QkOaIKd0o8zdZIctJ/nzkv3wUk2A7y/sn/4tm+5CQDA7v
         tM/LVp+Gmy1gxfDp58gzajTZBPOkbeCkwAeqmPqqbPrUBs1ZBk0+knhDyzr+vI4YSc
         gWrsTJ87jB9k75Q1isAzwAFEZiMvIyLIeRHLYQ50=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159050641601.8841.3949491848158014858.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 26 May 2020 15:20:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: dw: add reset control (2020-05-26T15:12:17)
  Superseding: [v1] spi: dw: add reset control (2020-05-21T17:03:59):
    [1/2] spi: dw: add reset control
    [2/2] dt-bindings: snps,dw-apb-ssi: add optional reset property


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
