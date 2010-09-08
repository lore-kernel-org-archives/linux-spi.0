From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] amba_pl022: Setup SPI configuration based on spi->mode
Date: Wed, 8 Sep 2010 18:04:57 +0200
Message-ID: <AANLkTi=2XQ==iCYtAQ_74wPZ6JRB3x9SjS=sjVoC5YiM@mail.gmail.com>
References: <1283446992-23764-1-git-send-email-wellsk40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Lukasz.Baj-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
To: wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1283446992-23764-1-git-send-email-wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/9/2  <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:

> This patch changes the way SPI transfers are setup. The previous
> method uses the pl022_config_chip data for configuration of
> loopback mode, edge count, clock polarity, number of data bits,
> and bit transfer order. This change configures these parameters
> based on spi->mode passed via master->setup and will allow the
> drivers use SPI to configure the interface.

I get regressions on my in-kernel drivers of the SPI when I apply
this patch.

I guess I also have to update all in-kernel clients to supply the
correct bits?

Can you help me out on what needs to be done... the major
in-kernel user is drivers/mfd/ab8500-spi.c so far.

Yours,
Linus Walleij

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
