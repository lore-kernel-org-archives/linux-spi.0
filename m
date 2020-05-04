Return-Path: <SRS0=rKwf=6S=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E074CC47258
	for <linux-spi@archiver.kernel.org>; Mon,  4 May 2020 11:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE5A20721
	for <linux-spi@archiver.kernel.org>; Mon,  4 May 2020 11:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgEDLWO (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 4 May 2020 07:22:14 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:56907 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgEDLWN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 May 2020 07:22:13 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 25A24101303AB;
        Mon,  4 May 2020 13:12:12 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id C3CAB60F2900;
        Mon,  4 May 2020 13:12:11 +0200 (CEST)
X-Mailbox-Line: From a088b684ad292faf3bd036e51529e608e5c94638 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1588590210.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 4 May 2020 13:12:00 +0200
Subject: [PATCH 0/5] Grab bag with AMD SPI fixes
To:     Mark Brown <broonie@kernel.org>,
        "Sanjay R Mehta" <sanju.mehta@amd.com>
Cc:     linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Here's an assortment of drive-by fixes for the new AMD SPI driver.
All of them are compile-tested only.

Lukas Wunner (5):
  spi: amd: Fix duplicate iounmap in error path
  spi: amd: Pass probe errors back to driver core
  spi: amd: Drop duplicate driver data assignments
  spi: amd: Fix refcount underflow on remove
  spi: amd: Drop superfluous member from struct amd_spi

 drivers/spi/spi-amd.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

-- 
2.26.2

