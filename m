From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH -next 25/36] spi: s3c24xx: use
 devm_platform_ioremap_resource() to simplify code
Date: Thu, 5 Sep 2019 12:08:58 +0200
Message-ID: <d3803e7b-4d5a-8260-e999-12465744c2a7@samsung.com>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
        <20190904135918.25352-26-yuehaibing@huawei.com>
        <CGME20190905100902eucas1p1ce36a6d769640de92f9ff880728a3d26@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
        eric@anholt.net, wahrenst@gmx.net, shc_work@mail.ru,
        agross@kernel.org, khilman@baylibre.com, matthias.bgg@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, kgene@kernel.org,
        krzk@kernel.org, andi@etezian.org, palmer@sifive.com,
        paul.walmsley@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yamada.masahiro@socionext.com,
        michal.simek@xilinx.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904135918.25352-26-yuehaibing@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 9/4/19 15:59, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
