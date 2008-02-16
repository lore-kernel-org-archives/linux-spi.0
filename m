From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: spi transfer with zero length
Date: Sat, 16 Feb 2008 10:58:48 -0800
Message-ID: <200802161058.49473.david-b@pacbell.net>
References: <20080216.230232.25478328.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080216.230232.25478328.anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Saturday 16 February 2008, Atsushi Nemoto wrote:
> Hi.  Is it legal to use zero for 'len' field of struct spi_transfer?
> I mean, len=0, tx_buf=rx_buf=NULL, delay_usecs!=0.

Yes that should work ... it's uncommon, but not illegal.  Some
controller drivers may even handle that right!

If the delay were zero and cs_change didn't indicate a need to
briefly deselect the chip, it might make sense to reject such
a NOP transfer.  But that's not the case you identify.


> Some SPI devices need slightly long delay before first CLK edge after
> CS assertion.

For future reference ... could you identify a few such devices,
and say what "long" is relative to the clock period?

Some folk have just slowed down the clock in such cases, but
that's rather sub-optimal.


> To achieve this, I think inserting using a zero length 
> transfer before real transfers.  But it seems some drivers do not
> handle this case properly.

Feel free to submit patches fixing those bugs.


> Is this driver's bug, or we need additional delay field in struct
> spi_device for such case?

I'd like to avoid new parameters to cover case that can already
be expressed in the programming interface.  Cases that can't be
expressed ... different issue.  I suspect any patches updating
timing parameters should use nanoseconds not microseconds, fwiw.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
