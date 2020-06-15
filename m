Return-Path: <SRS0=lX55=74=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219D4C433DF
	for <linux-spi@archiver.kernel.org>; Mon, 15 Jun 2020 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7A72078A
	for <linux-spi@archiver.kernel.org>; Mon, 15 Jun 2020 15:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592234959;
	bh=vWgmjo8pVb+oX3nyTTRgsBVtCBueK29qm9dJ7VSpq0Q=;
	h=Subject:From:Date:To:List-ID:From;
	b=XWFFvHwCo+xAWv54S05kw+WiMHooAckeCp0QVF1GePL/CY1nTSOVX3wq3FDA8b8n8
	 717IbaAQEdBPl7DfTHN1bY/LMQcFgeDEhpS5dM9ESJdywxV1kFhd83hbP4UsKuUEfQ
	 hKM0Gby+ALiLigMTWTRjqURkZvYJJ4i6+9jZNDoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgFOP3S (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbgFOP3S (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 11:29:18 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592234958;
        bh=vWgmjo8pVb+oX3nyTTRgsBVtCBueK29qm9dJ7VSpq0Q=;
        h=Subject:From:Date:To:From;
        b=ctz53UDDjJMywI5LXcpT5VeoEMJm0fIPDs1T9EK5UF1fDZiv4VcfJbkOefkFiU/HH
         32dIp9rGYAa0ZQY/Hc5ot0v9KUK6ljWlaaTsfMpXQjlMENtfkqiX2d1ETMbhaOS2w7
         iHPJmYAjQDE1FUUSPwSqK1wJxxcFznJ3zWpBC3EA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159223495812.18332.4467560361390425250.git-patchwork-summary@kernel.org>
Date:   Mon, 15 Jun 2020 15:29:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: [1/5] spi: dt-bindings: sifive: Add missing 2nd register region
  Submitter: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=286695
  Link: <20200512204543.22090-1-robh@kernel.org>
    Patches: [1/5] spi: dt-bindings: sifive: Add missing 2nd register region
             [2/5] dt-bindings: usb: ehci: Add missing 2nd register region
             [3/5] dt-bindings: ufs: ti: Fix address properties handling
             [4/5] dt-bindings: ufs: ti: Add missing 'additionalProperties: false'
             [5/5] dt-bindings: Fix incorrect 'reg' property sizes

Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
