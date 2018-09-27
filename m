From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH] spi: sprd: don't mark remove function as __exit
Date: Thu, 27 Sep 2018 09:01:21 +0800
Message-ID: <CAMz4kuKeDorMtrO4vgnrMGmXgQms-pw14vb11Xbi0kQ-fX8egQ@mail.gmail.com>
References: <20180926125833.2225931-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>,
        linux-spi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926125833.2225931-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 26 September 2018 at 20:58, Arnd Bergmann <arnd@arndb.de> wrote:
> The __exit section is left out for built-in drivers, so a
> 'remove' callback must not be marked as such to avoid breaking when
> we unbind a device at runtime. This was pointed out by kbuild:
>
> `sprd_spi_remove' referenced in section `.data' of drivers/spi/spi-sprd.o: defined in discarded section `.exit.text' of drivers/spi/spi-sprd.o
>
> Fixes: e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd.

Acked-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/spi/spi-sprd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
> index a9a6c5ed443f..8daa24eec624 100644
> --- a/drivers/spi/spi-sprd.c
> +++ b/drivers/spi/spi-sprd.c
> @@ -676,7 +676,7 @@ static int sprd_spi_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> -static int __exit sprd_spi_remove(struct platform_device *pdev)
> +static int sprd_spi_remove(struct platform_device *pdev)
>  {
>         struct spi_controller *sctlr = platform_get_drvdata(pdev);
>         struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
> --
> 2.18.0
>



-- 
Baolin Wang
Best Regards
