From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: imx: Revert "spi: imx: dynamic burst length adjust
 for PIO mode"
Date: Fri, 19 May 2017 03:55:55 -0700
Message-ID: <591ECF3B.4040001@mentor.com>
References: <1495113735-11891-1-git-send-email-fabio.estevam@nxp.com> <1495115958.26925.23.camel@nxp.com> <CAOMZO5Adj+sgxgoO9gN232EEH=NtjTHpKfB+EaUAbRXyaPD_Gg@mail.gmail.com> <591DBFD2.4090601@mentor.com> <CAOMZO5BZvp_iWoJCTkZL-buSu6pscv1U-6XLjjEm8PjVOjf9wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5BZvp_iWoJCTkZL-buSu6pscv1U-6XLjjEm8PjVOjf9wQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Fabio

Although I don't have this spi-nor chip populated on my sabresd,
but I think I managed to re-create similar scenario,

could you help to check if the following change address the spi-nor 
detection issue

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 782045f..a097a8d 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -242,6 +242,7 @@ static bool spi_imx_can_dma(struct spi_master 
*master, struct spi_device *spi,
                 return false;

         spi_imx->wml = i;
+       spi_imx->dynamic_burst = 0;

         return true;
  }
@@ -288,6 +289,9 @@ static void spi_imx_u32_swap_u8(struct spi_transfer 
*transfer, u32 *buf)
  {
         int i;

+       if (!buf)
+               return;
+
         for (i = 0; i < transfer->len / 4; i++)
                 *(buf + i) = cpu_to_be32(*(buf + i));
  }
@@ -296,6 +300,9 @@ static void spi_imx_u32_swap_u16(struct spi_transfer 
*transfer, u32 *buf)
  {
         int i;

+       if (!buf)
+               return;
+
         for (i = 0; i < transfer->len / 4; i++) {

Thanks,
Jiada

On 05/18/2017 08:41 AM, Fabio Estevam wrote:
> Hi Jiada,
>
> On Thu, May 18, 2017 at 12:37 PM, Jiada Wang<jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>  wrote:
>
>> Which kernel and HW version are you using for test?
> I am running linux-next 20170518 on a imx6q sabresd revB board.
>
>> with the test on my imx6q sabresd board,
>> no matter using upstream kernel or our internal kernel,
>> the issue exists with or without the patch.
> There are some imx6q sabresd boards that does not come with the SPI
> NOR flash populated.
>
> I assume your board does not have the SPI NOR populated, so that's why
> you always get the same message.
>
> Reverting 8d4a6cad7adb ("spi: imx: dynamic burst length adjust for PIO
> mode") makes the SPI NOR to work again here.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
