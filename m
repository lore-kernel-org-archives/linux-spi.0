From: Anton Habegger <anton.habegger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Patch to parameterize =?utf-8?b?RE1BX01JTl9CWVRFUw==?= for omap2-mcspi
Date: Tue, 31 May 2016 05:03:16 +0000 (UTC)
Message-ID: <loom.20160531T063517-415@post.gmane.org>
References: <1426741501.10003.6.camel@midgaarde>	<550AC256.4070509@ti.com>	 <CAAQQ3un3k-0nY8xaOXKbmCznOk69ZEhbWLd5ZZV1_=rQLOyspg@mail.gmail.com>	 <550AF7F6.7080200@ti.com> <1426786080.13824.23.camel@symus-gk-mint> <550C1979.5030208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi

I'm interessted about the state of the patch? 
I have a similar situation with a am3352 device and 10kHz SPI 
transfer. (Kernel version 4.1) The number of bytes to transfer are 
in between of 3 and 30. The SPI  worker thread occupies the CPU 
with ~60% load. With a DMA_MIN_BYTES = 10, the CPU load will be 
reduced to 10%, which is still to much in my opinion.

Are there other workarounds or options to get rid of busy waits 
with omap2-mcspi?




--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
