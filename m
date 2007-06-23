From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH] TXx9 SPI controller driver
Date: Sat, 23 Jun 2007 09:09:51 -0700
Message-ID: <200706230909.52037.david-b@pacbell.net>
References: <20070622.232111.36926005.anemo@mba.ocn.ne.jp> <200706221151.24959.david-b@pacbell.net> <20070624.004159.07644824.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org, ralf@linux-mips.org,
	mlachwani@mvista.com
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20070624.004159.07644824.anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org

On Saturday 23 June 2007, Atsushi Nemoto wrote:

> Thank you for excellent review!  I'll look at each comments surely
> will update the driver but it may take a few days.

That's fine.

 
> For now, I'm quite sure your patch is OK for me except for one thing:
> 
> > + * spi_tx99.c - TXx9 SPI controller driver.
> 
> Name it spi_txx9.c, please ;)

Sorry, typo!  ... please fix when you resubmit.

 
> And for mmiowb() issue, I put it just only I was not sure whether
> gpio_set_value() guarantee I/O barrier.  Now I see i2c-gpio.c, etc. do
> not have such barriers.  I will remove these barriers and fix platform
> gpio codes.

I don't think this is a case where there'd be a benefit to
allowing non-barriered implementations, and thus requiring
all portable code to include platform-neutral I/O barriers.
I don't know that such neutral primitives actually exist...

I'll update the GPIO docs to make that clear, unless you
have some strong argument to the contrary.

- Dave
