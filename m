From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Wed, 6 Nov 2013 12:28:15 +0100
Message-ID: <844EDAEA-3FDC-48D0-B59E-CECC0A83761E@sperl.org>
References: <06C7F4D3-EC91-46CF-90BE-FC24D54F2389@sperl.org> <02BFF0F6-3836-4DEC-AA53-FF100E037DE9@sperl.org> <20131030171902.GL2493@sirena.org.uk> <8D8B0BAD-0E00-4147-B4C8-FBB18F060C96@sperl.org> <20131030215716.GV2493@sirena.org.uk> <3342FD19-4438-463B-89B2-A83D3475AC22@sperl.org> <20131031001004.GW2493@sirena.org.uk> <18639D9A-630E-44F3-AA7A-ADFF5D5E8B56@sperl.org> <20131104184511.GR2493@sirena.org.uk> <5A55A832-5313-499C-A483-BF5A6649D69D@sperl.org> <20131106094854.GF11602@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131106094854.GF11602-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

I am currently setting up a second RPI for my work on upstream kernels.
This still will take some more time, as I can only access it via a serial
console, as there is no upstream USB driver (which I need for the on-board
network card to work)... 

>> /* generic wrapper functions for device drivers to use */
>> static int bcm2835dma_spi_prepare_message(struct spi_device *spi,
>> 	struct spi_message *msg)
>> {
>> 	if(spi->master->prepare_message) {
>> 		return spi->master->prepare_message(spi,msg);
>> 	} else {
>> 		return 0;
>> 	}
>> }
> 
> Like I said earlier I'm concerned about the idea of drivers calling
> these functions directly, this should all be factored out of drivers
> since there's nothing really driver specific here.


Actually it is VERY driver specific!

The thing is that you can not easily detect if the same spi_message has 
been used and in some way changed without having to walk and compare the
structure to an existing checksum - and such computation would take say 
1/3rd of the time it takes to prepare the message again.

Then if it has been found to be different, you would first need to erase 
the old structure before creating the new one. 

So this kind of heuristics increases the CPU load resulting in 
unnecessary computations at minimal benefits.

So there is the need to "identify" a message somehow as "prepare-able"
(and thus conforming to some restrictions - like the one I had mentioned)
in the driver itself.

If you want to do this via a separate boolean in the spi_message structure
or if you do this by explicitly calling from the driver IMO does not make
much of a difference - the code needs to get optimized for this anyway.

The advantage of the explicit call is that those prepared messages can get 
released immediately when the driver is unloaded.  Otherwise they can only 
get released when the master is unloaded (or some LRU logic).

And if you do not release on driver unload, then in the worsted case you 
could load the driver again and the spi_message would get created in the
same location but the xfers and their pointers might point elsewhere.
And that would _definitely_ be a problem. (You could add cookies,...
but then you would have more computations still.)

For spi_async all the above checks could happen in an IRQ context,
so the code-path should _really_ be optimized!

Anyway: this mostly applies to drivers that need to be fast
and have high thru-put. And those would be the only ones that need
"special" handling. 

For those, that just use the "simple" sync API (variations of 
spi_write_then_read and similar), the framework may already have done the
prepare for its "hot-path" situation.
That way those "simple" drivers can get a benefit as well.

I do not think it is worth coding "complex" heuristics, like
checking X times for a message to be "identical" and only then taking 
the short-cut. That can lead to some very strange situations to debug.
So as far as I am concerned it is better to explicitly say in the driver:
yes we can.

It might be worth thinking of extending the interface for "typical" transfers
cases so that more use-cases get handled automatically (with prepared code).
But that would require reviewing/rewriting existing drivers to make use of 
those interfaces.

Finally: with the preare/unprepare calls in the master structure, the 
thing you risk is that each driver writes is own:
if (master->prepared_message)
	master->prepared_message(spi,message);
so better make that wrapper available...

Ciao,
	Martin

P.s: just looking at __spi_async already gives me some thought:
we are already iterating over the stucture once for the sanity-checks.
And that takes time already - cycles that could be saved for the "prepared"
message case entirely by short-cutting those "sanity-checks" and just call 
master->transfer(spi->message) immediately.

So integrating the "search" for prepared statements here and skipping
the tests in this case would also improve the thru-put...

Otherwise you would risk that a high-thruput driver directly calls
message->spi=spi;master->transfer(spi,message);
to avoid those unnecessary CPU cycles - especially if it is optimized.

Ok, you could reject the patch, but then you would ignore the root cause
WHY people do this!

One way around this could be that you would call a default "prepared"
statement code that would do the checks in the structure.

And that way any driver that does prepare its messages would get the
benefit independent of if the bus driver itself implements prepared 
messages or not.

It could boil down to something like this:
(this would require a flag marking the message as prepared)

static int __spi_sanity_check_message(struct spi_device *spi,
	struct spi_message *message)
{
	/* message sanity check code here */
}

/* set prepared_message to this in spi_register_master,
 * if prepare_message is NULL (not included)
 */
int __spi_prepare_message_default(struct spi_device *spi,
	struct spi_message *message)
{
	int ret=__spi_sanity_check_message(spi,message);
	if (!ret)
		message->is_prepared=1;
	return ret;
}

static int __spi_async(struct spi_device *spi, struct spi_message *message)
{
  int ret=0;
  /* the non prepared path */
  if (! message->is_prepared) {
    /* sanity checks here */
    ret=__spi_sanity_check_message(spi,message);
    if (ret)
	return ret;
  }
  /* and the "normal" call of transfer */
  message->spi = spi;
  message_status = -EINPROGRESS;
  return master->transfer(spi,message);
}

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
