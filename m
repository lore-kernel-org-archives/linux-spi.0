From: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: atmel_spi clock polarity
Date: Mon, 18 Feb 2008 15:31:58 +0100
Message-ID: <20080218153158.2ff8842a@dhcp-252-066.norway.atmel.com>
References: <20080216.223252.25909396.anemo@mba.ocn.ne.jp>
	<20080218124237.0b5f701c@dhcp-252-066.norway.atmel.com>
	<20080218.231243.41197917.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080218.231243.41197917.anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
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

On Mon, 18 Feb 2008 23:12:43 +0900 (JST)
Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org> wrote:

> T0-T1 was relatively longer then T1-T2.  I suppose T1 is not the
> point of updating MR register, but the point of starting DMA transfer.

Aw. I see.

> Anyway, I will try your patch in a few days.

Ok, thanks. If it works, that would be great, but given your
description above I'm not sure if I dare hope for it.

Hmm...I suppose we could just use CSR0 for all transfers and not
bother updating MR. That might actually be cheaper than doing it
"the right way"...and allow us to support an arbitrary number of
chipselects instead of just four.

But I guess the AT91RM9200 won't be too happy about that...

Haavard

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
