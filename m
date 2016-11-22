From: prahlad venkata <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: spi-ti-qspi: reinit of completion variable
Date: Tue, 22 Nov 2016 12:54:06 +0530
Message-ID: <CAFbo-qWmvm02wpkWT0hgX6qu6jOStmwAXHBWbjbAQ=fwv0WPng@mail.gmail.com>
References: <20161115182643.32217-1-prahlad.eee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Prahlad V <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161115182643.32217-1-prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Did anybody got chance to review this patch?
I feel this is a trivial yet required fix.

On Tue, Nov 15, 2016 at 11:56 PM, Prahlad V <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> completion variable should be reinitialized before reusing.
>
> Signed-off-by: Prahlad V <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-ti-qspi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index caeac66..ec6fb09 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -411,6 +411,7 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
>         tx->callback = ti_qspi_dma_callback;
>         tx->callback_param = qspi;
>         cookie = tx->tx_submit(tx);
> +       reinit_completion(&qspi->transfer_complete);
>
>         ret = dma_submit_error(cookie);
>         if (ret) {
> --
> 2.9.2.729.ga42d7b6
>



-- 
Regards,
Prahlad.
+91-9663742838
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
