From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] spi: fix NULL pointer dereferences by checking dmaengine_prep_slave_sg
Date: Thu, 14 Mar 2019 09:17:53 +0100
Message-ID: <CAJKOXPfg+T-1acZd-NmSF6uerK0inCPirEyhGJ213VNtM5u1YQ@mail.gmail.com>
References: <20190314064202.14864-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: pakki001@umn.edu, Kukjin Kim <kgene@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190314064202.14864-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 14 Mar 2019 at 07:42, Kangjie Lu <kjlu@umn.edu> wrote:
>
> In case dmaengine_prep_slave_sg fails, the fix returns to avoid
> NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Hi,

Thanks for the patch, but the fix is the same as here:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1402451.html
and the answer is the same as there - I think you did not handle the
error at all. Did you test the error path in this case? How does it
behave? I think there is no point to replace one NULL pointer to
another NULL pointer right after it. :)

Best regards,
Krzysztof

> ---
>  drivers/spi/spi-s3c64xx.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 7b7151ec14c8..3a5f161ce558 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -293,6 +293,8 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
>
>         desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>                                        dma->direction, DMA_PREP_INTERRUPT);
> +       if (!desc)
> +               return;
>
>         desc->callback = s3c64xx_spi_dmacb;
>         desc->callback_param = dma;
> --
> 2.17.1
>
