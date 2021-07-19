Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08896C07E95
	for <linux-spi@archiver.kernel.org>; Mon, 19 Jul 2021 14:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F59610D2
	for <linux-spi@archiver.kernel.org>; Mon, 19 Jul 2021 14:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhGSNtt (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 19 Jul 2021 09:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231618AbhGSNtt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Jul 2021 09:49:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DC5BD610D0;
        Mon, 19 Jul 2021 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626705028;
        bh=kLLV0WoOHyNxoZR1SXZAXslQH285+E/1Q2zJUgvk9hU=;
        h=Subject:From:Date:To:From;
        b=omTHfOfnbpnEr/I32OxYsTkVt9KMzbkdTrJQHJxaLAUmf0PcaH38J6sZrw2sEbyxF
         WcvODuUJv39zhxZVg1ucT3DaGXT81BG5r69LbBNzP4DwpCRFCUy/52J8RrRVJNn0Ym
         nsdj6SrhJdDdWBnEEX5BlbqSOMfyAf5MqIl1TR+QEATPSZ76pamEqmuyNNzvq8BhOR
         C7VOW5Pw/vfono2napk45auiCjq4z5M8vHRjBtusqDy/SsrYZE0oaFrAOXPl+TuyZm
         +XA0bH9svqHjDaCa1pu6Rp3IClY6W5rjERmvjAsS0cjcHQdGPy5Ro8SLb13qIHY/dk
         +41zun7XCkkLQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162670502877.24361.8133395587909594161.git-patchwork-summary@kernel.org>
Date:   Mon, 19 Jul 2021 14:30:28 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: dt-bindings: Move fixed string 'patternProperties' to 'properties'
  Submitter: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=514971
  Lore link: https://lore.kernel.org/r/20210713193514.690894-1-robh@kernel.org

Total patches: 1

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


