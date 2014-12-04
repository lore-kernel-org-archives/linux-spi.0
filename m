From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: spi-fsl-spi: Return an error code in fsl_spi_do_one_msg()
Date: Thu, 4 Dec 2014 14:34:10 +0100
Message-ID: <CAFSsGVs+bxygZ1u2P0BPKvBX0FrbURAJwYdM6ABB+-ZKvQT6eQ@mail.gmail.com>
References: <1417698947-4273-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417698947-4273-1-git-send-email-fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Right, missed that. However the code was bogus before, the status =
-EINVAL didn't make sense as the value of variable status isn't used
before the return.
Therefore we can remove the "status = -EINVAL".
Shall I submit a patch or what would be your preferred approach?

On Thu, Dec 4, 2014 at 2:15 PM, Fabio Estevam
<fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> Since commit c592becbe704127 ("spi: fsl-(e)spi: migrate to generic master
> queueing") the function fsl_spi_do_one_msg() is not void anymore, so return
> an error code to avoid the following buid warning:
>
>    drivers/spi/spi-fsl-spi.c: In function 'fsl_spi_do_one_msg':
>>> drivers/spi/spi-fsl-spi.c:374:4: warning: 'return' with no value, in function returning non-void [-Wreturn-type]
>        return;
>        ^
>
> Reported-by: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/spi/spi-fsl-spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
> index e24a9bf..83f8081 100644
> --- a/drivers/spi/spi-fsl-spi.c
> +++ b/drivers/spi/spi-fsl-spi.c
> @@ -371,7 +371,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
>                         status = -EINVAL;
>                         dev_err(&spi->dev,
>                                 "bits_per_word/speed_hz should be same for the same SPI transfer\n");
> -                       return;
> +                       return -EINVAL;
>                 }
>         }
>
> --
> 1.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
