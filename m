From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/bcm63xx: fix multi transfer messages
Date: Mon, 26 Nov 2012 16:23:18 +0100
Message-ID: <CAOiHx=kdA0m-WZLvATLMdqyTfUnpCemsYt2=QPhbmygFwVZDxA@mail.gmail.com>
References: <1352931747-19893-1-git-send-email-jonas.gorski@gmail.com>
	<CAOiHx==CdCrb5++dsy5GBYpwXLmx3iG2bmpYiqiOuop_JAn9NQ@mail.gmail.com>
	<20121115011504.GA7599@opensource.wolfsonmicro.com>
	<4813771.TBFJ14qpIF@flexo>
	<20121126141005.GJ9411@opensource.wolfsonmicro.com>
	<CAOiHx==ASqkCbJhBQD9JmGn8Z3zE_4Cs+Kjq-5G2VSnP9u2imA@mail.gmail.com>
	<20121126150344.GN9411@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121126150344.GN9411-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 26 November 2012 16:03, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Mon, Nov 26, 2012 at 03:48:55PM +0100, Jonas Gorski wrote:
>> On 26 November 2012 15:10, Mark Brown
>
>> > To be honest I'd rather see this as a preformance optimisation on top of
>> > a generic fix based on something like allocating buffers to linearise.
>
>> Just curious, where do you see a performance optimisation? At least I
>> did not intend to do any.
>
>> The buffers are hardware registers with a fixed length, there is no
>> allocation at all. If it were possible to expand/allocate them I'd
>> gladly do it. So this patch is the attempt to accept as many transfer
>> combinations as possible under these constraints.
>
> That's the problem - you're doing this in a fairly tricky and limited
> way using the hardware features.  I wouldn't want to be sitting trying
> to debug why one of my SPI drivers fails for some subset of I/O
> operations...  for example, if we implement bulk write support for
> register cache sync in regmap then suddenly devices will start failing
> if they end up writing more than N registers in a block during cache
> sync.
>
> At least with the current approach these devices will work at all which
> is much simpler to understand and debug.

No they don't. If you do a spi_write_then_read on this controller with
the current code the following will happen:

controller asserts CS, sends transfer 1 (the write) to device, deasserts CS.
-> device discards response.
controller asserts CS, reads for transfer 2 (the read), deasserts CS.
-> device will not reply, the buffer contains only 0xff's.

I don't see how this patch will make it worse.

Also with the current code writes with more than buffer size would
silently fail, while with my changes they would at least be rejected
so you know that they failed. There is no way of writing or reading
more than that fits into the hardware FIFO buffer in one go. After
having read/written that amount CS will be deasserted. There is no
possiblity of refilling the buffers before it deasserts CS. And this
usually leads to an aborted command if the device expected more data.

>> > Otherwise we're into things like devices mostly working but then falling
>> > over for large transfers which is going to be annoying to debug.
>
>> Unfortunately this is a hardware limitation for which Broadcom does
>> not offer any workarounds (except this combination logic). And there
>> are millions of devices out there; you can't just tell the users
>> "please resolder the CS line so it can be controlled through GPIO. At
>> least not most of them ;-)
>
> Like I've said several times now just linearise everything before you
> talk to the controller which is your second option here...

? This is exactly what I'm trying to do with this patch.

>> All these fail when not using the prepend bytes method or merging the
>> two transfers into one full duplex transfer.
>
> ...and will work for everything at the expsense of being slower due to
> the need to allocate the buffer.

I do not see where you get this "allocate" from. The tx/rx buffers are
hardware registers, always there, with a fixed length, and any data
sent to the SPI device needs to be written there beforehand, then a
"write now" command needs to be issued to a different register.


Jonas

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
