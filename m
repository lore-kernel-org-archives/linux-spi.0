Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575B9C433EF
	for <linux-spi@archiver.kernel.org>; Tue,  5 Jul 2022 14:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiGEODu (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 5 Jul 2022 10:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiGEODg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jul 2022 10:03:36 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34722A940;
        Tue,  5 Jul 2022 06:50:07 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 13EB02223E;
        Tue,  5 Jul 2022 15:50:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657029005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GB9HU/M2Mnn421s3orIG2Ic3eQJpqeuHzFfYbqGQ4Sw=;
        b=jqWm2euabGg75wqWBKK2DDHsz+WYLaebWUdzLXcIgT1kaJmaxy6YOX7zID2TnkI0lqcsJl
        p+sYlNnbYudAFO39mqugj8HREtra9oKXnrcvW+ClZgqysquP6Gygnfy4MA5swhzumzmKmN
        7etNfT9Ogav64i8NrW84cX97LOqKr24=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Jul 2022 15:50:03 +0200
From:   Michael Walle <michael@walle.cc>
To:     haibo.chen@nxp.com
Cc:     ashish.kumar@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        han.xu@nxp.com, singh.kuldeep87k@gmail.com,
        tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, zhengxunli@mxic.com.tw
Subject: Re: [PATCH 05/11] spi: spi-nxp-fspi: Add quirk to disable DTR support
In-Reply-To: <1657012303-6464-5-git-send-email-haibo.chen@nxp.com>
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
 <1657012303-6464-5-git-send-email-haibo.chen@nxp.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d1b27db8bb86762587bce829a4e39c56@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2022-07-05 11:11, schrieb haibo.chen@nxp.com:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Not all platform currently supports octal DTR mode. lx2160a do not
> implement DQS, this causes flash probe failure and therefore, provide
> an option of quirk FSPI_QUIRK_DISABLE_DTR for platforms not support
> DTR mode.

You write "DQS is not supported" but your quirk targets DTR. DTR works
without DQS. DQS is needed for faster frequencies, no? So the quirk
should be named accordingly.

Also, this compatible is (unfortunately!) also used on for the LS1028A
SoC and as far as I know DQS is supported there. I'm not sure what to
do here. Maybe add a new compatible "nxp,ls1028a-fspi" and change the
device tree to
compatible = "nxp,ls1028a-fspi", "nxp,lx2160a";

-michael
