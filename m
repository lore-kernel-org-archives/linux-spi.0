Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CCCC7EE2D
	for <linux-spi@archiver.kernel.org>; Fri, 12 May 2023 10:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbjELK4v (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 12 May 2023 06:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbjELK4t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 May 2023 06:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F2B26B7
        for <linux-spi@vger.kernel.org>; Fri, 12 May 2023 03:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C93865559
        for <linux-spi@vger.kernel.org>; Fri, 12 May 2023 10:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6850C433D2;
        Fri, 12 May 2023 10:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683889007;
        bh=Bdy4v1SSBFxMsdJTiMvbjZvUeh9Tomtxfq1XF3jIs/M=;
        h=Subject:From:Date:To:From;
        b=InlFQ3U/oGh3z0KmEZwtORQBu8MlmvuWmJ1FYaOFmd5vsKANRmGMvtTt5liGjrTp2
         grquZunYgpNvRo8HLPtX4WmYAJcyTjyoI6cEiOouiNUJDI7MKegjfExLdbu5OhZXQW
         0TS15wR72tD1uArhPt2hDUnEsCT8UZTKHuZ6nm3rmViBRUIqf+HovXrCbVkSCOIHHk
         Ev2Y4vZUwYNYYStHRMkzOZjloB1KqkfhIzb4Fa/GyoZlL6UvRDUFLlySo5/QccvnM/
         x66b9dTUPsn7U0JnrPHo4Mmz/BbQjvpDFj5c5gMQuFmt4Dcpqi91NSu+YozePVRtSS
         RDGQS21xhNmAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E6E7E26D2A;
        Fri, 12 May 2023 10:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168388900758.26432.9559735271935769890.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 12 May 2023 10:56:47 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v11] spi: dw: DW SPI DMA Driver updates (2023-05-12T10:47:42)
  Superseding: [v10] spi: dw: DW SPI DMA Driver updates (2023-05-09T08:22:39):
    [v10,1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
    [v10,2/5] spi: dw: Move dw_spi_can_dma()
    [v10,3/5] spi: dw: Add DMA directional capability check
    [v10,4/5] spi: dw: Add DMA address widths capability check
    [v10,5/5] spi: dw: Round of n_bytes to power of 2


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

