Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6E4C433EF
	for <linux-spi@archiver.kernel.org>; Wed, 13 Jul 2022 02:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiGMCrg (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 12 Jul 2022 22:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiGMCrg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Jul 2022 22:47:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD5DCC03C;
        Tue, 12 Jul 2022 19:47:35 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LjMRk0tbwzkWx4;
        Wed, 13 Jul 2022 10:45:22 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 10:47:33 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Jul
 2022 10:47:33 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <broonie@kernel.org>
Subject: [PATCH -next v2 0/3] spi: microchip-core: fix and cleanups
Date:   Wed, 13 Jul 2022 10:56:54 +0800
Message-ID: <20220713025657.3524506-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Patch #1 fix a UAF in mchp_corespi_remove().
Patch #2 and #3 some cleanups to simpify code.

v1 -> v2:
  add patch #3 to use dev_err_probe to simpify code.

Yang Yingliang (3):
  spi: microchip-core: fix UAF in mchp_corespi_remove()
  spi: microchip-core: switch to use devm_spi_alloc_master()
  spi: microchip-core: switch to use dev_err_probe()

 drivers/spi/spi-microchip-core.c | 56 ++++++++++++--------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

-- 
2.25.1

