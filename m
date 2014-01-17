From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v4 0/7] mtd: spi-nor: add a new framework for SPI NOR
Date: Fri, 17 Jan 2014 10:02:28 +0800
Message-ID: <20140117020226.GB27652@shlinux2.ap.freescale.net>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
 <CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com>
 <52D7A237.8@freescale.com>
 <CAD6G_RRNg-uRtKnnVgJYpUGPsKecAUm9mwETVJsCsaGSuL2eCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, <angus.clark-qxv4g6HH51o@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Jagan Teki <jagannadh.teki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD6G_RRNg-uRtKnnVgJYpUGPsKecAUm9mwETVJsCsaGSuL2eCw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Jan 16, 2014 at 03:09:13PM +0530, Jagan Teki wrote:
> >>>     After this patch, the layer is like:
> >>>                     MTD
> >>>           ------------------------
> >>>                    spi-nor
> >>>           ------------------------
> >>>                    m25p80
> >>>           ------------------------
> >>>                 spi bus driver
> >>>           ------------------------
> >>>                 SPI NOR chip
> 
> Just for looking on your new framework, is that above link correct.
> I guess it should be MTD -- m25p80 -- spi-nor -- spi bus driver -- SPI NOR chip

I do not think so.
The spi-nor layer does not contact with the spi bus driver directly.

> >> 3) Can you explain your framework precisely take an example of like
> >> spi_controller_A with spi_flash_A
> >> and qspi_controller_B and qspi_flash_B - how will this new framework
> >> operates.
> >>
> > The framework is just cloned from the m25p80.c, and extract the common code,
> > and provides more
> > hooks such as
> >
> > @prepare/unpreare: used to do some work before or after the
> >              read/write/erase/lock/unlock.
> >     @read_xfer/write_xfer: We can use these two hooks to code all
> >              the following hooks if the driver tries to implement them
> >              by itself.
> >     @read_reg: used to read the registers, such as read status register,
> >              read configure register.
> >     @write_reg: used to write the registers, such as write enable,
> >              erase sector.
> >     @read_id: read out the ID info.
> >     @wait_till_ready: wait till the NOR becomes ready.
> >     @read: read out the data from the NOR.
> >     @write: write data to the NOR.
> >     @erase: erase a sector of the NOR.
> >
> 
> My basic question is like I have a qspi spi controller in my SOC and I
> designed two boards B1 and B2

okay.

> B1 with quad spi controller connected with non-flash as a slave and B2
> with quad spi controller connected
> with quad flash as a slave.
You can use the framework for B2. But for B1, you should not use the framework,
since this framework is just for the SPI-NOR. If you do not connected with
a NOR, i think it's better to code another driver for your controller.

thanks
Huang Shijie


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
