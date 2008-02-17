From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: Re: spi transfer with zero length
Date: Sun, 17 Feb 2008 23:16:55 +0900 (JST)
Message-ID: <20080217.231655.59465217.anemo@mba.ocn.ne.jp>
References: <20080216.230232.25478328.anemo@mba.ocn.ne.jp>
	<200802161058.49473.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200802161058.49473.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Sat, 16 Feb 2008 10:58:48 -0800, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Saturday 16 February 2008, Atsushi Nemoto wrote:
> > Hi.  Is it legal to use zero for 'len' field of struct spi_transfer?
> > I mean, len=0, tx_buf=rx_buf=NULL, delay_usecs!=0.
> 
> Yes that should work ... it's uncommon, but not illegal.  Some
> controller drivers may even handle that right!
> 
> If the delay were zero and cs_change didn't indicate a need to
> briefly deselect the chip, it might make sense to reject such
> a NOP transfer.  But that's not the case you identify.

Thank you.  I suppose spi-bitbang can handle that right.  Then I'm
going to fix drivers if it cannot handle such case.

> > Some SPI devices need slightly long delay before first CLK edge after
> > CS assertion.
> 
> For future reference ... could you identify a few such devices,
> and say what "long" is relative to the clock period?
> 
> Some folk have just slowed down the clock in such cases, but
> that's rather sub-optimal.

Well, the device I have is so special custom one implemented by PIC or
something.  It needs 100us or so with 200ns clock period.  Slowing
down might be an another solution but some spi driver cannot use such
a slow bitrate (~10KHz).

> > To achieve this, I think inserting using a zero length 
> > transfer before real transfers.  But it seems some drivers do not
> > handle this case properly.
> 
> Feel free to submit patches fixing those bugs.

OK, if I had enough time to make a patch for uptodate version of the
driver ;)

---
Atsushi Nemoto

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
