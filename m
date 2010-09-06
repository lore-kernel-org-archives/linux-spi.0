From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: Re: [PATCH] amba_pl022: Setup SPI configuration based on spi->mode
Date: Mon, 6 Sep 2010 13:39:11 +0200
Message-ID: <AANLkTi=C=abmA6npWO3Se_FX3crWd9ho9xNQxuezRp82@mail.gmail.com>
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

Hi Kevin, sorry for the late answer ... too busy.

This definiately looks like the right way to do this to my
now a bit non-uptodate eye, but I'm running it by my
current SPI ace Lukasz @Tieto, so he can object if there
is some problem with it, else:
Acked-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Yours,
Linus Walleij

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
