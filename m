From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 4/4] MMC-over-SPI host driver
Date: Fri, 15 Jun 2007 20:26:13 +0200
Message-ID: <4672D9C5.9080707@drzeus.cx>
References: <200706101257.45278.david-b@pacbell.net>
	<200706101308.07910.david-b@pacbell.net>
	<46704637.2090309@drzeus.cx>
	<200706132105.51711.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706132105.51711.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David Brownell wrote:
> 
> There were other cases, as I recall.  Maybe the core has changed
> so much that some of them are no longer needed.  I removed as
> many as seemed safe.
> 

Which are left? I doubt they are needed.

> 
> Unless CRCs will always be on -- implying a significant performance
> penalty on the kind of platform which *most* needs the MMC-over-SPI
> support! -- ISTR that it's not optional; GO_IDLE always needs a CRC,
> even if other requests don't use one.  That's why the specs list that
> CRC explicitly.
>  

Since it depends unconditionally on CRC7, you will always be able to calculate
that in runtime.

And in order for the host to know when to calculate it, I suggest another feel
to the ios structure. And drop the CAP_CRC, we'll consider CRC support mandatory
(even though you can have the option of turning it off in runtime).

> 
> Not the MINI timeout, for sure.  Maybe some of the others.
> (MINI should actually be 1..8 bytes, not N msec.)
> 
> The whole issue of timeouts needs investiation still ...
> like, does the core even understand them right (for SPI).
> 

Probably not. So add it. ;)

> 
> What do you mean by that?  It can't be "static", since such memory
> is not generally DMA-safe.  Maybe the pointer could be static; but
> each device would need its own DMA mapping; and there will usually
> be more than one of these per system, so I can't see much need to
> share that buffer between host/card instances.
> 

I didn't check how much data was in that thing, but it feels wrong not to share
memory when we know it's read-only.

>> Didn't you tweak the block driver to not send MMC_STOP_TRANSMISSION?
> 
> Only for writes.  Reads still use this.  (Writes use a lowlevel
> token replacing the normal next-block token.)
> 

You should trigger on it being data->stop, not on the opcode. Again, for forward
compatibility.

> 
> As noted in a previous reply (which you've not yet seen):
>   (a) Because the MMC core relies on it to do so, and
>   (b) Because otherwise diagnostics report CMDx instead of ACMDx.
> 

(a) should go away and (b) can be moved to the core.

> You didn't comment on the mapping applied to cmd->resp[0] ...

I thought you were going to remove all of them, but it seems I misunderstood.
The host driver shouldn't try to fake being a native controller as that will
come back to bite us in the ass eventually when we find some odd corner case.
Report the true SPI stuff up to the core and modify the core to understand it.

>>> +
>>> +	/*
>>> +	 * If this was part of a successful request with a stop-part,
>>> +	 * our caller signals the request as done.
>>> +	 */
>>> +	if (status == 0 && mrq->stop == NULL)
>>> +		mmc_request_done(host->mmc, mrq);
>>> +	return status;
>>> +}
>> I assume the comment should have read "without".
> 
> No; this handles the request_done() for success without
> a stop part.  Caller does it otherwise...
> 

Ah, so the comment doesn't describe why this is done, rather it describes why
mmc_request_done() isn't always called here?

Perhaps a rewording is in order as it has already confused at least one person. :)

> 
>>> +
>>> +static inline int resp2status(u8 write_resp)
>>> +{
>>> +	switch (SPI_MMC_RESPONSE_CODE(write_resp)) {
>>> +	case SPI_RESPONSE_ACCEPTED:
>>> +		return 0;
>>> +	case SPI_RESPONSE_CRC_ERR:
>>> +		/* host shall then issue MMC_STOP_TRANSMISSION */
>>> +		return -ECRC;
>> What's with the made-up errno?
> 
> Readability.
> 

Not sure it helps in that area. Many will get confused by an errno they do not
recognize.

>  
>> We should check what other parts of the kernel uses for CRC errors.
> 
> If you can find some convention for CRC errors, this can change;
> otherwise that won't matter, since only *this* code cares.
> 

I'm a neat freak. ;)

Won't EILSEQ do?

> The MMC layer seems to only use the MMC-internal status codes.
> (Which is a different issue ... that's generaly frowned upon.)
> 

I know, it's part of the baggage I got when I took over. It's on my todo list to
get rid of those codes. They've been annoying the hell out of me.

>> multiple = (cmd->data->blocks > 1)
> 
> Can that now be relied upon?  The reason it was coded this way
> (and likewise for writes) was that previously that was NOT true.
> 
> I recall trying that at some point, and watching lots of
> stuff break...
> 

I don't know your exact meaning of "multiple" here, but if it means "more than
one block", then checking the block count is the correct way.

> 
> Actually it'd be best if we never saw highmem.  Fortunately that
> conceptual abortion doesn't is rare (to the point of nonexistence)
> on platforms which use this.  Maybe the driver should even depend
> on !HIGHMEM, just to be sure.
> 

You can tell the MMC layer that by setting your DMA mask properly.

> 
> I think it's unspecified whether it would hurt.  STOP_TRAN is
> however specified ONLY for those specific protocol messages.
> 

I don't like sticking that information in here. We should code this into the
request somewhere and let the core determine which opcodes needs it.

> I suspect you need to rethink how you're viewing this host
> driver a bit ... it implements low level protocols, and as
> such it can't avoid understanding relevant facts.  Offloading
> high level protocol stuff to the core is fine.  By analogy,
> link level drivers know about link level issues (STOP_TRAN,
> PPPOE, etc), but not about the packets they encapsulate
> (CMDx, ARP, etc).
> 

I'd say your driver is more like the PHY (with some acceleration like computing
CRC), and the core contains the MAC.

>> If you've set your parameters correct, then this shouldn't be possible. So do a
>> BUG_ON() if you want to have a test.
> 
> Which parameters?

max_blk_size and friends in the host structure.

> 
> The standard kernel policy is to avoid BUG_ON like the plague
> if there's any way to report an error to the upper level code
> and have it proceed.  If the system can proceed, it's not any
> kind of BUG().
> 

WARN_ON() or something then. I'm not saying you should remove your if-clause
(not saying you should keep it either); but the fact is that this is an internal
kernel interface, so giving the wrong parameters is a bug that should be exposed.

>> Sounds like this signaling can be done with the chip select ios already present
>> in the mmc layer. Then we won't need voodoo in the host driver.
> 
> No.
> 

Why not? It would allow us to keep higher protocol semantics (which varying
delays depending on opcodes is after all) in the core.

>> This seems like something that should just be in debug builds.
> 
> Just this sanity check, not both?
> 

Both.

>> A printk() might be nice so the user knows why the switch isn't being respected.
> 
> ISTR that not many of the other drivers do that, at least not there.
> I can update the startup message to say if it has power on/off support.
> 

Just because the other boys are misbehaving doesn't mean you have to. ;)

> 
> Systems without a "native" MMC/SD controller are unlikely to spend
> silicon to put an IOMMU on the SPI controller.  I've seen them
> on a few other controllers ... but that seems to have been a short
> lived experiment, phased out in newer chips.
> 
> And in any case, that's like one page plus one cacheline.  If there
> were an IOMMU, surely it can afford that much overhead.
> 

Not if everyone has that attitude. ;)

It's not an issue I'm going to press, but I though I should point it out at least.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
