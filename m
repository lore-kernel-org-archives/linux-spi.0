Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F09C56202
	for <linux-spi@archiver.kernel.org>; Thu, 26 Nov 2020 02:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB7021734
	for <linux-spi@archiver.kernel.org>; Thu, 26 Nov 2020 02:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOe+T5Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbgKZC4e (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 25 Nov 2020 21:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729788AbgKZC4e (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Nov 2020 21:56:34 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606359394;
        bh=xCt13epLoeFvXFgygQBAUAlXGREgizikwIl/VXJU9UU=;
        h=Subject:From:Date:To:From;
        b=tOe+T5UoX5Jo/bJKdPpkQjeamIYTX/EZKUpp5tk1euwJGZPbctI5VwAqcp6h+Y36y
         9PjvKdi8C8FQHB8mz7Fp4Yq9BB91FUEF/M99n6E7zenjlyAzfgkhwAzYUslb6NekH4
         x/7OMhutkGqFzGCF76CyLfzpkeV7Ep7rsMK55IVE=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160635939380.21512.7966954886356400983.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 26 Nov 2020 02:56:33 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] DW apb_ssi V4 support for Kendryte K210 RISC-V SoC (2020-11-26T02:00:46)
  Superseding: [v1] DW apb_ssi V4 support for Kendryte K210 RISC-V SoC (2020-11-19T12:02:50):
    [1/3] spi: dw: Add support for 32-bits max xfer size
    [2/3] spi: dw: Add support for the Canaan K210 SoC SPI
    [3/3] dt-bindings: Update Synopsis DW apb ssi bindings


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

