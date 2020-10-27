Return-Path: <SRS0=GM/z=EC=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46627C4363A
	for <linux-spi@archiver.kernel.org>; Tue, 27 Oct 2020 00:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1811E20754
	for <linux-spi@archiver.kernel.org>; Tue, 27 Oct 2020 00:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603757259;
	bh=x80otGod4B+9t4yirhHseO0i2CyuDa0PFWxDNjmAtuc=;
	h=Subject:From:Date:To:List-ID:From;
	b=Yzox1E9dbRdiSocEdEEaCkXmuySoIqqRXoEZTdE+0jwxPbDpndN/fpWAgH+b4gBnp
	 T6En740Fx77KsFB9FgDVy/8UA+4admNsFBBTkT0O9IjKwgBv8j7Ry+93dtfPXlrbgX
	 6JRH79hc7QFqZZfgJzK1lbWkkMdtg3TRQNcNr2r0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394787AbgJ0AHi (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438946AbgJ0AHh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Oct 2020 20:07:37 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603757256;
        bh=x80otGod4B+9t4yirhHseO0i2CyuDa0PFWxDNjmAtuc=;
        h=Subject:From:Date:To:From;
        b=dl+Xkt1h/MmCMemhj8tisUqkJM+rQRFYJ/Zgm1kUHrYKPNjw1Ns4S59knfdNb3+Iv
         YYigMnRqMlZzUzUlxPjkWNXxbx5Et/eM14Ub7Ji3OHk8JfWg74bkYBC65gGn9bZFFM
         +UYSK64vfeeqOIg74SRclKgNhGK07mILGAv+3xoo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160375725652.30701.15392453184756800725.git-patchwork-summary@kernel.org>
Date:   Tue, 27 Oct 2020 00:07:36 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v2] spi: spi-sun6i: enable autosuspend feature
  Submitter: Alexander Kochetkov <al.kochet@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=366799
  Lore link: https://lore.kernel.org/r/20201019150343.2520-1-akochetkov@lintech.ru
Patch: spi: atmel: remove unnecessary include
  Submitter: Alexandre Belloni <alexandre.belloni@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=357851
  Lore link: https://lore.kernel.org/r/20200930145353.3043699-1-alexandre.belloni@bootlin.com
Patch: char: ipmi: convert tasklets to use new tasklet_setup() API
  Submitter: Allen Pais <allen.cryptic@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=333475
  Lore link: https://lore.kernel.org/r/20200817091617.28119-3-allen.cryptic@gmail.com
Patch: [v2] serial: max310x: rework RX interrupt handling
  Submitter: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=358205
  Lore link: https://lore.kernel.org/r/20201001074415.349739-1-thomas.petazzoni@bootlin.com

Total patches: 4

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


