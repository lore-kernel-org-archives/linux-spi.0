From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: atmel_spi clock polarity
Date: Mon, 18 Feb 2008 11:57:56 -0800
Message-ID: <200802181157.57299.david-b@pacbell.net>
References: <20080216.223252.25909396.anemo@mba.ocn.ne.jp>
	<20080218124237.0b5f701c@dhcp-252-066.norway.atmel.com>
	<20080218.231243.41197917.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080218.231243.41197917.anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
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

On Monday 18 February 2008, Atsushi Nemoto wrote:
> 	 IIRC the clock state follows
> CSRn.CPOL just before the real transfer.

No ... clock state should be valid *before* chipselect goes
active.  So I'm thinking the patch from Haavard is likely
the right change.


> Like this (previous transfer 
> was MODE 0, new transfer is MODE 3):
> 
>            T0                T1 T2
> 
> CS      ~~~|________________________________________________

So at T0, some chip is selected (and never deselected) ...

> 
> CLK     ______________________|~|___|~~~|___|~~~|___|~~~|___

... and at T1 CPOL is changed??  That's wrong.  There should
never be a partial clock period while a chipselect is active.
While it's inactive, sure -- no chip should care.


> 
> SO      ~~~~~~~~~~~~~~~~~~~~~~~~~~|___|~~~|___|~~~|___|~~~|_
>                                    MSB
> 
> T0-T1 was relatively longer then T1-T2.  I suppose T1 is not the
> point of updating MR register, but the point of starting DMA transfer.
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
