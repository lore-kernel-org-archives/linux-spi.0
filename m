Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0461DC77B7F
	for <linux-spi@archiver.kernel.org>; Mon,  8 May 2023 21:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjEHV4t (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 8 May 2023 17:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbjEHV4n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 May 2023 17:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E63524B
        for <linux-spi@vger.kernel.org>; Mon,  8 May 2023 14:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAED164323
        for <linux-spi@vger.kernel.org>; Mon,  8 May 2023 21:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5906CC433D2;
        Mon,  8 May 2023 21:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683582999;
        bh=hDaRzQGKWDSDPkODNiBdiP1YiTReyQBUVFbpk7rxeps=;
        h=Subject:From:Date:To:From;
        b=q0N2u0rhSkIa/s2NeCJvcFvdVan86Ni7taxtAFIn4P1zwUFSFw1v6BWY90sWQEzok
         52EJtm66589Hty3wp9sVL8sR2IOnRX7Wo/7KmrdAw/MsYxhcL7R9ECoLEtwNxEb3Az
         Ba+81Awr36f/U0xEk40Wo621LX9x4cOEJCAMBiXsHyBPdKtxFweGdz12HoSLpHZ3oG
         QvDrTCxezGeuu6nut3QMb+ItJTAKKxdbY/iNuOIsx4NVOyT2SV1znfG6q/jczlIL9W
         O99nKlk9gDnveYHNaWMb8D/bEH/S/dC4+uDXbgE3tjut8L9mGVkKVJCNm/7ZUJ5w6a
         /uMlgJC4+Ol/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E33BE26D26;
        Mon,  8 May 2023 21:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168358299925.4639.12257351570699372783.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 08 May 2023 21:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Fix up Nokia 770 regression (2023-05-08T21:20:05)
  Superseding: [v3] Fix up Nokia 770 regression (2023-05-05T11:16:54):
    [v3,1/3] Input: ads7846 - Convert to use software nodes
    [v3,2/3] ARM/mmc: Convert old mmci-omap to GPIO descriptors
    [v3,3/3] ARM: omap1: Fix up the Nokia 770 board device IRQs


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

