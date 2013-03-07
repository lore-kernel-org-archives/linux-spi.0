From: Joachim  Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 01/16] spi/spi-atmel: fix probing failure after
	xfer->speed_hz set
Date: Thu, 7 Mar 2013 13:30:45 +0100
Message-ID: <CAGhQ9VwW18LXY5Jn0FUFCaAzKxP1W3QADG=JBp9JbgaAwo=F2Q@mail.gmail.com>
References: <1362626715-6549-1-git-send-email-wenyou.yang@atmel.com>
	<1362626815-6628-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, JM.Lin-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1362626815-6628-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 7 March 2013 04:26, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> commit: 059b8ffeee5b427949872bb6ed5db5ae0788054e
> cause the atmel spi probing failure.
>
> Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  drivers/spi/spi-atmel.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 656d137..1eca815 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -846,9 +846,9 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
>                         }
>                 }
>
> -               /* FIXME implement these protocol options!! */
> -               if (xfer->speed_hz) {
> -                       dev_dbg(&spi->dev, "no protocol options yet\n");
> +               if (xfer->speed_hz < spi->max_speed_hz) {
> +                       dev_dbg(&spi->dev,
> +                               "speed in transfer less than bus speed\n");
>                         return -ENOPROTOOPT;
>                 }

I sent a similar patch to spi-devl a while ago, which Grant said he applied.
https://patchwork.kernel.org/patch/2165301/

Can't find the patch in any upstream git tree so I guess Grant hasn't
pushed it yet.

regards
Joachim Eastwood

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
