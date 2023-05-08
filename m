Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADC4C77B75
	for <linux-spi@archiver.kernel.org>; Mon,  8 May 2023 09:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjEHJro convert rfc822-to-8bit (ORCPT
        <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 8 May 2023 05:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjEHJrm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 May 2023 05:47:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C7813875
        for <linux-spi@vger.kernel.org>; Mon,  8 May 2023 02:47:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-133-aC6YXYG9OjSIkw3kXPonVg-1; Mon, 08 May 2023 10:47:38 +0100
X-MC-Unique: aC6YXYG9OjSIkw3kXPonVg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 8 May
 2023 10:47:37 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 8 May 2023 10:47:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Maksim Kiselev' <bigunclemax@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>
CC:     Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Maxime Ripard <mripard@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v3 2/5] spi: sun6i: change OF match data to a struct
Thread-Topic: [PATCH v3 2/5] spi: sun6i: change OF match data to a struct
Thread-Index: AQHZgHJVw1wL+axJhkKYU1TQITl02K9QIrDQ
Date:   Mon, 8 May 2023 09:47:36 +0000
Message-ID: <702d085b3b814759a344886364c518f8@AcuMS.aculab.com>
References: <20230506232616.1792109-1-bigunclemax@gmail.com>
 <20230506232616.1792109-3-bigunclemax@gmail.com>
In-Reply-To: <20230506232616.1792109-3-bigunclemax@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Maksim Kiselev
> Sent: 07 May 2023 00:26
> 
> As we're adding more properties to the OF match data, convert it to a
> struct now.
> 
...
> -	sspi->fifo_depth = (unsigned long)of_device_get_match_data(&pdev->dev);
> +	sspi->cfg = of_device_get_match_data(&pdev->dev);

Is it worth doing a structure copy at this point?
The 'cfg' data is short and constant and it would make
the code that uses it smaller and faster.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

