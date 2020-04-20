Return-Path: <SRS0=oqfe=6E=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2E9C3815B
	for <linux-spi@archiver.kernel.org>; Mon, 20 Apr 2020 19:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D137720736
	for <linux-spi@archiver.kernel.org>; Mon, 20 Apr 2020 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587410417;
	bh=Erk10aFqeLiTLOOC0E+ba8RAcwzSD/3Wqt1/SH/rDdo=;
	h=Subject:From:Date:To:List-ID:From;
	b=P5vEBYdZXTVU2daa6RiBeUDt/1ZDnu5qAFhT6/ik6jD/8C3OS+Ado2QzdHgcHEBXM
	 4ByIueL68NcYfzzBo2MdD0SCDDSITriZTowSSVqtqoqP9M8DEfThoTJvh/BQf+ulUg
	 vn1gbO1rN4aLRnIKbKJm0JBGl2kUhHVDM/K7sCLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgDTTUR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgDTTUQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Apr 2020 15:20:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587410416;
        bh=Erk10aFqeLiTLOOC0E+ba8RAcwzSD/3Wqt1/SH/rDdo=;
        h=Subject:From:Date:To:From;
        b=e57AnHOBh9GIuZVyP6CI7SkyjPqolnIhRXp8aDsTyQQ71jMOi3nUIvqqi0VdaaJqE
         HGWSHxKuVt1WfRuSS0Lp06YuQYMRpNxe5X1llUPMIw6Gy8nJnGiVh0BaOEJLYNNwgk
         13vJAYkV09pRpIOpvyvh7L8o4YjxN/KNqbXoTfv8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158741041630.1165.5127497112869386841.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 20 Apr 2020 19:20:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: bcm-qspi: Handle clock probe deferral (2020-04-20T19:08:45)
  Superseding: [v2] spi: bcm-qspi: Handle clock probe deferral (2020-04-19T19:23:30):
    [v2,1/9] spi: bcm-qspi: Handle clock probe deferral
    [v2,2/9] dt: bindings: spi: Add support for mspi on brcmstb SoCs
    [v2,3/9] spi: bcm-qspi: Handle lack of MSPI_REV offset
    [v2,4/9] spi: bcm-qspi: Drive MSPI peripheral SSb pin on cs_change
    [v2,5/9] spi: bcm-qspi: when tx/rx buffer is NULL set to 0
    [v2,6/9] spi: bcm-qspi: Make PM suspend/resume work with SCMI clock management
    [v2,7/9] spi: bcm-qspi: Use fastbr setting to allow faster MSPI speeds
    [v2,8/9] spi: bcm-qspi: add support for MSPI sys clk 108Mhz
    [v2,9/9] spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists only on legacy controllers


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
