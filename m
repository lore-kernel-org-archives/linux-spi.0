Return-Path: <SRS0=n0rM=AB=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D440C433E0
	for <linux-spi@archiver.kernel.org>; Sat, 20 Jun 2020 03:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6C320706
	for <linux-spi@archiver.kernel.org>; Sat, 20 Jun 2020 03:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592625015;
	bh=1dzO3Dqt7ZePdOV8eldlHH7E5//9qPrhOSYaJOEXnY8=;
	h=Subject:From:Date:To:List-ID:From;
	b=lvfdosMHvWMBdbqMbuMV3jq9LnN1ZGWXgtMJ8HjK9tHOn1OJbxsB/PtnXVFlgG0GF
	 kjztTf+MtSDCaJBIgneocxRdoMQMq5fY0mdGtLrnKJ+2MmYXLV2DTEA9Rhwfx+gN9k
	 52IJ+QKGMKMRI9MSrbOM1hyrDwN3wH75l3VSZGIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgFTDuO (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFTDuO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Jun 2020 23:50:14 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592624417;
        bh=1dzO3Dqt7ZePdOV8eldlHH7E5//9qPrhOSYaJOEXnY8=;
        h=Subject:From:Date:To:From;
        b=03+LTFf9aIlQBsRSDFhSER68oQiPInFs+Bhqh5xLg5WWT+nCDLwkLF4PfnfRrQG8l
         +gckoejCOtmRxoOQzTddryLO1101+VEbjRQgnjybaXlL0rI8iPSzKEKlCBr0803gEm
         e02D1X9NPeQqKKOixGRE65qJaO57Wi0Dd8tBXshE=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159262441783.9050.18421931123817099431.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 20 Jun 2020 03:40:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Remove uninitialized_var() macro (2020-06-20T03:29:51)
  Superseding: [v1] Remove uninitialized_var() macro (2020-06-03T23:31:59):
    [01/10] x86/mm/numa: Remove uninitialized_var() usage
    [02/10] drbd: Remove uninitialized_var() usage
    [03/10] b43: Remove uninitialized_var() usage
    [04/10] rtlwifi: rtl8192cu: Remove uninitialized_var() usage
    [05/10] ide: Remove uninitialized_var() usage
    [06/10] clk: st: Remove uninitialized_var() usage
    [07/10] spi: davinci: Remove uninitialized_var() usage
    [08/10] checkpatch: Remove awareness of uninitialized_var() macro
    [09/10] treewide: Remove uninitialized_var() usage
    [10/10] compiler: Remove uninitialized_var() macro


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
