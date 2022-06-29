Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EA0C43334
	for <linux-spi@archiver.kernel.org>; Wed, 29 Jun 2022 10:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiF2KDQ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 29 Jun 2022 06:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiF2KDP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 06:03:15 -0400
X-Greylist: delayed 1769 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 03:03:14 PDT
Received: from 10.mo583.mail-out.ovh.net (10.mo583.mail-out.ovh.net [46.105.52.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23593DC6
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 03:03:14 -0700 (PDT)
Received: from player750.ha.ovh.net (unknown [10.109.138.203])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 5CCEB24CD5
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 09:45:39 +0000 (UTC)
Received: from etezian.org (bbcs-175-223.cust.wingo.ch [178.238.175.223])
        (Authenticated sender: andi@etezian.org)
        by player750.ha.ovh.net (Postfix) with ESMTPSA id 7C9FF2C05C87E;
        Wed, 29 Jun 2022 09:45:28 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-109S0033bc7e8cc-49d1-4be9-853d-a569134c5476,
                    27473AD2557E96BAE247B01472F11916F8881100) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.238.175.223
Date:   Wed, 29 Jun 2022 12:45:16 +0300
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
Subject: Re: [PATCH v2 3/4] dt-bindings: samsung,spi: define exynosautov9
 compatible
Message-ID: <YrwfLMlrSupIJggV@jack.zhora.eu>
References: <20220628044222.152794-1-chanho61.park@samsung.com>
 <CGME20220628044432epcas2p3781648b3cade1dcac6b8e0f3899d7299@epcas2p3.samsung.com>
 <20220628044222.152794-4-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628044222.152794-4-chanho61.park@samsung.com>
X-Ovh-Tracer-Id: 2252644240065104408
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudegledgudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughisegvthgviihirghnrdhorhhgqeenucggtffrrghtthgvrhhnpeefheefueelleeghfehgeeiudfgieefffdviedtjeduvdfhhfdthedvteeltdfhueenucfkpheptddrtddrtddrtddpudejkedrvdefkedrudejhedrvddvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeehtddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeef
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chanho,

On Tue, Jun 28, 2022 at 01:42:21PM +0900, Chanho Park wrote:
> Define "samsung,exynosautov9-spi" for Exynos Auto v9's spi.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
