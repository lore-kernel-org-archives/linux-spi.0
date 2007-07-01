From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] TXx9 SPI controller driver (take 2)
Date: Sun, 01 Jul 2007 23:40:27 +0900 (JST)
Message-ID: <20070701.234027.07645149.anemo@mba.ocn.ne.jp>
References: <200706300953.20156.david-b@pacbell.net>
	<20070701.023414.71085498.anemo@mba.ocn.ne.jp>
	<200706301046.20826.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com, mlachwani@mvista.com,
	spi-devel-general@lists.sourceforge.net
To: david-b@pacbell.net
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <200706301046.20826.david-b@pacbell.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org

On Sat, 30 Jun 2007 10:46:20 -0700, David Brownell <david-b@pacbell.net> wrote:
> > The compiler will optimize "1000000000 / 2 / spi->max_speed_hz" into
> > "500000000 / spi->max_speed_hz", so it can be treat as one "/", no?
> 
> Sure it's deterministic.  But that doesn't prevent me from
> needing a double-take to figure what it does ... it's best
> to avoid confusing idioms in code.  At the very least, put
> parentheses there ...

OK, I will use parentheses while I think 1000000000 is important part.
Well, maybe NSEC_PER_SEC would be better.
---
Atsushi Nemoto
