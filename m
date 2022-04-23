Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A4EC433EF
	for <linux-spi@archiver.kernel.org>; Sat, 23 Apr 2022 14:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiDWO7d (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sat, 23 Apr 2022 10:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDWO7c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 23 Apr 2022 10:59:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64FF7893A
        for <linux-spi@vger.kernel.org>; Sat, 23 Apr 2022 07:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0406FB80688
        for <linux-spi@vger.kernel.org>; Sat, 23 Apr 2022 14:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A66CEC385A5;
        Sat, 23 Apr 2022 14:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650725792;
        bh=zGlQ+zJEMKSECy147Pt5T1gpDRKNIF2e7QRQuTiO+hE=;
        h=Subject:From:Date:To:From;
        b=c4HjXEo28upWsHABiFco186tWduC/30Nw0H4nO3ZP2tq5X7dz2TQVsBnv67p6BPDS
         K6V2gA247tVMX/2sQjphZykeU0vo+nKxK7US4LUT4pURrXmkErkPUED085jTEIhh2i
         SX2+NTkCYMybFkjp8DbZj4c/fmVpDYJeZmHPKmw2q7kQzDbUrF3xFAeQTHSMJU/R/E
         EHgT+o7Pvi9YNWd02zb+7fkh0TyqXcXk77g8V6MqGQbIUc+gZi3B2tAZj4KAFdzPCh
         MFTGtdhaY4q5HvnppUK4lt+G/BZ8VPybSUJ/T4rP6nQ8f2VR/+3gkO5EDboMYz5cfU
         2CPbTookviabQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92398E7399D;
        Sat, 23 Apr 2022 14:56:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165072579259.6999.16819153359336296367.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 23 Apr 2022 14:56:32 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Improve SPI support for Ingenic SoCs. (2022-04-23T14:38:42)
  Superseding: [v2] Improve SPI support for Ingenic SoCs. (2022-04-22T19:09:42):
    [v2,1/3] SPI: Ingenic: Add support for use GPIO as chip select line.
    [v2,2/3] dt-bindings: SPI: Add bindings for new Ingenic SoCs.
    [v2,3/3] SPI: Ingenic: Add support for new Ingenic SoCs.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

