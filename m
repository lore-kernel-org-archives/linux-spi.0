From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: atmel_spi clock polarity
Date: Mon, 18 Feb 2008 23:12:43 +0900 (JST)
Message-ID: <20080218.231243.41197917.anemo@mba.ocn.ne.jp>
References: <20080216.223252.25909396.anemo@mba.ocn.ne.jp>
	<20080218124237.0b5f701c@dhcp-252-066.norway.atmel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: david-b@pacbell.net, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: hskinnemoen@atmel.com
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753740AbYBROMd@vger.kernel.org>
In-Reply-To: <20080218124237.0b5f701c@dhcp-252-066.norway.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 18 Feb 2008 12:42:37 +0100, Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> > Here is my quick workaround for this problem.  It makes all CSRn.CPOL
> > match for the transfer before activating chipselect.  I'm not quite
> > sure my analysis is correct, and there might be better solution.
> > Could you give me any comments?
> 
> I'm not sure if I fully understand what problem you're seeing. Is the
> clock state wrong when the chip select is activated?

Yes.

> If so, does the patch below help?

Hmm... It might fix my problem.  But IIRC the clock state follows
CSRn.CPOL just before the real transfer.  Like this (previous transfer
was MODE 0, new transfer is MODE 3):

           T0                T1 T2

CS      ~~~|________________________________________________

CLK     ______________________|~|___|~~~|___|~~~|___|~~~|___

SO      ~~~~~~~~~~~~~~~~~~~~~~~~~~|___|~~~|___|~~~|___|~~~|_
                                   MSB

T0-T1 was relatively longer then T1-T2.  I suppose T1 is not the
point of updating MR register, but the point of starting DMA transfer.

Anyway, I will try your patch in a few days.

---
Atsushi Nemoto
