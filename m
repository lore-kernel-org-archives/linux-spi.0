Return-Path: <SRS0=Gs/y=7W=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9A6C433DF
	for <linux-spi@archiver.kernel.org>; Tue,  9 Jun 2020 06:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21DA20812
	for <linux-spi@archiver.kernel.org>; Tue,  9 Jun 2020 06:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591682419;
	bh=G5DipP6abBNbcRx5Alabrkoo5C348FjCdHg+db2ExDU=;
	h=Subject:From:Date:To:List-ID:From;
	b=gQ1nkrtluQwyoN5tPApK06hKyAPIrsEKPygiVv9TlEDPVaqXsjCmQn3ypL/R8FV3Q
	 dTyTAowW7txnx/MxhjtAGEbm2mzJKB6diJSkOMtZGL/JWxKXPPFOQmXhcnr/1h4UvD
	 R2hhsXROe9bxSoip45YiXukwUjUqvZRQvy4vDQVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgFIGAT (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 9 Jun 2020 02:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbgFIGAT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Jun 2020 02:00:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591682418;
        bh=G5DipP6abBNbcRx5Alabrkoo5C348FjCdHg+db2ExDU=;
        h=Subject:From:Date:To:From;
        b=txHiOBO1sjaQez9v2R3xa1ZKp44/dS+kFZma7aUjH978CbYft/ylK5oDsQqsZpVGq
         CIts4V9Cw91LlC+HJsLvg3ofgoFSr2MEk6IGEYQC+JFR6B+jDOWzgvnxXFr9HBNCGN
         xZUNeDad3IHS3tUHvoRsxIvPCYromofKdJbg6ZPA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159168241883.27435.8573212731362396643.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 09 Jun 2020 06:00:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] Add interconnect support to QSPI and QUP drivers (2020-06-09T05:56:28)
  Superseding: [v7] Add interconnect support to QSPI and QUP drivers (2020-05-26T12:54:43):
    [V7,1/7] soc: qcom: geni: Support for ICC voting
    [V7,2/7] soc: qcom-geni-se: Add interconnect support to fix earlycon crash
    [V7,3/7] i2c: i2c-qcom-geni: Add interconnect support
    [V7,4/7] spi: spi-geni-qcom: Add interconnect support
    [V7,5/7] tty: serial: qcom_geni_serial: Add interconnect support
    [V7,6/7] spi: spi-qcom-qspi: Add interconnect support
    [V7,7/7] arm64: dts: sc7180: Add interconnect for QUP and QSPI


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
