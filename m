From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Suggested Patch for 'amba-pl022.c' to solve
	the problem of running 'spidev_test' on Phytec LPC3250 board.
Date: Wed, 1 Sep 2010 17:57:45 +0200
Message-ID: <AANLkTi=8uvtwd9+HEc9EpW-Y9CVx+NN-Zg-omO4nUN13@mail.gmail.com>
References: <AANLkTinQFQMXXBh7bq5ce_iwOzGvYCZxud6QWb-S71yQ@mail.gmail.com>
	<AANLkTimsoUUJihk8j48KkJ1YPdAttLHPuJ19i0W0BkpD@mail.gmail.com>
	<AANLkTi=e53=8VNHv=5gSfujYN0XU0NYJTu3=Aq2FS5VZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTi=e53=8VNHv=5gSfujYN0XU0NYJTu3=Aq2FS5VZ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/9/1 Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:

> I use this driver quite a bit here - Is it ok if try to get the setup based on
> spi->mode instead of the controller_data info?

I think that the stuff that comes from the modebits should take
precedence, and also I believe the relevant platform data should
be removed.

I cannot fully undertand what this means and I never used SPI
from userspace, can't you just provide a patch I can look on,
that is easiest I think. I will test it on my hardware and see what
happens.

Yours,
Linus Walleij

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
