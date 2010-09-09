From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] amba_pl022: Setup SPI configuration based on spi->mode
Date: Thu, 9 Sep 2010 10:33:29 +0200
Message-ID: <AANLkTimm1VujXp6dsQLqJt_GRmE3xOS5Z-i7wvJLj5Nc@mail.gmail.com>
References: <1283446992-23764-1-git-send-email-wellsk40@gmail.com>
	<AANLkTi=2XQ==iCYtAQ_74wPZ6JRB3x9SjS=sjVoC5YiM@mail.gmail.com>
	<AANLkTik4Jm6u+jowgG7Py3u8N=B48opWYAikGztpXhs_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Lukasz.Baj-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
To: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTik4Jm6u+jowgG7Py3u8N=B48opWYAikGztpXhs_-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/9/9 Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:

> Yes - the clients and the client setup info need some changes.
> I'm currently testing these patches and will post them soon.

OK great, can you make this a patch series?

Like
1/2 - changes to amba-pl022.c
2/2 - changes to clients

or so?

Yours,
Linus Walleij

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
