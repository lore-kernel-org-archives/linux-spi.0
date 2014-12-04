From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH] spi/pxa2xx: Clear cur_chip pointer before starting next message
Date: Thu, 04 Dec 2014 22:01:06 +0100
Message-ID: <87egsfyvsd.fsf@free.fr>
References: <1417425166-150374-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Martin Oldfield <m@mjoldfield.com>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417425166-150374-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
	(Mika Westerberg's message of "Mon, 1 Dec 2014 11:12:46 +0200")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:

> Once the current message is finished, the driver notifies SPI core about
> this by calling spi_finalize_current_message(). This function queues next
> message to be transferred. If there are more messages in the queue, it is
> possible that the driver is asked to transfer the next message at this
> point.
>
> When spi_finalize_current_message() returns the driver clears the
> drv_data->cur_chip pointer to NULL. The problem is that if the driver
> already started the next message clearing drv_data->cur_chip will cause
> NULL pointer dereference which crashes the kernel like:
..zip..
> Fix this by clearing drv_data->cur_chip before we call
> spi_finalize_current_message().

So with your change, we have :
  	drv_data->cur_chip = NULL;
	spi_finalize_current_message(drv_data->master);

In that case, if spi_finalize_current_message() queues another message, upon
this next message completion, won't giveback() be called, and dereference
cur_chip as well ?

Cheers.

--
Robert
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
