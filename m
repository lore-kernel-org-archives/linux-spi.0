From: mrnuke <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] v1 ARM: sun4i: spi: Allow Rx transfers
 larger than FIFO size
Date: Wed, 19 Mar 2014 13:03:45 -0500
Message-ID: <29069269.5VPQtL8a7I@nukelap.gtech>
References: <2167943.Zs1zPAMITN@nukelap.gtech> <20140319165507.GJ27873@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBDGJVA6QWUDRBBNYU6MQKGQE52SI75Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140319165507.GJ27873@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

On Wednesday, March 19, 2014 05:55:07 PM Maxime Ripard wrote:
> Hi,
> 
> Thanks for working on this.
> 
> I have a few general comments first:
>   - Use a decent mailer for your patches. [...]
>   - The vX should be between the brackets, [...]
OOPS

>   - Those two patches should be merged together. [...]
Sure.

> > -	/* We don't support transfer larger than the FIFO */
> > -	if (tfr->len > SUN4I_FIFO_DEPTH)
> > +	if (tfr->len > SUN4I_MAX_XFER_SIZE)
> > +		return -EINVAL;
> 
> Why do you still need this test?
> 
SUN4I_MAX_XFER_SIZE is not the FIFO size. It is the max number we can write in 
SUN4I_BURST_CNT_REG. That's the maximum SPI burst size (16 MiB - 1) that the 
hardware supports. Anything larger, and we'd need to break up the transfer in 
several bursts. That's a different problem than the one I'm addressing.

> > -	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> > +	/* FIFO is drained during the interrupt handler */
> 
> Then don't mention it.
> 
Got it, boss.

> > +	/* Receive FIFO 3/4 full */
> > +	if (status & SUN4I_INT_CTL_RF_F34) {
> > +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> > +		/* Only clear the interrupt _after_ draining the FIFO */
> > +		sun4i_spi_write(sspi, SUN4I_INT_STA_REG,
> > SUN4I_INT_CTL_RF_F34);
> 
> Not that it's important, but it really doesn't matter to do it before
> or after, the interrupts are disabled in the handler.
> 
I think this was one of those bits that keeps being set by hardware until the 
Rx FIFO is under 48 bytes (less than 3/4 full).  I'll have to look into this 
again.

Alex
