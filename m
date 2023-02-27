Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C02C64ED8
	for <linux-spi@archiver.kernel.org>; Mon, 27 Feb 2023 12:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjB0M40 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 27 Feb 2023 07:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjB0M40 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Feb 2023 07:56:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EE21CF5F
        for <linux-spi@vger.kernel.org>; Mon, 27 Feb 2023 04:56:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35899B80C98
        for <linux-spi@vger.kernel.org>; Mon, 27 Feb 2023 12:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D82A5C4339B;
        Mon, 27 Feb 2023 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677502581;
        bh=EHbAOp+BMqf1U4wl7ZWko6fRbHHVTPvuHTvUJUL7Zcs=;
        h=Subject:From:Date:To:From;
        b=tNFnjNw30LfkSQsVXNxyqvB3awNJh8+i67ucICEexqTwggm5Kg5It7GglQ/++ex6c
         5SSSg8NVBWY2+LXBuu8iTZTz23IYdCafGt3xrbor1A8JqDdftccQtC8kyaLMloYCcW
         IqgzqtLsSlOKymQdUoRJbXxLr7xTBYtDhMr67t4YAamJNVvqJcF7MS43HDd+iBZpMK
         Bn9kg3gLyqTP5ccAud+t8p06j9oWUkDd2OzAzi124vGm8NpSRLqwSIbFSNWSLECS84
         NGxBAUZOmFh6T38wfhNzBTN62giXVvGjxG57pX3RoA+LrjvdsyTqliKd3l6pkyNCEG
         or7Yce485W0Sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7195E68D2D;
        Mon, 27 Feb 2023 12:56:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167750258164.3306.1095726946156136631.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 27 Feb 2023 12:56:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Tegra TPM driver with HW flow control (2023-02-27T12:06:59)
  Superseding: [v4] Tegra TPM driver with HW flow control (2023-02-24T15:49:38):
    [V4,1/3] spi: Add TPM HW flow flag
    [V4,2/3] tpm_tis-spi: Support hardware wait polling
    [V4,3/3] spi: tegra210-quad: set half duplex flag


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

