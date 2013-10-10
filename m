From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Thu, 10 Oct 2013 14:22:28 +0530
Message-ID: <52566ACC.1080100@ti.com>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>	<1381332284-21822-2-git-send-email-sourav.poddar@ti.com>	<20131009160759.GQ21581@sirena.org.uk>	<52558A49.5090904@ti.com>	<20131009174027.GS21581@sirena.org.uk>	<87hacq1d5k.fsf@dell.be.48ers.dk>
 <CA+7tXii4J_Hie2v-DaSevFHn-YqriiVowhpXCP9H+U51_tbhvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, computersforpeace@gmail.com,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 dwmw2@infradead.org, balbi@ti.com
To: Trent Piepho <tpiepho@gmail.com>, Peter Korsgaard <peter@korsgaard.com>,
 Mark Brown <broonie@kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CA+7tXii4J_Hie2v-DaSevFHn-YqriiVowhpXCP9H+U51_tbhvQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi All,
On Thursday 10 October 2013 07:57 AM, Trent Piepho wrote:
> On Wed, Oct 9, 2013 at 12:01 PM, Peter Korsgaard<peter@korsgaard.com>  wrote:
>>>>>>> "Mark" == Mark Brown<broonie@kernel.org>  writes:
>>   Mark>  I'm not convinced that this is the most useful API, it sounds like the
>>   Mark>  hardware can "memory map" the entire flash chip so the whole SPI
>>   Mark>  framework seems like overhead.
>>
>>   Mark>  It also seems seems like it's going to involve the CPU being
>>   Mark>  stalled waiting for reads to complete instead of asking the SPI
>>   Mark>  controller to DMA the data to RAM and allowing the CPU to get on
>>   Mark>  with other things - replacing the explicit transmission of
>>   Mark>  commands with memory to memory DMAs might be advantageous but
>>   Mark>  replacing DMA with memcpy() would need numbers to show that it
>>   Mark>  was a win.
>>
>> Indeed. I can see how such a feature could be useful in E.G. a lowlevel
>> bootloader (because of simplicity), but am less convinced about it in
>> Linux where we could conceivable do something else useful while waiting
>> on the spi controller.
> I've found that the SPI layer adds rather a lot of overhead to SPI
> transactions.  It appears to come mostly from using another thread to
> run the queue.  A fast SPI message of a few dozen bytes ends up having
> more overhead from the SPI layer than the time it takes the driver to
> do the actual transfer.
>
> So memory mapped mode via some kind of SPI hack seems like a bad
> design.  All the SPI layer overhead and you don't get DMA.  Memory
> mapped SPI could be a win, but I think you'd need to do it at the MTD
> layer with a mapping driver that could read the mmapped SPI flash
> directly.
Yes, you are correct in all your comments above. I also feel that SPI 
framework
should be bypassed. But the subject patch is derived based on the 
following points/limitation:

1. There is a setup register in QSPI, that need to be filled, as of now 
I am filling it
     in my driver as a MACRO.
2. Controller repsonds to memory mapped read for read opcodes, so during the
read path we should tell the controller to switch to memory mapped port.

[Trent]: With mapping driver, I believe you are hinting at 
drivers/mtd/maps? I had
a look at it and what I got is that it is used/suitable for parallel 
flashes and not the
serial flashes.

All in all, Just at the beginning of the read api, I could have done 
memory mapped read and bypass
the spi framework. But, prior to that above 1, 2 point need to be 
executed and that need to be
communicated to controller driver.

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
