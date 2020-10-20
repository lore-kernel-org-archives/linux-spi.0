Return-Path: <SRS0=mmrP=D3=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC85C433E7
	for <linux-spi@archiver.kernel.org>; Tue, 20 Oct 2020 02:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EACC222E9
	for <linux-spi@archiver.kernel.org>; Tue, 20 Oct 2020 02:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603162573;
	bh=m2tCzGxRXGL/ngiZKr4EFbpQ1PAMBG5/+T0K/PsBr4c=;
	h=Subject:From:Date:To:List-ID:From;
	b=E5OM+bMLU6Yw8wwyM8YMpA3mX+1fk0m/DorGpOt5vIunTW015jNlF38VuB1P6pvtc
	 JHpHLqJG/6WkbDoqks2wZa+5p/PgfYPWtCSxwZW3GrbnIprcBPYG+nlj/0e/4/O8WF
	 GKmnDfvqmsbL2xQRt/gCBfXaFeRgYuPPeBqXztAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390906AbgJTC4N (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 19 Oct 2020 22:56:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbgJTC4M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Oct 2020 22:56:12 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603162571;
        bh=m2tCzGxRXGL/ngiZKr4EFbpQ1PAMBG5/+T0K/PsBr4c=;
        h=Subject:From:Date:To:From;
        b=2C7IZOu3D6n5/YlX1dDZfcGQp8lHBEzBDsOdM+AYnm5ovY0nvAJkzEt8fC8ZCsoUt
         ihZoSHlG5slgGWFN07Ps8avJ2fnLlQfVJsBWn7T1spHJw9FFN/WfdIJOAKumKx5E+7
         zHxiE6CaxJGViZNpUhi+tiKpP1z063nUMdfprSdc=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160316257097.7697.604932348980443087.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 20 Oct 2020 02:56:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-20T02:32:20)
  Superseding: [v1] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-16T09:31:33):
    [v1,1/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
    [v1,2/6] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
    [v1,3/6] dt-bindings: spi: Add compatible for Intel LGM SoC
    [v1,4/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
    [v1,5/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
    [v1,6/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

