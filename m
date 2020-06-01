Return-Path: <SRS0=RtOV=7O=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E813DC433DF
	for <linux-spi@archiver.kernel.org>; Mon,  1 Jun 2020 06:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E982068D
	for <linux-spi@archiver.kernel.org>; Mon,  1 Jun 2020 06:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590991217;
	bh=mOgwEfZUWXLXjSQgdo+EwcwmO2r3BUgRMSeiqRv2kCs=;
	h=Subject:From:Date:To:List-ID:From;
	b=2moivhQf/4rJzp/iA+CgNtuHCEmYt75VLZ5i8F7Ddy+tRLsaQNCcDg8OKU72coaxB
	 6Den55OA4YynnlsslZ2AIY1aQAG8zI7Rtab6/2mt8niICFS6i8QMxFcNT23jiMB7YU
	 Tqtt2R9jtegywGKSmU5HrDjUcbS+hSvDOBu0ILYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgFAGAR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgFAGAR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Jun 2020 02:00:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590991217;
        bh=mOgwEfZUWXLXjSQgdo+EwcwmO2r3BUgRMSeiqRv2kCs=;
        h=Subject:From:Date:To:From;
        b=j2piRxoPRpBh1rBbD1Tb9VYE4/1VGvz6PER/v1Qf3XMdh7UqEf58GSkZuEVDs1rNn
         kFOUgqmaz7eovBdGqzrX4Ggx0SPEyqVjN+9Fag6b1/iUs/syTjGOXLGSHgGxo95GMD
         dorASLYthITCh3ZH5ZLGmaemyvqD6wXn/MOK3iMA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159099121705.15428.6364728039360833352.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 01 Jun 2020 06:00:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] mtd: spi-nor: Move cadence-qaudspi to spi-mem framework (2020-06-01T05:47:17)
  Superseding: [v2] mtd: spi-nor: Move cadence-qaudspi to spi-mem framework (2020-05-26T09:35:58):
    [v2,1/6] mtd: spi-nor: cadence-quadspi: Make driver independent of flash geometry
    [v2,2/6] mtd: spi-nor: cadence-quadspi: Provide a way to disable DAC mode
    [v2,3/6] mtd: spi-nor: cadence-quadspi: Don't initialize rx_dma_complete on failure
    [v2,4/6] mtd: spi-nor: cadence-quadspi: Fix error path on failure to acquire reset lines
    [v2,5/6] mtd: spi-nor: Convert cadence-quadspi to use spi-mem framework
    [v2,6/6] spi: Move cadence-quadspi driver to drivers/spi/


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
