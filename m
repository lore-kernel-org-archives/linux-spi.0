Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3FAC4361B
	for <linux-spi@archiver.kernel.org>; Thu, 17 Dec 2020 22:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6AD23A51
	for <linux-spi@archiver.kernel.org>; Thu, 17 Dec 2020 22:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgLQW5d (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 17 Dec 2020 17:57:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgLQW5d (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Dec 2020 17:57:33 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608245812;
        bh=SSMolY+TyAzyyWRXk1GAgXQbqauft7+y/ErJCV9bCnk=;
        h=Subject:From:Date:To:From;
        b=aOTbyHuqa1+xzU4wCKK4nsPjqRbKAHiZta0pooouCOy5TdnXmOmO8CShL+rCJdi3S
         4P0A9lLyK8AUVw1ifXfmPq4Ce+68CQHdQisxfMBnCvYmKjYKHMAzE8W2PMbjZMfGwZ
         Uthr0fFPvl0BkWBKi9TG9i34kBdimHOwXi/6kuqOGJ48PFeNMSABSq1qdjHo93aFKq
         luqtcVPlo8gRP8qQDSegZWNMr9mbaNyatlXL4sVZs1xlnd42UpOSzuTapTDl+xbXIg
         DQMTv2T45lLXdeP2k6II13gcY+uXTihiXDwleRXelRnHh9EInzAQETRLq7fux2hwmf
         RGzh0bXHLX8mA==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160824581263.24565.11073089217137452.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 17 Dec 2020 22:56:52 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case (2020-12-17T22:29:11)
  Superseding: [v2] spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case (2020-12-16T22:41:49):
    [v2,1/4] spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case
    [v2,2/4] spi: spi-geni-qcom: Fail new xfers if xfer/cancel/abort pending
    [v2,3/4] spi: spi-geni-qcom: Don't try to set CS if an xfer is pending
    [v2,4/4] spi: spi-geni-qcom: Print an error when we timeout setting the CS


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

