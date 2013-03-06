From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] spi: add driver for BCM2835
Date: Tue, 05 Mar 2013 21:27:23 -0700
Message-ID: <5136C5AB.7020301@wwwdotorg.org>
References: <1362538142-19246-1-git-send-email-swarren@wwwdotorg.org>
	<20130306040520.GA4896@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130306040520.GA4896-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 03/05/2013 09:05 PM, Mark Brown wrote:
> On Tue, Mar 05, 2013 at 07:49:02PM -0700, Stephen Warren wrote:
> 
>> +Optional properties: +- brcm,realtime: Boolean. Indicates the
>> driver should operate with realtime +  priority to minimise the
>> transfer latency on the bus.
> 
> This isn't obviously something that ought to be in DT, it'll depend
> on the OS, kernel version and so on.  Indeed I don't think this is
> used any more as the generic pump code Linus did handles it already
> in a runtime tunable way?

I was going to remove this for similar reasons, but then I noticed
that Documentation/devicetree/bindings/spi/spi_pl022.txt contains
basically the same thing:

> - pl022,rt : indicates the controller should run the message pump
> with realtime priority to minimise the transfer latency on the bus
> (boolean)

... so I assumed this must have been conceptually OK'd in the past.

If that somehow accidentally snuck in, I can happily remove this feature.

>> +	list_for_each_entry(tfr, &mesg->transfers, transfer_list) { +
>> err = bcm2835_spi_check_transfer(spi, tfr); +		if (err) +			goto
>> out; + +		err = bcm2835_spi_start_transfer(spi, tfr); +		if
>> (err) +			goto out; + +		timeout =
>> wait_for_completion_timeout(&bs->done, +
>> msecs_to_jiffies(BCM2835_SPI_TIMEOUT_MS)); +		if (!timeout) { +
>> err = -ETIMEDOUT; +			goto out; +		}
> 
> But I wanted to transfer 10G in a single message at 1kHz!  :P

I'm not sure what the solution is here; calculated timeout value, or
no timeout?

>> +	/* initialise the hardware */ +	clk_prepare_enable(bs->clk); +
>> bcm2835_wr(bs, BCM2835_SPI_CS, +		   BCM2835_SPI_CS_CLEAR_RX |
>> BCM2835_SPI_CS_CLEAR_TX);
> 
> It'd be nice to only enable the clock during transfers.

In practice, the clock that's provided to the driver is a dummy fixed
clock at the moment, so doing so would make no difference. Controlling
real clocks requires passing messages to the VideoCore co-processor,
and I've avoided upstreaming any of that stuff yet since I'm not sure
if the message structures are static enough to rely on, and I'm hoping
the VC reverse-engineering effort would allow a native driver for some
of those features from the ARM core rather than via message-passing...

I'll fix up the other issues you mentioned that I didn't specifically
respond to.

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
