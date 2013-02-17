From: Joachim  Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: spi-atmel broken in next
Date: Sun, 17 Feb 2013 12:15:51 +0100
Message-ID: <CAGhQ9VwoehjY4niDqcnb88va9vNLw=jFmxOnq6k0QP6GZJ4gqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

spi-atmel is now broken for all spi transfers in linux-next. This is
caused by commit "spi: make sure all transfer has proper speed set".
The reason is the following code in atmel_spi_transfer(...)

 849  /* FIXME implement these protocol options!! */
 850  if (xfer->speed_hz) {
 851      dev_dbg(&spi->dev, "no protocol options yet\n");
 852      return -ENOPROTOOPT;
 853  }

Now that xfer->speed_hz is always set all spi transfers will return
with ENOPROTOOPT.

Not quite sure how to best fix it. Just removing the whole test
makes it work again but I guess we should do something better
with speed_hz here.

One little question; Is a per transfer speed setting really sensible?
As far as I can see from grepping the kernel source it's not
used by device drivers.


regards
Joachim Eastwood

------------------------------------------------------------------------------
The Go Parallel Website, sponsored by Intel - in partnership with Geeknet, 
is your hub for all things parallel software development, from weekly thought 
leadership blogs to news, videos, case studies, tutorials, tech docs, 
whitepapers, evaluation guides, and opinion stories. Check out the most 
recent posts - join the conversation now. http://goparallel.sourceforge.net/
