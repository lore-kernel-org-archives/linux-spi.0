From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Mon, 4 Nov 2013 22:43:03 +0100
Message-ID: <5A55A832-5313-499C-A483-BF5A6649D69D@sperl.org>
References: <CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg@mail.gmail.com> <CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig@mail.gmail.com> <06C7F4D3-EC91-46CF-90BE-FC24D54F2389@sperl.org> <02BFF0F6-3836-4DEC-AA53-FF100E037DE9@sperl.org> <20131030171902.GL2493@sirena.org.uk> <8D8B0BAD-0E00-4147-B4C8-FBB18F060C96@sperl.org> <20131030215716.GV2493@sirena.org.uk> <3342FD19-4438-463B-89B2-A83D3475AC22@sperl.org> <20131031001004.GW2493@sirena.org.uk> <18639D9A-630E-44F3-AA7A-ADFF5D5E8B56@sperl.org> <20131104184511.GR2493@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131104184511.GR2493-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

I just found out that I am in a chicken or egg situation:
There is no DMA support whatsoever in the upstream RPI support.
So sending any patches for spi with DMA becomes impossible right now.

Setting up a system that runs the upstream kernel without patches will be 
some effort on my side so that may take quite some time for me to start.

Until then I will need to "work" with the tainted kernel and APIs from the
foundation using their special APIs, which you obviously can not accept 
for moving them upstream.

That is why I just wanted to share with you what may get achieved with your 
new interface and what is missing from my perspective to make it work in
a practical manner. 

And that is why I have added only the link to the driver.

I am in a sort of situation that makes it hard to move in either direction.

I believe we all got our interests:
* you want your prepared interface tested in a driver
* I want to get the spi-dma driver in the main-line
* some other people want the dma engine work to get started for the RPI,
  so that they can get to real productive work on USB and others.

All I can give you right now is the feedback from my experience with this out 
of kernel driver, which is not a candidate for merging in its current state 
due to limitations mentioned above.

The results look promising and will improve further!

The only thing I can think of that would help me (and others) in the long 
run is getting those missing parts of your prepare API into the kernel 
early to avoid code duplication (see earlier email with the basics).

By then I may have the driver up and running quite well on the Foundation RPI 
kernel and hopefully some people should also have tested it with more devices.

As soon as that is stable and I get a "vanilla" kernel running with the 
improvements I had recommended from my experience, I can start some basics 
of dmaengine for the RPI (allocation and release DMA to start keeping 
everything else in the driver for now) and then we can really start talking 
about patches for the spi-driver to send.

again: first the dma-engine part would need to be upstream before I assume
you would accept to merge the driver, as the functionality would NOT work
otherwise. So we talk about 3.15 at the very earliest...

So is the presented idea an approach to move forward on?
Or do you have a better approach which we could follow to get us out of this 
tie?

Thanks,
	Martin

P.s: here the pieces of code for which I have earlier only shown the 
prototypes - these are untested and I am not sure they will even compile as
is because I had to modify the driver specific version here in this email
to make them work with the list/lock variables in the master-structure - the 
driver specific code works. Also no documentation for the functions.

That is the best I can do for now.

/* generic wrapper functions for device drivers to use */
static int bcm2835dma_spi_prepare_message(struct spi_device *spi,
	struct spi_message *msg)
{
	if(spi->master->prepare_message) {
		return spi->master->prepare_message(spi,msg);
	} else {
		return 0;
	}
}

static int bcm2835dma_spi_unprepare_message(struct spi_device *spi,
	struct spi_message* msg)
{
	if(spi->master->unprepare_message) {
		return spi->master->unprepare_message(spi,msg);
	} else {
		return 0;
	}
}

in struct spi_master
/* note that it misses initialization for those two fields */
	struct list_head	prepared_messages_list;
	spinlock_t		prepared_messages_lock;

/* functions used to store/find/remove prepared objects 
 * for now putting them in a simple list.
 * only bus drivers should call these really in their (un)prepare code
 * later on it may be worthwhile changing this structure to
 * be in a binary tree - the big question is: how many prepared messages
 * may we expect on a single SPI bus?
 * alternatively we could also move it of to the spi_device structure.
 */

/* the structure to embed in the bus specific implementation */
struct spi_prepared_message {
	/* the list in which we store the prepared messages */
	struct list_head prepared_list;
	/* the identification data for searching the list*/
	struct spi_device *spi;
	struct spi_message *message;
	/* maybe some search-statistics, so that we can reorder/optimize
	 * the list to make the searches for the most commonly used 
	 * messages faster by being in "front"
         */
};

static struct spi_prepared_message *spi_find_prepared_message_nolock(
        struct spi_device *spi,
        struct spi_message *message)
{
        struct spi_master *master=spi->master;
        /* ideally this would be in master */
        struct spi_prepared_message *prepared;
        /* now loop the entries */
        list_for_each_entry(prepared, &master->prepared_messages_list, prepared_list) {
                /* if we match, then return */
                if ((prepared->spi==spi)
                        && (prepared->message==message))
                        return prepared;
        }
        /* return not found */
        return NULL;
}

static struct spi_prepared_message *spi_find_prepared_message(
        struct spi_device *spi,
        struct spi_message *message)
{
        struct spi_prepared_message *prepared;
        struct spi_master *master=spi->master;
        unsigned long flags;
	/* lock */
        spin_lock_irqsave(&master->prepared_messages_lock,flags);
        /* try to find it */
        prepared=spi_find_prepared_message_nolock(spi,message);
        /* and unlock and return */
        spin_unlock_irqrestore(&master->prepared_messages_lock,flags);
        return prepared;
}

static int spi_add_prepared_message(
        struct spi_prepared_message * prepared)
{
        struct spi_device *spi=prepared->spi;
        struct spi_master *master=spi->master;
        struct spi_message *message=prepared->message;
        unsigned long flags;
	/* lock */
        spin_lock_irqsave(&master->prepared_messages_lock,flags);
        /* find the entry and croak if it has beeen prepared before */
        if (spi_find_prepared_message_nolock(spi,message)) {
	        spin_unlock_irqrestore(&master->prepared_messages_lock,flags);
                dev_err(&spi->dev,"SPI message has already been prepared once\n");
                return -EPERM;
        }
        /* now add it to the list at tail*/
        list_add_tail(&prepared->prepared_list,&master->prepared_messages_list);

        /* unlock and return */
        spin_unlock_irqrestore(&master->prepared_messages_lock,flags);
        return 0;
}

struct spi_prepared_message *spi_remove_prepared_message(
        struct spi_device *spi,
        struct spi_message *message
        )
{
        struct spi_prepared_message *prep=NULL;
        struct spi_master *master=spi->master;
        unsigned long flags;
	/* lock */
        spin_lock_irqsave(&master->prepared_messages_lock,flags);
	/* find the entry */
        prep=spi_find_prepared_message_nolock(spi,message);
        /* now unlink the prepared item - if found  - we could croak otherwise */
        if (prep) {
                list_del(&prep->prepared_list);
	} else {
                dev_err(&spi->dev,"SPI message has not been prepared\n");
	}
        /* unlock and return the version removed from the list*/
        spin_unlock_irqrestore(&master->prepared_messages_lock,flags);
        return prep;
}


On 04.11.2013, at 19:45, Mark Brown wrote:

> On Mon, Nov 04, 2013 at 06:33:19PM +0100, Martin Sperl wrote:
> 
>> The driver itself can get found at: https://github.com/msperl/spi-bcm2835
> 
> Please post code/patches normally rather than linking to git, it's much
> less likely that people will look at some random gitweb thing and much
> harder to respond.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
