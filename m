From: Vinit Kamalaksha SHENOY <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
Subject: RE: [PATCH] spi/pl022: Fix error print while setting bits/word on
	pl022
Date: Tue, 17 Apr 2012 15:04:09 +0800
Message-ID: <19441845E6588A4094A951B5B6AD56EB1F151C1CE6@EAPEX1MAIL2.st.com>
References: <1334642325-29159-1-git-send-email-vinit.shenoy@st.com>
	<CAM=Q2csRwyGYgQ27bXjX=m6pqFoZFim=y3Qzv_DCQvyR5G0brg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	spear-devel <spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAM=Q2csRwyGYgQ27bXjX=m6pqFoZFim=y3Qzv_DCQvyR5G0brg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> From: Shubhrajyoti Datta [mailto:omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Tuesday, April 17, 2012 11:55 AM

> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 09c925a..6444a5e 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -1823,11 +1823,7 @@ static int pl022_setup(struct spi_device *spi)
>         } else
>                 chip->cs_control = chip_info->cs_control;
> 
> -       if (bits <= 3) {
> -               /* PL022 doesn't support less than 4-bits */
> -               status = -ENOTSUPP;
> -               goto err_config_params;
> -       } else if (bits <= 8) {
> +       if (bits <= 8 && bits > 3) {
>                 dev_dbg(&spi->dev, "4 <= n <=8 bits per word\n");
>                 chip->n_bytes = 1;
>                 chip->read = READING_U8;
> @@ -1848,7 +1844,7 @@ static int pl022_setup(struct spi_device *spi)
>                                 "illegal data size for this
> controller!\n");
>                         dev_err(&spi->dev,
>                                 "a standard pl022 can only handle "
> -                               "1 <= n <= 16 bit words\n");
> +                               "4 <= n <= 16 bit words\n");
>                         status = -ENOTSUPP;
>                         goto err_config_params;
>                 }

There are still few issues present here :(
Let me float V2.

--
vinit

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
