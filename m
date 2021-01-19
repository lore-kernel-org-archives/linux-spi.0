Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EE2C433E0
	for <linux-spi@archiver.kernel.org>; Tue, 19 Jan 2021 19:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B806623119
	for <linux-spi@archiver.kernel.org>; Tue, 19 Jan 2021 19:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbhASTcQ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:32:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729697AbhAST22 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 19 Jan 2021 14:28:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 325AB23108;
        Tue, 19 Jan 2021 19:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611084419;
        bh=cPbYJyCp0Iqhq7t/wHgOEWiS3axPO+F6SuASgAoZPkw=;
        h=Subject:From:Date:To:From;
        b=moSbMMI+75tqUF2aSklqLttiDCh+9ci0JXi/UlFfB9ZsvOLgWk8IGc1TFdV3lEowj
         OcMciuNFJSiFtAXHcOifxutasXHO40/LPsoFCM0gQ+ujVxpp91J/B0q6aIqKmme+7l
         crzZ3Iz4ZE1IcNcZHBIDwH0EKlezLDhcBUsJIREOlIdgRILzUDvdMl8/ch1tOoHvi2
         hUJv0l0aZmkEXknykP3vcKRUN+fBicF7fxCmnhHUDFdnJhgNcoBxb5VWgyWw7zuN7S
         T3z9/OugklFYFWL8SvmHpr1f8tO5ikcxCpu6cyKGkwovU2JYWOJD3EneLRvWYWGb4q
         Etzq9nnJbZBTg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161108410944.20781.12982923268219685389.git-patchwork-summary@kernel.org>
Date:   Tue, 19 Jan 2021 19:21:49 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: spi: imx: Don't print error on -EPROBEDEFER
  Submitter: Guido Günther <agx@sigxcpu.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=416929
  Lore link: https://lore.kernel.org/r/0f51ab42e7c7a3452f2f8652794d81584303ea0d.1610987414.git.agx@sigxcpu.org

Total patches: 1

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


