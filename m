From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Mon, 4 Nov 2013 18:33:19 +0100
Message-ID: <18639D9A-630E-44F3-AA7A-ADFF5D5E8B56@sperl.org>
References: <F70C4469-6325-48D5-A7CA-52CC1FC404BD@sperl.org> <CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg@mail.gmail.com> <CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig@mail.gmail.com> <06C7F4D3-EC91-46CF-90BE-FC24D54F2389@sperl.org> <02BFF0F6-3836-4DEC-AA53-FF100E037DE9@sperl.org> <20131030171902.GL2493@sirena.org.uk> <8D8B0BAD-0E00-4147-B4C8-FBB18F060C96@sperl.org> <20131030215716.GV2493@sirena.org.uk> <3342FD19-4438-463B-89B2-A83D3475AC22@sperl.org> <20131031001004.GW2493@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131031001004.GW2493-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi!

(after some emails that went offline)
I have created the "prepared" message interface for the spi-bcm2835dma driver
on the 3.10 kernel I am working off right now. 
(so I had to do a bit of "linking" trickery)

So here a link of an example showing how much the prepared spi_messages 
really can improve the SPI thruput - even without changing anything
(besides) preparing the messages for direct DMA use.

http://www.raspberrypi.org/phpBB3/viewtopic.php?f=44&t=19489&p=448328#p448328
The link goes to the RPI forum and includes the measurements plus some images
showing both cases (configured via a module parameter for now)

Quick summary:
For my test-usecase by just enabling "prepared messages" I have reduced the 
time  for a "simple" transfer from 390us (without prepare) to 230us (with
prepare) and the driver is still using the threaded message_pump.

OK - the "default" spi-bcm2835.c driver currently in the mainline takes 245us
for the same thing, but it runs at 130k interrupts/s and 95% System load, 
which is quite impractical to do anything else.
So getting this down to 80% System load plus shorter responses is already
quite an improvement. 

It is a drawback hat DMA driver needs more overhead for the unprepared 
spi-message case. But then if the driver that is perfromance critical
does not make use of prepared messages yet and there is a performance issue,
then it needs to get modified to call spi_prepare message during setup. 

Anyway, if a driver cares about thru-put, it better avoids allocating 
new memory to create (and release)  an SPI message in the interrupt handler 
or callback in the first place.
Then adding the single extra statement to prepare and unprepare the message
comes cheap.

There is one hard assumptions:
each and every xfer has to be configured with a DMA-address for source
and destination (unless NULL)
Obviously the message is "static" as soon as prepare has been called.

Otherwise the overhead for iterating the messages and calling
dma_(un)map_single becomes the limiting factor and the difference in code 
(compared to creating the whole chain from scratch) is minimal besides 
additional allocations for the memory - we have to "walk", we have to parse,
...

(also think about how it works if memory itself is fragmented on the bus 
address then - depending on the alignment of data a different amount of 
DMA-transfers would be needed - thus it seems quite impractical to implement)

So from my experience I would recommend adding something like this to spi.h, 
so that it can get used for real and not export-linked way, like I had to do it
for this proof of concept.

static int bcm2835dma_spi_prepare_message(struct spi_device *spi,
	struct spi_message *msg)
{
	if(spi->prepare_message) {
		return spi->prepare_message(spi,msg);
	} else {
		return 0;
	}
}
static int bcm2835dma_spi_unprepare_message(struct spi_device *spi,
	struct spi_message* msg)
{
	if(spi->unprepare_message) {
		return spi->unprepare_message(spi,msg);
	} else {
		return 0;
	}
}

and finally also some management functionality for "finding" those prepared 
messages - better to implement something and making it opaque,
then every driver implementing its own thing and then having to track that.
Already my mcp2515a driver is allocating something like 14 prepared messages 
already, so walking that list is not as expensive, but at some point a binary
tree might be better from the performance-perspective 


struct spi_prepared_message {
        /* the list in which we store the message */
        struct list_head prepared_list;
        /* the identification data for matching */
        struct spi_device *spi;
        struct spi_message *message;
};

something like this:
struct list_head prepared_messages_list;
plus a spinlock protecting the above in spi_master

and the following prototypes:
static struct spi_prepared_message *spi_find_prepared_message_nolock(
        struct spi_device *spi,
        struct spi_message *message);
static struct spi_prepared_message spi_find_prepared_message(
        struct spi_device *spi,
        struct spi_message *message);
static int spi_add_prepared_message(
        struct spi_prepared_message * prepared);
static struct spi_prepared_message *spi_remove_prepared_message(
        struct spi_device *spi,
        struct spi_message *message);

I got the above prototypes implemented (but with the data sitting in the 
master-private data structure, so I am not sure if it is worth sharing them)

Maybe we can get those into the "next" tree so that it can get pulled into 3.13?

Thanks,
	 Martin

P.s:
Note: I have not switched to the dmaengine interface for the driver.
There are too many things needed for me to learn to make that switch now.
Also (as far as Mark said during our offline discussions) there seem to be some 
gaps that would require extending the DMA engine, which would making the driver 
work at first hard. Finally I fear (from my limited knowledge) that scheduling 
via the DMA engine itself would require a prepare and also I would have to keep 
up with double allocations to link everything in place further reducing the 
"thruput" for the case of non-prepared drivers.

The driver itself can get found at: https://github.com/msperl/spi-bcm2835


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
