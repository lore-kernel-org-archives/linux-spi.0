Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B43BC433EF
	for <linux-spi@archiver.kernel.org>; Mon, 21 Feb 2022 07:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344822AbiBUHpA (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 21 Feb 2022 02:45:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344588AbiBUHpA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 02:45:00 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979FB2196;
        Sun, 20 Feb 2022 23:44:37 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BA42C2223A;
        Mon, 21 Feb 2022 08:44:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645429475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYxJg6RXHwuQQPHgm7btkpehETiBp1YmrUpCpg1PZHg=;
        b=SmDq0SK53YoVS9qM7butDx4U4t9guXFj6hquSPFA6/Q7Cd9xxqpQT8lxQcQhwMawAvCoKO
        yB4iq/kf6bsLDi1j/XEvL1wtdzpM/ajbmDRu37+xBVtrar6+9P93R/JXKT/JCDRAwXSNz6
        1oEpPYgWdDnKfVwT4qgTtvZbNDybl7E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Feb 2022 08:44:35 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, broonie@kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        nicolas.ferre@microchip.com, zhengxunli@mxic.com.tw,
        jaimeliao@mxic.com.tw
Subject: Re: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
In-Reply-To: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <44f655d027b49b87065915f6ba2744d2@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2022-02-18 15:58, schrieb Tudor Ambarus:
> Fortunately there are controllers
> that can swap back the bytes at runtime, fixing the endiannesses. 
> Provide
> a way for the upper layers to specify the byte order in DTR mode.

Are there any patches for the atmel-quadspi yet? What happens if
the controller doesn't support it? Will there be a software fallback?

-michael
