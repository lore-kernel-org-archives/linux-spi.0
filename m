From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: spi_imx imx31-cspi.0: master is unqueued, this is deprecated
Date: Fri, 27 Apr 2012 14:49:35 +0200
Message-ID: <CAKnu2MrUQxEMWZMhnLCeeJ=9nRyAoZVoZk6BQdJsN0roOEdhLg@mail.gmail.com>
References: <CAOMZO5Az3jC6Tn+z5P8W4vudMS0EeqJMYcKMKySMrsQfJdbb2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAOMZO5Az3jC6Tn+z5P8W4vudMS0EeqJMYcKMKySMrsQfJdbb2w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2012/3/26 Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:

> On a mx31pdk board (which uses spi-imx driver) I get the following
> message running linux-next:
>
> spi_imx imx31-cspi.1: probed
> spi_imx imx31-cspi.0: master is unqueued, this is deprecated
> l4f00242t03 spi0.0: Epson l4f00242t03 lcd probed.
> spi_imx imx31-cspi.0: probed

It's great that this message has the intended effect :-)

> What is the correct way to queue the master and avoid such warning?

The new centrally queued interface is documented in
Documentation/spi/spi-summary
under the heading "SPI MASTER METHODS"

Basically you need to remove the use of the .transfer callback, do not
even assign it a function, and instead rely on these:

    master->prepare_transfer_hardware(struct spi_master *master)
        This will be called by the queue mechanism to signal to the driver
        that a message is coming in soon, so the subsystem requests the
        driver to prepare the transfer hardware by issuing this call.
        This may sleep.

    master->unprepare_transfer_hardware(struct spi_master *master)
        This will be called by the queue mechanism to signal to the driver
        that there are no more messages pending in the queue and it may
        relax the hardware (e.g. by power management calls). This may sleep.

    master->transfer_one_message(struct spi_master *master,
                                 struct spi_message *mesg)
        The subsystem calls the driver to transfer a single message while
        queuing transfers that arrive in the meantime. When the driver is
        finished with this message, it must call
        spi_finalize_current_message() so the subsystem can issue the next
        transfer. This may sleep.

This involves deleting the custom local queuing in the driver.

However it seems like the i.MX driver is using bitbanging, which means
you could test  Guennadi Liakhovetski's patch converting the bitbang
driver to the central queue.

See subject "[PATCH] spi: bitbang: convert to using core message queue",
consider providing a Tested-by: tag to Guennadi if it works for you.

Yours,
Linus Walleij

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
