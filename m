From: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: =?utf-8?b?W1JFU0VORF8y?= PATCH 1/3] ARM: sun4i: spi: Allow transfers larger than FIFO size
Date: Fri, 20 Mar 2015 07:11:21 +0000 (UTC)
Message-ID: <loom.20150320T080853-145@post.gmane.org>
References: <118558573.kx0II8vAKN@nukelap.gtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hey all,

mrnuke <mr.nuke.me@...> writes:

> 
> SPI transfers were limited to one FIFO depth, which is 64 bytes.
> This was an artificial limitation, however, as the hardware can handle
> much larger bursts. To accommodate this, we enable the interrupt when
> the Rx FIFO is 3/4 full, and drain the FIFO within the interrupt
> handler. The 3/4 ratio was chosen arbitrarily, with the intention to
> reduce the potential number of interrupts.
> 
> Since the SUN4I_CTL_TP bit is set, the hardware will pause
> transmission whenever the FIFO is full, so there is no risk of losing
> data if we can't service the interrupt in time.
> 
> For the Tx side, enable and use the Tx FIFO 3/4 empty interrupt to
> replenish the FIFO on large SPI bursts. This requires more care in
> when the interrupt is left enabled, as this interrupt will continually
> trigger when the FIFO is less than 1/4 full, even though we
> acknowledge it.

You can have my Tested-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>

Been using it with mmc-spi with great success. Actually it was the only way
to use mmc-spi ;)

I haven't used the other patches in this series, nor looked at them. I've
done a few mmc read and writes (a few mb's) and got good performance to boot
(1.5 - 2 MB/s).

Olliver

> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@...>
> Acked-by: Maxime Ripard <maxime.ripard@...>
> ---
>  drivers/spi/spi-sun4i.c | 71
++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 62 insertions(+), 9 deletions(-)
> 



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
