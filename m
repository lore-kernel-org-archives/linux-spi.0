From: Johannes Stezenbach <js-FF7aIK3TAVNeoWH0uzbU5w@public.gmane.org>
Subject: Re: SPI: DUAL/QUAD support
Date: Thu, 4 Jul 2013 15:00:17 +0200
Message-ID: <20130704130017.GA25997@sig21.net>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 04, 2013 at 07:36:48PM +0800, yuhang wang wrote:
> 
> I have added the kerneldoc into the patch below to explain the "DUAL"
> and "QUAD" modes.
> Hope for your suggestions.
> 
> Documentation/spi/spi-dual_quad |  102 +++++++++++++++++++++++++++++++++++++++
>  drivers/mtd/devices/m25p80.c    |    2 +
>  drivers/spi/spi.c               |    2 +
>  include/linux/spi/spi.h         |    8 +++

I think what Mark meant is to add new fields to the /** comments
in include/linux/spi/spi.h, then documentation could be generated
(but it seems only outdated copies are online, everyone prefers
to look at the code):
https://www.kernel.org/doc/htmldocs/device-drivers/

> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -354,6 +354,7 @@ static int m25p80_read(struct mtd_info *mtd,
> loff_t from, size_t len,
> 
>         t[1].rx_buf = buf;
>         t[1].len = len;
> +       t[1].bitwidth = flash->spi->rx_bitwidth;
>         spi_message_add_tail(&t[1], &m);
> 
>         mutex_lock(&flash->lock);
> @@ -409,6 +410,7 @@ static int m25p80_write(struct mtd_info *mtd,
> loff_t to, size_t len,
>         spi_message_add_tail(&t[0], &m);
> 
>         t[1].tx_buf = buf;
> +       t[1].bitwidth = flash->spi->tx_bitwidth;
>         spi_message_add_tail(&t[1], &m);
> 
>         mutex_lock(&flash->lock);

Doesn't m25p80 need to use different commands (OPCODEs)
for 2x and 4x speed?  It seems this change is incomplete.

Thanks,
Johannes

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
