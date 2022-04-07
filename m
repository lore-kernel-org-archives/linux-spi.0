Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD27FC433F5
	for <linux-spi@archiver.kernel.org>; Thu,  7 Apr 2022 11:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238256AbiDGLnZ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 7 Apr 2022 07:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbiDGLnV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 07:43:21 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB526DA6F9;
        Thu,  7 Apr 2022 04:41:21 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4D00122175;
        Thu,  7 Apr 2022 13:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649331680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anZIlz+C7nCyO9qv7nTAB94XjsPcbeyf8vLkyCHxpOY=;
        b=FzQxRClq9Dt7zR4qrq5+7nAYwxA8epciMbhR6QgAhAdcsB9VSFnDpXL0e/m2n72UKgQEXa
        G9f58KhmGMSjHPs1PhKiaYTQeK47TBV3TWKbYtCaSDjp0MUKZFHKuKVZKF986gCWJWycta
        UUYQeIoTzSwVSja4hsS1NTI4P4EqLCg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Apr 2022 13:41:20 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     Manohar.Puri@microchip.com, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        devicetree@vger.kernel.org, kavyasree.kotagiri@microchip.com,
        krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org,
        tudor.ambarus@microchip.com
Subject: Re: [PATCH] spi: atmel,quadspi: Define lan966x QSPI
In-Reply-To: <Yk7LjrvqSLbzPYkw@sirena.org.uk>
References: <Yk7Ex5ltaxC7Z+N6@sirena.org.uk>
 <20220407112345.148316-1-michael@walle.cc> <Yk7LjrvqSLbzPYkw@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <561bbc1cf43c3795eee67e10537ba365@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2022-04-07 13:31, schrieb Mark Brown:
> On Thu, Apr 07, 2022 at 01:23:45PM +0200, Michael Walle wrote:
>> The subject should also be prefixed with "dt-bindings: ".
> 
> I tend to complain about people doing that.

After all it is mentioned to use that prefix in
Documentation/devicetree/bindings/submitting-patches.rst. I try to
remember when submitting SPI related bindings.

-michael
