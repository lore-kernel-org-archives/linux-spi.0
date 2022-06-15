Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC321C43334
	for <linux-spi@archiver.kernel.org>; Wed, 15 Jun 2022 18:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbiFOSKc (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 15 Jun 2022 14:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFOSKb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 14:10:31 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85A84B403;
        Wed, 15 Jun 2022 11:10:30 -0700 (PDT)
Received: from [127.0.0.1] (nyx.walle.cc [158.255.213.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 73E5B22249;
        Wed, 15 Jun 2022 20:10:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1655316627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TS3jYFS6YTAvU3pgkMvxRJI/YD6CxfyrTdrG5rg9tDU=;
        b=OlchZqjIeXpxF5LKa+OEpi2uZeC6CUN/XH0rxxwQ/x/J6nLbOgm5MbIm2Z9R9PJXpyqyWh
        ITd9PIHV0TBR+EcsaFzL0mjm/aMwRtzQ1p1ctjGfEYFVgvSbeoDaUZi2Gr+pYPueUu74xN
        GK5/IzzwgjecRTSUsCYOo2rolRVGf+4=
Date:   Wed, 15 Jun 2022 20:10:13 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Oleksandr Ocheretnyi -X (oocheret - GLOBALLOGIC INC at Cisco)" 
        <oocheret@cisco.com>
CC:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mauro.lima@eclypsium.com" <mauro.lima@eclypsium.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] mtd: spi-nor: handle unsupported FSR opcodes properly
User-Agent: K-9 Mail for Android
In-Reply-To: <YqmrIsOEsFoKTwEK@lahna>
References: <YmZUCIE/ND82BlNh@lahna> <20220610191548.3626218-1-oocheret@cisco.com> <YqbWt9f3of+7Z76e@lahna> <BYAPR11MB27570F2863F7BCDFE629B3DFCDAA9@BYAPR11MB2757.namprd11.prod.outlook.com> <YqmrIsOEsFoKTwEK@lahna>
Message-ID: <6A852B9E-D84C-4F80-9C17-62BFBB98CC8A@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 15=2E Juni 2022 11:49:22 OEZ schrieb Mika Westerberg <mika=2Ewesterberg@=
linux=2Eintel=2Ecom>:
>Hi,
>
>On Tue, Jun 14, 2022 at 05:56:54PM +0000, Oleksandr Ocheretnyi -X (oocher=
et - GLOBALLOGIC INC at Cisco) wrote:
>>    Hello Mika,
>>=20
>>    in my case (I work with memory chip n25q128a13 for recent kernels) I=
'm
>>    getting return value -ENOTSUPP from spi_mem_exec_op() call in the
>>    micron_st_nor_read_fsr() method
>>    [[1]https://elixir=2Ebootlin=2Ecom/linux/v5=2E19-rc2/source/drivers/=
spi/spi-m
>>    em=2Ec#L326]=2E So I decided to provide the same errorcode to
>>    intel_spi_hw_cycle() method because older kernel versions throw the
>>    error there=2E It is fine to use -EOPNOTSUPP return value instead=2E
>>=20
>>    I suspect we need to cover both cases to check -ENOTSUPP as well as
>>    -EOPNOTSUPP to let the driver work properly=2E
>>=20
>>    if (ret =3D=3D -ENOTSUPP || ret =3D=3D -EOPNOTSUPP)
>
>I think we should follow the same in the Intel driver and return
>-ENOTSUPP too=2E

AFAIK ENOTSUPP is for nfs and shouldn't be used=2E

-michael
