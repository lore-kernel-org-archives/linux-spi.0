From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi/pxa2xx: Clear cur_chip pointer before starting next
 message
Date: Fri, 5 Dec 2014 10:24:29 +0200
Message-ID: <20141205082429.GF1306@lahna.fi.intel.com>
References: <1417425166-150374-1-git-send-email-mika.westerberg@linux.intel.com>
 <87egsfyvsd.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Martin Oldfield <m@mjoldfield.com>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87egsfyvsd.fsf-GANU6spQydw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Dec 04, 2014 at 10:01:06PM +0100, Robert Jarzmik wrote:
> Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
> 
> > Once the current message is finished, the driver notifies SPI core about
> > this by calling spi_finalize_current_message(). This function queues next
> > message to be transferred. If there are more messages in the queue, it is
> > possible that the driver is asked to transfer the next message at this
> > point.
> >
> > When spi_finalize_current_message() returns the driver clears the
> > drv_data->cur_chip pointer to NULL. The problem is that if the driver
> > already started the next message clearing drv_data->cur_chip will cause
> > NULL pointer dereference which crashes the kernel like:
> ..zip..
> > Fix this by clearing drv_data->cur_chip before we call
> > spi_finalize_current_message().
> 
> So with your change, we have :
>   	drv_data->cur_chip = NULL;
> 	spi_finalize_current_message(drv_data->master);
> 
> In that case, if spi_finalize_current_message() queues another message, upon
> this next message completion, won't giveback() be called, and dereference
> cur_chip as well ?

When the next message is started pxa2xx_spi_transfer_one_message() gets
called and that will set cur_chip again.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
