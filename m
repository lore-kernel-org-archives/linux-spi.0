Return-Path: <SRS0=RtOV=7O=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754F4C433DF
	for <linux-spi@archiver.kernel.org>; Mon,  1 Jun 2020 07:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7B9206C3
	for <linux-spi@archiver.kernel.org>; Mon,  1 Jun 2020 07:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590996018;
	bh=AASnkFJ1OGiYPeUplM+gkpmXKXk0nlO8AiMzspp2WZs=;
	h=Subject:From:Date:To:List-ID:From;
	b=hIelyWQFv6wd4qFto6odUdeZyNBIjCnpUT/606+H0hE1tYSMkhHtgFE3OwgCzTTpP
	 YeHE8n+ZxwwtM5Pcd5+rg0fq6bD3frcVxOZa95tXXds2lcEYFnM2oyhzTYE2dWjNJv
	 f5cl+VFFmcgdk1sUHGZWY12ps1qqnoYbdr+9hCZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFAHUS (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFAHUR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Jun 2020 03:20:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590996017;
        bh=AASnkFJ1OGiYPeUplM+gkpmXKXk0nlO8AiMzspp2WZs=;
        h=Subject:From:Date:To:From;
        b=2DPaG9Okw42aNFIrTI3QJy4AOS1KPqYjSjs39GRWIyN5DH2JtWFEa2UB9HbZv9U6w
         E6qMGyQf4XV89gAQHLnxsQ734yemHQluep8xGkJ9Pi4q/v1ZFOy6p/4YFs3+KrlGbj
         EmgPpFEWX1CajxXC1Rwny0NVaPSGgnmVHXz4zMd0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159099601755.7393.17449873011184966309.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 01 Jun 2020 07:20:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] mtd: spi-nor: Move cadence-qaudspi to spi-mem framework (2020-06-01T07:04:36)
  Superseding: [v3] mtd: spi-nor: Move cadence-qaudspi to spi-mem framework (2020-06-01T05:47:17):
    [v3,1/8] mtd: spi-nor: cadence-quadspi: Make driver independent of flash geometry
    [v3,2/8] mtd: spi-nor: cadence-quadspi: Provide a way to disable DAC mode
    [v3,3/8] mtd: spi-nor: cadence-quadspi: Don't initialize rx_dma_complete on failure
    [v3,4/8] mtd: spi-nor: cadence-quadspi: Fix error path on failure to acquire reset lines
    [v3,5/8] mtd: spi-nor: cadence-quadspi: Handle probe deferral while requesting DMA channel
    [v3,6/8] mtd: spi-nor: cadence-quadspi: Drop redundant WREN in erase path
    [v3,7/8] mtd: spi-nor: Convert cadence-quadspi to use spi-mem framework
    [v3,8/8] spi: Move cadence-quadspi driver to drivers/spi/


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
