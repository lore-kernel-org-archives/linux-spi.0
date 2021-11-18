Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4C2C433EF
	for <linux-spi@archiver.kernel.org>; Thu, 18 Nov 2021 13:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A4E61A81
	for <linux-spi@archiver.kernel.org>; Thu, 18 Nov 2021 13:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhKROAI (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 18 Nov 2021 09:00:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231620AbhKROAH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Nov 2021 09:00:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D3D1961A81;
        Thu, 18 Nov 2021 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637243827;
        bh=NN8L/hYjCRuBMMDtFRJkPYsS8W+NvG+agS9jVUD//L0=;
        h=Subject:From:Date:To:From;
        b=Eq+Wn3rOFIM3tONdflYzEP4T6/IkSgI3onjdQE7AcL7iNykYujpRKPXJj0i6Ymxyw
         Ct1BQdON1JlCNx9NvIGAtHv6OKnFT9Th0BdIf4qvaWZgCwqDNe91YW+sjudOb7zWwI
         pFdyOHn6PAnJpJs2Yo/JSgynCk1IawwQvhQMHP2JOwk9a4tQu0RRYJ+SPd9peneWBq
         MxPly1jfSAO5m4yiotd7buVtKQHGtimaAMUDtZ4fi0XJkQNunTTQD6+KBCcFXGC3cq
         5y7R0AfpDXVy1I7Y/HdcKVm+LtjLwsd+3KkWgZI8yfF9x087/sEy9ehRllpYQGECaq
         /+vkpmf62R1KA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163724382772.11145.14451713830105503927.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 18 Nov 2021 13:57:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM (2021-11-18T13:05:41)
  Superseding: [v3] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM (2021-10-13T11:44:32):
    [v3,1/3] mtd: spi-nor: intel-spi: Disable write protection only if asked
    [v3,2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
    [v3,3/3] Documentation / MTD: Rename the intel-spi driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

