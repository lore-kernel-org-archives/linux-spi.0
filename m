From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: spi-atmel broken in next
Date: Sun, 17 Feb 2013 20:12:47 +0000
Message-ID: <CACxGe6u0o0V3Jm9-iyizKH5KX=dPe-CL0bH-Kc7KM_k6gAk69A@mail.gmail.com>
References: <CAGhQ9VwoehjY4niDqcnb88va9vNLw=jFmxOnq6k0QP6GZJ4gqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
To: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAGhQ9VwoehjY4niDqcnb88va9vNLw=jFmxOnq6k0QP6GZJ4gqQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Feb 17, 2013 at 11:15 AM, Joachim  Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> spi-atmel is now broken for all spi transfers in linux-next. This is
> caused by commit "spi: make sure all transfer has proper speed set".
> The reason is the following code in atmel_spi_transfer(...)
>
>  849  /* FIXME implement these protocol options!! */
>  850  if (xfer->speed_hz) {
>  851      dev_dbg(&spi->dev, "no protocol options yet\n");
>  852      return -ENOPROTOOPT;
>  853  }
>
> Now that xfer->speed_hz is always set all spi transfers will return
> with ENOPROTOOPT.
>
> Not quite sure how to best fix it. Just removing the whole test
> makes it work again but I guess we should do something better
> with speed_hz here.

Probably the best fix is to check instead if xfer->speed_hz is less
than the bus speed. If it is then you can fail. If it is not, then
continue.

g.

------------------------------------------------------------------------------
The Go Parallel Website, sponsored by Intel - in partnership with Geeknet, 
is your hub for all things parallel software development, from weekly thought 
leadership blogs to news, videos, case studies, tutorials, tech docs, 
whitepapers, evaluation guides, and opinion stories. Check out the most 
recent posts - join the conversation now. http://goparallel.sourceforge.net/
