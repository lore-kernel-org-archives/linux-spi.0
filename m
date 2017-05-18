From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH linux-next v2 1/1] spi: imx: dynamic burst length adjust
 for PIO mode
Date: Thu, 18 May 2017 12:29:54 +0300
Message-ID: <1495099794.26925.18.camel@nxp.com>
References: <1493634704-3545-1-git-send-email-jiada_wang@mentor.com>
          <1493634704-3545-2-git-send-email-jiada_wang@mentor.com>
         <1495042325.26925.15.camel@nxp.com> <591CFDEA.1080204@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Octavian Purdila <octavian.purdila@nxp.com>,
        "Fabio Estevam" <fabio.estevam@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>
To: Jiada Wang <jiada_wang@mentor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <591CFDEA.1080204@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 2017-05-17 at 18:50 -0700, Jiada Wang wrote:
> Hello Leonard
> 
> Thanks for the report, can you help to check if the following change 
> address the issue?
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 782045f..19b30cf 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -288,6 +288,9 @@ static void spi_imx_u32_swap_u8(struct spi_transfer 
> *transfer, u32 *buf)
>   {
>          int i;
> 
> +       if (!buf)
> +               return;
> +
>          for (i = 0; i < transfer->len / 4; i++)
>                  *(buf + i) = cpu_to_be32(*(buf + i));
>   }
> @@ -296,6 +299,9 @@ static void spi_imx_u32_swap_u16(struct spi_transfer 
> *transfer, u32 *buf)
>   {
>          int i;
> 
> +       if (!buf)
> +               return;
> +
>          for (i = 0; i < transfer->len / 4; i++) {
>                  u16 *temp = (u16 *)buf;
> 

Yes, this does seem to fix it.
