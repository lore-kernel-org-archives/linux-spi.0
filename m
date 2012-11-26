From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/bcm63xx: fix multi transfer messages
Date: Mon, 26 Nov 2012 15:48:55 +0100
Message-ID: <CAOiHx==ASqkCbJhBQD9JmGn8Z3zE_4Cs+Kjq-5G2VSnP9u2imA@mail.gmail.com>
References: <1352931747-19893-1-git-send-email-jonas.gorski@gmail.com>
	<CAOiHx==CdCrb5++dsy5GBYpwXLmx3iG2bmpYiqiOuop_JAn9NQ@mail.gmail.com>
	<20121115011504.GA7599@opensource.wolfsonmicro.com>
	<4813771.TBFJ14qpIF@flexo>
	<20121126141005.GJ9411@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121126141005.GJ9411-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 26 November 2012 15:10, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Mon, Nov 26, 2012 at 02:20:56PM +0100, Florian Fainelli wrote:
>
>> I assume any hardware design which needs specific CS treatment would wire it
>> to a spare GPIO to fully control its assertion.
>
> We're talking about very standard stuff here, not odd corner use cases.

Blame Broadcom engineers. And to top it, they did it again with their
"high speed" SPI controller for their newer chips; I have a driver
ready that will give you a deja vu.

>> Would you accept this patch provided that Jonas updates his commit log with
>> this description of devices we support?
>
> To be honest I'd rather see this as a preformance optimisation on top of
> a generic fix based on something like allocating buffers to linearise.

Just curious, where do you see a performance optimisation? At least I
did not intend to do any.

The buffers are hardware registers with a fixed length, there is no
allocation at all. If it were possible to expand/allocate them I'd
gladly do it. So this patch is the attempt to accept as many transfer
combinations as possible under these constraints.

> Otherwise we're into things like devices mostly working but then falling
> over for large transfers which is going to be annoying to debug.

Unfortunately this is a hardware limitation for which Broadcom does
not offer any workarounds (except this combination logic). And there
are millions of devices out there; you can't just tell the users
"please resolder the CS line so it can be controlled through GPIO. At
least not most of them ;-)

> As it stands as well as the commit log it'd definitely need some
> comments in the code explaining the cuteness and the FIFO size
> limitations (possibly even log messages if we hit them) - it's not the
> coalescing that's the issue for me, it's the very specific and not
> terribly obvious subset of cases it's worked around for.

Unfortunately it's (as Florian said) 99% of use cases for the SPI controller:

- Register accesses to managed switches (write-then-read, with small
messages (write 2 bytes then read up to 8 for reading, write up to 10
for writing registers).
- Flash access using m25p80 (these also need write-then-read access
for reading from the flash, or combining the two write transfers so
writes actually succeed).
- SLIC/SLAC accesses (usually write-then-read/write-write, too)
- anything that uses spi_write_then_read().

All these fail when not using the prepend bytes method or merging the
two transfers into one full duplex transfer.

But sure, I can add logging when transfers get rejected.


Jonas

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
