From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Fwd: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Tue, 29 Oct 2013 09:59:23 -0700
Message-ID: <CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig@mail.gmail.com>
References: <F70C4469-6325-48D5-A7CA-52CC1FC404BD@sperl.org>
	<CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Let us discuss this on the new mailing list, BTW.

On Mon, Oct 28, 2013 at 11:42 AM, Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org> wrote:

> (... ) I thought of moving away from spi_transfer_one_message and back to
> the simpler transfer interface, where the preprocessing would get done
> (DMA control block-chain generation) and then appending it to the
> existing (possibly running) DMA chain.

OK quite a cool idea.

But I hope that you have the necessary infrastructure using the dmaengine
subsystem for this, or that changes requires will be proposed to that
first or together with these changes.

As you will be using dmaengine (I guess?) maybe a lot of this can
actually be handled directly in the core since that code should be
pretty generic, or in a separate file like spi-dmaengine-chain.c?

> But just yesterday I was looking thru the code and came to the message:
> "master is unqueued, this is depreciated" (drivers/spi/spi.c Line 1167).
> This came in with commit ffbbdd21329f3e15eeca6df2d4bc11c04d9d91c0 and got included in 3.4.
>
> So I am wondering why you would depreciate this interface

Simply because none of the in-kernel users was doing what you are
trying to do now. And noone said anything about such future usecases,
so how could we know?

> Now this brings me to different question:
> Could we implement some additional "functions" for preparing
> an SPI message (...)
> The interface could looks something like this:
> int spi_prepare_message(struct_spi_dev*, struct spi_message *);
> int spi_unprepare_message(struct_spi_dev*, struct spi_message *);

Maybe? I cannot tell from the above how this would look so
I think it is better if you send a patch showing how this improves
efficiency.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
