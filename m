Return-Path: <SRS0=0Uex=EE=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE05C55178
	for <linux-spi@archiver.kernel.org>; Thu, 29 Oct 2020 08:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044A4206DC
	for <linux-spi@archiver.kernel.org>; Thu, 29 Oct 2020 08:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603961805;
	bh=piZtFOr8oOXYyBkr+BrpQz3RwT6DRPg8BlWtQhp48IA=;
	h=Subject:From:Date:To:List-ID:From;
	b=iLF0FC9Es5MB8KLhcm081/Sps5zRquSKFfsOkRbhNZL7miKLhskJRnYWIGiu/HaZn
	 Jt0coNprQYWtcTGT1WKtoEp7ui9Xcpa+pS3Iit81em+97XG9vgK6efDVu9IKQLwQYr
	 +6wXkmb7EwOchDb9Af5FvFATlGWB8UA4SCEBEUiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgJ2I4o (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 29 Oct 2020 04:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgJ2I4M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 29 Oct 2020 04:56:12 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603961771;
        bh=piZtFOr8oOXYyBkr+BrpQz3RwT6DRPg8BlWtQhp48IA=;
        h=Subject:From:Date:To:From;
        b=Rnx0qa2ey8609MFtLvpvhwPxZ3jPSn5maIls7VfJrcKWFqgTYU5bVlWG3ICtDUGY3
         mS+SRLn9qumkdUSHx8Z2nSjzM/YzYE2LtrF/wgieMPsAOupO2flMnOCcnfjXnPw7b0
         5o/1Eid/Fh1mMp1/44L8h4OVKA3GoJEpcIO2GRqk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160396177176.5874.16411980198627578314.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 29 Oct 2020 08:56:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-29T06:20:14)
  Superseding: [v4] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC (2020-10-27T08:22:45):
    [v4,1/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
    [v4,2/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
    [v4,3/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
    [v4,4/6] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
    [v4,5/6] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
    [v4,6/6] dt-bindings: spi: Add compatible for Intel LGM SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

