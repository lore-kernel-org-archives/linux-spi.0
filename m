From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Wed, 30 Oct 2013 18:11:45 +0100
Message-ID: <F64AD25A-C7EC-4A0D-9169-850C12F4D8A3@sperl.org>
References: <F70C4469-6325-48D5-A7CA-52CC1FC404BD@sperl.org> <CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg@mail.gmail.com> <CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig@mail.gmail.com> <06C7F4D3-EC91-46CF-90BE-FC24D54F2389@sperl.org> <20131029225353.GB11424@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131029225353.GB11424-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


>> But with all that said, I can do a single SPI_MESSAGE with 5 transfers
>> ,  2 of which have CS_CHANGE only with DMA without any interrupts -
>> besides the final interrupt to trigger the wakeup of the
>> spi_message_pump thread.
> 
> How exactly does this work in concrete terms?  I'm particularly
> interested in how the /CS manipluation is done.  The basic idea doesn't
> sound terribly different to things a lot of devices can do with driving
> the transfers from the IRQ handler (possibly hard IRQ handler) without
> waking the tasklet, I'd hope we can make this work as a special case of
> that.
> 

Essentially what the DMA-looks like is :
* if clock_divider changed:
   Write 4 byte to CS-register config resetting TX/RX
* Write 4 byte to CS-register config resetting TX/RX
* write 4 byte to LEN-register configuring length of the next transfer
* write 4 bytes to CS-register setting up the transfer via DMA (for the length above)
* Write to DMA-RX-Controlblock the next "target" Controlblock for the RX-DMA
* Write to DMA-RX-Controlregister to start DMA reading the next control-block
* Add the following transfers in an inner loop
    adding similar transfers to the RX/TX DMA queues until we are 
   reaching the end of xfers
   or we reach a reconfigured xfer (Cs_change,delay_us)
   speed_hz is slightly different - we need to do a look-ahead in that case
   and abort as well
*Note here the TX queue stopps after the last transfer 
  - we continue on the RX DMA chain
* schedule some "idle" DMA cycles to RX queue to wait until the clock is finished
* if delay_usec is reached schedule some more idle cycles to RX queue
* if cs_change write 4 bytes to CS-register resetting the "transfer flags
  also add some idle cycles so that CS does stay high for half a clock cycle
* Write to DMA-TX-Controlblock the next "target" Controlblock for the TX-DMA
* Write to DMA-TX-Controlregister to start DMA reading the next control-block
* Create a transfer that keeps us informed which message, which transfer
   and how many bytes we have transferred
* if not finished and there are more xfers go back to the first step
* last message gets the send IRQ flag as a final step
  (if callback is set on the message)

So it is a bit complicated, but this is the way it works in principle and this is why
I need some CPU cycles to set it up - and for some of those little more 
complicated messages i need a total of about 60 control-blocks.
But - hey: it works!
And it is the reason why I am asking for a "prepared" SPI-message option
to reduce this kind of overhead and get down to "real" transfer costs that are 
handled by HW...

I believe in most drivers, spi_messages are potentially "prerendered"
if speed is important and are not created and torn down every time.
Otherwise - setting up the spi message itself becomes very computationally
intensive...

So adding this additional call "spi_message_prepare" would come cheap...


>> As for the prepare_spi_message - I was asking for something different
>> than prepare_transfer_hardware (unless there is new code there in 3.12
>> that already includes that - or it is in a separate tree).
> 
> You should be working against the latest development code, we're almost
> at the merge window for v3.13, the v3.12 code is about 3 months old at
> this point.  Also bear in mind that this is open source, you can extend
> the frameworks if they don't do what you want.

That is a bit more effort for me - if the RPI came with upstream code already,
then it would be much easier, but it does not...
Device-tree came just before the RPI tree could get integrated, so I am left 
somewhat behind, because my main project relies on things that are not 
upstream and might take a long (RPI camera,...)

Still I want to get these things upstream, because I hope that it will
eventually happen...

So I will try to write this "spi_message_prepare interface" and provide a patch 
for inclusion, so that it may filter down again to the RPI in due time...

Ciao,
	Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
