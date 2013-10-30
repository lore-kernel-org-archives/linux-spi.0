From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Wed, 30 Oct 2013 19:33:30 +0100
Message-ID: <8D8B0BAD-0E00-4147-B4C8-FBB18F060C96@sperl.org>
References: <F70C4469-6325-48D5-A7CA-52CC1FC404BD@sperl.org> <CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg@mail.gmail.com> <CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig@mail.gmail.com> <06C7F4D3-EC91-46CF-90BE-FC24D54F2389@sperl.org> <02BFF0F6-3836-4DEC-AA53-FF100E037DE9@sperl.org> <20131030171902.GL2493@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131030171902.GL2493-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

I have seen your email and I have checked 3.12-rc7:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/spi/spi.h?id=refs/tags/v3.12-rc7
(Assuming this is the latest, but I would say that the version of Linus would 
be authoritative)

What I have found is:
int (*prepare_transfer_hardware)(struct spi_master *master);

This one I have mentioned before, but this does prepare the hardware 
(spi_master) prior to every time we  start after an empty queue, 
which does NOT do what I was asking for.
It is useful for starting up clocks and other power-management tasks...

It does not prepare a spi_message once allowing it to get processed faster
on calls to spi_async(...)!

So can you tell me which interface you are talking about that is supposed 
to be in the mainline, which would solve my needs?

I would need an interface addition similar in intent to this:

The following would go into struct spi_master:
  int (*prepare_message)(struct spi_device *dev,struct spi_message *mesg);
  int (*unprepare_message)(struct spi_device *dev,struct spi_message *mesg);

static int spi_message_prepare(struct spi_device *spi, struct spi_message* msg) {
  return (dev->master->prepare_message)? 
    dev->master->prepare_message(spi,msg):0;
}

static int spi_message_unprepare(struct spi_device *spi, struct spi_message*msg) {
  return (dev->master->unprepare_message)? 
    dev->master->unprepare_message(spi,msg):0;
}

Plus some additional information in spi_message similar to this:
  void *prepared;
  struct spi_driver *prepared_for_device; 

The second more to avoid "problems" when drivers prepare for one spi-device 
and then use it on a different SPI device - mostly to croak about misuse of the 
prepared message... If this field is in there, then the "unprepare" call  could even 
do without the argument for SPI_device, as it would be already stored in 
the message itself...

Thanks,
		Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
