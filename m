From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH -next 06/36] spi: bcm2835: use
 devm_platform_ioremap_resource() to simplify code
Date: Thu, 5 Sep 2019 20:39:45 +0200
Message-ID: <c9c6a9ca-5725-513f-2ef3-734ecf0878b8@gmx.net>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-7-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-samsung-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-tegra@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, broonie@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        eric@anholt.net, shc_work@mail.ru, agross@kernel.org,
        khilman@baylibre.com, matthias.bgg@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, kgene@kernel.org, krzk@kernel.org,
        andi@etezian.org, palmer@sifive.com, paul.walmsley@sifive.com,
        baohua@kernel.org, mripard@kernel.org, wens@csie.org,
        ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yamada.masahiro@socionext.com,
        michal.simek@xilinx.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904135918.25352-7-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am 04.09.19 um 15:58 schrieb YueHaibing:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Stefan Wahren <wahrenst@gmx.net>
