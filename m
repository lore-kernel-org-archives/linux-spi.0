From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: Re: [PATCH] atmel_spi: support zero length
	transfer (resend)
Date: Sun, 30 Mar 2008 21:29:06 +0900 (JST)
Message-ID: <20080330.212906.75185185.anemo@mba.ocn.ne.jp>
References: <20080330.001133.108307862.anemo@mba.ocn.ne.jp>
	<20080329175651.311b4f6d@hskinnemo-gx620.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: nforrester-/d+BM93fTQY@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	marc.pignat-7TsPiqsLilE@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
To: haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080329175651.311b4f6d-+1Ci8juu1zqWbxOaCEK3Pa14KzY7BuZjUIXZgC+OUhs@public.gmane.org>
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

On Sat, 29 Mar 2008 17:56:51 +0100, Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> > Though some discussion about zero length transfer were raised by this
> > patch last time, I think there were no explicit objection to this
> > patch itself.
> 
> Well, the patch doesn't seem to do any harm, but I can't see much of a
> point to it either if zero-length transfers aren't going to be
> allowed...

Well, some wired device might want long delay before first CLK edge.
I think most device do not have such constraint, but ...

Anyway, SPI framework does not reject it.  So I think the controller
driver should accept it unless it is hard to support on that hardware.

> Also, if the length is zero, the driver will end up doing a memset with
> length zero at some point. Is that allowed?

I believe memset() with zero length should be allowed.  It seems
ambiguous that dma_sync_single_for_device() with zero length is legal
or not.  Actually, it seems OK on ARM and AVR32.

---
Atsushi Nemoto

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
