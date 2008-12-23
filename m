From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [patch 2.6.28-rc9] spi:
	spi_write_then_read() regression fix
Date: Tue, 23 Dec 2008 10:45:37 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812231040080.3535@localhost.localdomain>
References: <200812202332.36281.david-b@pacbell.net>
	<alpine.LFD.2.00.0812211545520.24883@localhost.localdomain>
	<200812211648.26699.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200812211648.26699.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



On Sun, 21 Dec 2008, David Brownell wrote:

> On Sunday 21 December 2008, Linus Torvalds wrote:
> > 
> > Hmm. In addition, isn't this broken (in that same function):
> 
> No -- this is full duplex.  The write_then_read() helper is
> simplifying a common half-duplex idiom for short operations,
> but the harware still does full duplex.  Buffer layout is:
> 
>   Before:	WWWWW0000000
>   After:	xxxxxRRRRRRR

Then, the problem is this:

        x.tx_buf = local_buf;
        x.rx_buf = local_buf;

which makes no sense. It's not two separate "tx_buf"/"rx_buf" things, it's 
just a single "buf".

Having two separate pointers is not only confusing, but it's actively 
WRONG, since the "rx_buf" clearly does not start at local_buf.

But that's not how most spi drivers seem to do it. They literally set 
tx_bug and rx_buf to different values. So again, none of what you talk 
about makes sense, and none of your "explanations" are anything but just 
incoherent noise.

So please explain how it can _possibly_ make sense to

 - have two separate pointers

 - and have one of them point to what is clearly not the data it is 
   supposed to point to.

Hmm?

			Linus

------------------------------------------------------------------------------
