From: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: imx: fix issue when tx_buf or rx_buf is NULL
Date: Fri, 19 May 2017 20:45:18 +0800
Message-ID: <94de6e6d-a2fa-6589-151b-660bbcb42773@gtsys.com.hk>
References: <1495101672-3384-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        leonard.crestez-3arQi8VN3Tc@public.gmane.org
To: jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495101672-3384-1-git-send-email-jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On Thursday, May 18, 2017 06:01 PM, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org wrote:
> From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>
> In case either transfer->tx_buf or transfer->rx_buf is NULL,
> manipulation of buffer in spi_imx_u32_swap_u[8|16]() will cause
> NULL pointer dereference crash.
>
> Add buffer check at very beginning of spi_imx_u32_swap_u[8|16](),
> to avoid such crash.
>
> Signed-off-by: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
> Reported-by: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
> ---
>  drivers/spi/spi-imx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 782045f..19b30cf 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -288,6 +288,9 @@ static void spi_imx_u32_swap_u8(struct spi_transfer *transfer, u32 *buf)
>  {
>  	int i;
>
> +	if (!buf)
> +		return;
> +
>  	for (i = 0; i < transfer->len / 4; i++)
>  		*(buf + i) = cpu_to_be32(*(buf + i));
>  }
> @@ -296,6 +299,9 @@ static void spi_imx_u32_swap_u16(struct spi_transfer *transfer, u32 *buf)
>  {
>  	int i;
>
> +	if (!buf)
> +		return;
> +
>  	for (i = 0; i < transfer->len / 4; i++) {
>  		u16 *temp = (u16 *)buf;
>
>

Hi, thanks for the patch.

But I think we missing something here. We return from a void function()
so the error keeps hidden. The root cause is calling this functions with a NULL 
pointer. See if you can fix this by find the caller and check if the parameter 
hand over are valid.

Cheers
Chris


-- 
GTSYS Limited RFID Technology
9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
Tel (852) 9079 9521

Disclaimer: http://www.gtsys.com.hk/email/classified.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
