From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 1/4] max3100: added raise_threaded_irq
Date: Fri, 16 Apr 2010 01:22:23 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004160110360.3625@localhost.localdomain>
References: <cabda6421003230329w3fe596dbn8e4b37cc36118f9f@mail.gmail.com> <1269340105-6503-1-git-send-email-chripell@fsfe.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: feng.tang@intel.com, akpm@linux-foundation.org, greg@kroah.com,
	david-b@pacbell.net, grant.likely@secretlab.ca,
	alan@lxorguk.ukuu.org.uk, spi-devel-general@lists.sourceforge.net,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
To: Christian Pellegrin <chripell@fsfe.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1269340105-6503-1-git-send-email-chripell@fsfe.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 23 Mar 2010, Christian Pellegrin wrote:

> raise_threaded_irq schedules the execution of an interrupt thread

I really have a hard time to understand _WHY_ we want to have that
function.

Interrupt threads are woken up either by the primary handler or by a
interrupt demultiplexer and the code has all interfaces for that
already.

Can you please explain, what you are trying to achieve and why it
can't be done with the existing interfaces ?

> +
> +/**
> + *	raise_threaded_irq - triggers a threded interrupt
> + *	@irq: Interrupt line to trigger
> + */
> +int raise_threaded_irq(unsigned int irq)
> +{
> +	struct irq_desc *desc = irq_to_desc(irq);
> +	struct irqaction *action;
> +
> +	if (!desc)
> +		return -ENOENT;
> +	action = desc->action;

That's racy. You cannot access desc->action w/o holding desc->lock or
having set the IRQ_INPROGRESS flag in desc->status under desc->lock.

> +	if (!action)
> +		return -ENOENT;
> +	if (unlikely(!action->thread_fn))
> +		return -EINVAL;
> +	if (likely(!test_bit(IRQTF_DIED,
> +			     &action->thread_flags))) {
> +		set_bit(IRQTF_RUNTHREAD, &action->thread_flags);
> +		wake_up_process(action->thread);
> +	} else {
> +		return -ECHILD;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(raise_threaded_irq);

EXPORT_SYMBOL_GPL if at all.

Aside of that the name of of the function sucks: irq_wake_thread()
perhaps ?

But I still have no idea why we would need it at all.

Thanks,

	tglx
