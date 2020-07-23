Return-Path: <SRS0=qRKA=BC=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4168FC433DF
	for <linux-spi@archiver.kernel.org>; Thu, 23 Jul 2020 01:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDD2204EA
	for <linux-spi@archiver.kernel.org>; Thu, 23 Jul 2020 01:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595466020;
	bh=9bmCwnddyC3BQExaGAJRrYWFQos7oDMKTjXgLa2jpw4=;
	h=Subject:From:Date:To:List-ID:From;
	b=ZFLy2VXUsRFmHuFQKahhCiuf+OiqB4MXQpVIiL20TIXTLngMEqACHbNd3ixzDkOlG
	 pohI/et3GwXqXyLtoUkR56vFX8DS5Yuj93MeApDHwnDNr49UdDl5BBX5+SB1GpanUf
	 hHCI/Y2x5meKwJyX8xV9gAlDAil08gu/xuFAjcDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgGWBAT (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbgGWBAT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jul 2020 21:00:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595466019;
        bh=9bmCwnddyC3BQExaGAJRrYWFQos7oDMKTjXgLa2jpw4=;
        h=Subject:From:Date:To:From;
        b=JZdkDAr8OoLtqVBpxQn+1sS24+bIqyOIp2ibaGKaSQqv1G30zfIgM1L76cbESD0JI
         csa9FotKU28WmtIXP76z65l4rJcq2Fny7IC8amFtdJ5nKfDLLoknfZF5V4ciYpj7mi
         K8Ts6a+r8VJQ4+ztv6ND2lbtiPqLsGqjyF7BzqVE=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159546601929.19640.16589000639023511075.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 23 Jul 2020 01:00:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: rockchip: Config spi rx dma burst size depend on xfer length (2020-07-23T00:43:54)
  Superseding: [v2] spi: rockchip: Config spi rx dma burst size depend on xfer length (2020-07-22T08:37:37):
    [v2,1/3] spi: rockchip: Config spi rx dma burst size depend on xfer length
    [v2,2/3] spi: rockchip: Support 64-location deep FIFOs
    [v2,3/3] spi: rockchip: Fix error in SPI slave pio read


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
