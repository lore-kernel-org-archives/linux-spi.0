From: Yuehaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next 25/36] spi: s3c24xx: use
 devm_platform_ioremap_resource() to simplify code
Date: Wed, 4 Sep 2019 22:42:06 +0800
Message-ID: <3595bac1-e426-b4f9-4e24-01e104fdfe5d@huawei.com>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-26-yuehaibing@huawei.com>
 <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <eric@anholt.net>, <wahrenst@gmx.net>,
        <shc_work@mail.ru>, <agross@kernel.org>, <khilman@baylibre.com>,
        <matthias.bgg@gmail.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <avifishman70@gmail.com>, <tmaimon77@gmail.com>,
        <tali.perry1@gmail.com>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <kgene@kernel.org>,
        Andi Shyti <andi@etezian.org>, <palmer@sifive.com>,
        <paul.walmsley@sifive.com>, <baohua@kernel.org>,
        <mripard@kernel.org>, <wens@csie.org>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <yamada.masahiro@socionext.com>, <michal.simek@xilinx.com>,
        <bcm-k
To: Krzysztof Kozlowski <krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2019/9/4 22:28, Krzysztof Kozlowski wrote:
> On Wed, 4 Sep 2019 at 16:00, YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> Use devm_platform_ioremap_resource() to simplify the code a bit.
>> This is detected by coccinelle.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
> 
> This tag does not look real... First of all where is the report?

It is our internal CI robot, which is unavailable to external temporarily.

> Second, it was reported by coccinelle.
> Reported-by should be use to give real credits.
> 
> Best regards,
> Krzysztof
> 
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/spi/spi-s3c24xx.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
>> index aea8fd9..2d6e37f 100644
>> --- a/drivers/spi/spi-s3c24xx.c
>> +++ b/drivers/spi/spi-s3c24xx.c
>> @@ -487,7 +487,6 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
>>         struct s3c2410_spi_info *pdata;
>>         struct s3c24xx_spi *hw;
>>         struct spi_master *master;
>> -       struct resource *res;
>>         int err = 0;
>>
>>         master = spi_alloc_master(&pdev->dev, sizeof(struct s3c24xx_spi));
>> @@ -536,8 +535,7 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
>>         dev_dbg(hw->dev, "bitbang at %p\n", &hw->bitbang);
>>
>>         /* find and map our resources */
>> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -       hw->regs = devm_ioremap_resource(&pdev->dev, res);
>> +       hw->regs = devm_platform_ioremap_resource(pdev, 0);
>>         if (IS_ERR(hw->regs)) {
>>                 err = PTR_ERR(hw->regs);
>>                 goto err_no_pdata;
>> --
>> 2.7.4
>>
>>
> 
> .
> 
