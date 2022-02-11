Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFA0C433EF
	for <linux-spi@archiver.kernel.org>; Fri, 11 Feb 2022 03:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiBKDtm (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 10 Feb 2022 22:49:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbiBKDtm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Feb 2022 22:49:42 -0500
X-Greylist: delayed 354 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 19:49:41 PST
Received: from mail-m17664.qiye.163.com (mail-m17664.qiye.163.com [59.111.176.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5853126DF;
        Thu, 10 Feb 2022 19:49:41 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m17664.qiye.163.com (Hmail) with ESMTPA id 7C90114019A;
        Fri, 11 Feb 2022 11:49:39 +0800 (CST)
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [RFC PATCH v1 0/6] New support and problem adjustment of SPI rockchip
Date:   Fri, 11 Feb 2022 11:49:32 +0800
Message-Id: <20220211034938.25097-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRlCT01WSBpPSElCH05JGE
        0YVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K1E6NAw4GD5CFh4XTUk*DkIN
        LkwKCQ9VSlVKTU9PTk5KSExCQkhPVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFKT09MNwY+
X-HM-Tid: 0a7ee6e69ad2da2fkuws7c90114019a
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org




Jon Lin (5):
  spi: rockchip: Stop spi slave dma receiver when cs inactive
  spi: rockchip: Preset cs-high and clk polarity in setup progress
  spi: rockchip: Fix error in getting num-cs property
  spi: rockchip: terminate dma transmission when slave abort
  spi: rockchip: clear interrupt status in error handler

shengfei Xu (1):
  spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM
    ops

 drivers/spi/spi-rockchip.c | 133 ++++++++++++++++++++++++++++++++-----
 1 file changed, 116 insertions(+), 17 deletions(-)

-- 
2.17.1

