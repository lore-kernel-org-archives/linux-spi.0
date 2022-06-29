Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4F5CCA47E
	for <linux-spi@archiver.kernel.org>; Wed, 29 Jun 2022 10:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiF2K60 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 29 Jun 2022 06:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiF2K60 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 06:58:26 -0400
X-Greylist: delayed 2054 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 03:58:25 PDT
Received: from 3.mo582.mail-out.ovh.net (3.mo582.mail-out.ovh.net [178.33.253.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37BD201AF
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 03:58:25 -0700 (PDT)
Received: from player726.ha.ovh.net (unknown [10.108.20.237])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id B04A621839
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 10:53:10 +0000 (UTC)
Received: from etezian.org (bbcs-175-223.cust.wingo.ch [178.238.175.223])
        (Authenticated sender: andi@etezian.org)
        by player726.ha.ovh.net (Postfix) with ESMTPSA id 75AAB2C0B1986;
        Wed, 29 Jun 2022 10:52:59 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-102R0045efd7eed-898b-4996-991a-c2895d67db7d,
                    27473AD2557E96BAE247B01472F11916F8881100) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.238.175.223
Date:   Wed, 29 Jun 2022 13:52:47 +0300
From:   Andi Shyti <andi@etezian.org>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] spi: s3c64xx: support custom value of internal
 clock divider
Message-ID: <Yrwu/4W65MU3VoJx@jack.zhora.eu>
References: <20220629102304.65712-1-chanho61.park@samsung.com>
 <CGME20220629102527epcas2p42e99f44d529d215623bd0e12a082d1dd@epcas2p4.samsung.com>
 <20220629102304.65712-3-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629102304.65712-3-chanho61.park@samsung.com>
X-Ovh-Tracer-Id: 3392899369641970200
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudegledgfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughisegvthgviihirghnrdhorhhgqeenucggtffrrghtthgvrhhnpeejgfelgeekieffjeegveeuvdehgeelveetveejudffvedvleehvdefleehudelueenucfkpheptddrtddrtddrtddpudejkedrvdefkedrudejhedrvddvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjedviedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedv
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chanho,

On Wed, Jun 29, 2022 at 07:23:02PM +0900, Chanho Park wrote:
> Modern exynos SoCs such as Exynos Auto v9 have different internal clock
> divider, for example "4". To support this internal value, this adds
> clk_div of the s3c64xx_spi_port_config and assign "2" as the default
> value to existing s3c64xx_spi_port_config.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
