From: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/pl022: timeout on polled transfer v2
Date: Thu, 19 May 2011 19:04:29 +0200
Message-ID: <BANLkTi=s4nzi=5f+Vvh3ABuspnKXQVUfLw@mail.gmail.com>
References: <1305821134-26147-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Magnus Templing <magnus.templing-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1305821134-26147-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

On Thu, May 19, 2011 at 6:05 PM, Linus Walleij
<linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:
> From: Magnus Templing <magnus.templing-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>
> This adds the missing handling of polling timeouts and deletes
> our last todo.
>
> Signed-off-by: Magnus Templing <magnus.templing-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> [Fixups from review by Wolfram Sang]
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> =A0drivers/spi/amba-pl022.c | =A0 23 +++++++++++++++--------
> =A01 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 08de58e..18667de 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -24,11 +24,6 @@
> =A0* GNU General Public License for more details.
> =A0*/
>
> -/*
> - * TODO:
> - * - add timeout on polled transfers
> - */
> -
> =A0#include <linux/init.h>
> =A0#include <linux/module.h>
> =A0#include <linux/device.h>
> @@ -287,6 +282,8 @@
>
> =A0#define CLEAR_ALL_INTERRUPTS =A00x3
>
> +#define SPI_POLLING_TIMEOUT 1000
> +
>
> =A0/*
> =A0* The type of reading going on on this chip
> @@ -1378,6 +1375,7 @@ static void do_polling_transfer(struct pl022 *pl022)
> =A0 =A0 =A0 =A0struct spi_transfer *transfer =3D NULL;
> =A0 =A0 =A0 =A0struct spi_transfer *previous =3D NULL;
> =A0 =A0 =A0 =A0struct chip_data *chip;
> + =A0 =A0 =A0 unsigned long time, timeout;
>
> =A0 =A0 =A0 =A0chip =3D pl022->cur_chip;
> =A0 =A0 =A0 =A0message =3D pl022->cur_msg;
> @@ -1415,9 +1413,18 @@ static void do_polling_transfer(struct pl022 *pl02=
2)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_CR1(pl022->virtbase));
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&pl022->adev->dev, "polling transf=
er ongoing ...\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: insert a timeout so we don't hang=
 here indefinitely */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (pl022->tx < pl022->tx_end || pl022->=
rx < pl022->rx_end)
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(SPI_=
POLLING_TIMEOUT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (pl022->tx < pl022->tx_end || pl022->=
rx < pl022->rx_end) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 time =3D jiffies;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0readwriter(pl022);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(time, timeou=
t)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&p=
l022->adev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: timeou=
t!\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 message->st=
ate =3D STATE_ERROR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

just out of curiosity: is it a busy wait? Looks like it is...

Thanks,
   Vitaly

---------------------------------------------------------------------------=
---
What Every C/C++ and Fortran developer Should Know!
Read this article and learn how Intel has extended the reach of its =

next-generation tools to help Windows* and Linux* C/C++ and Fortran =

developers boost performance applications - including clusters. =

http://p.sf.net/sfu/intel-dev2devmay
