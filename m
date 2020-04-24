Return-Path: <SRS0=bXrU=6I=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7CFC2BA1A
	for <linux-spi@archiver.kernel.org>; Fri, 24 Apr 2020 09:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FC62166E
	for <linux-spi@archiver.kernel.org>; Fri, 24 Apr 2020 09:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587721215;
	bh=LX2osh5nsERs9uR9TT9eolw4EYuUZ+IitqCz0Epc0ss=;
	h=Subject:From:Date:To:List-ID:From;
	b=g3C2csjvD8NAZpAus77d2/0oLvmhLr36AuIx1ygWBBGupKHOViOjTcXErSt5rAmoA
	 h3XAWECHcF9DQSHB16HgNv/jqX3v2Qx/echyoao5/9gszhKDR1Z7M9hkqlYSAtz5rR
	 Qg8adzeM0Qym+2i1K8pQnujB3SyUMotSmzgJ4lsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgDXJkO (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbgDXJkO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Apr 2020 05:40:14 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587721214;
        bh=LX2osh5nsERs9uR9TT9eolw4EYuUZ+IitqCz0Epc0ss=;
        h=Subject:From:Date:To:From;
        b=AcED1zBhtL4P3DbQZYr+kmMCMqyn8+nWBc3hVF6G+2eZnQ36xh1nPOMbf6JBsYjXM
         EVxcM6EazZu6/2y2BUSjS9T+jy6eyupQ/PPNEycB8ngPdZQL9IP4PtTcYXoOGgzt5T
         EhppC7aNhGPzOi0FEFOHEZLDc5nzsiIjq7Y95VGQ=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158772121420.26554.8565171752186213742.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 24 Apr 2020 09:40:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dt-bindings: spi: Convert UniPhier SPI controller to json-schema (2020-04-24T09:29:22)
  Superseding: [v1] dt-bindings: spi: Convert UniPhier SPI controller to json-schema (2020-04-17T01:30:14):
    dt-bindings: spi: Convert UniPhier SPI controller to json-schema


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
