From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Tue, 15 Oct 2013 11:36:47 +0530
Message-ID: <525CDB77.4040201@ti.com>
References: <52566ACC.1080100@ti.com> <20131010101410.GG21581@sirena.org.uk>
 <52568AA3.9080203@ti.com> <20131011100839.GA21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Peter Korsgaard <peter@korsgaard.com>, Trent Piepho <tpiepho@gmail.com>,
 balbi@ti.com, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, computersforpeace@gmail.com,
 dwmw2@infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20131011100839.GA21581@sirena.org.uk>
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

Hi Mark,
On Friday 11 October 2013 03:38 PM, Mark Brown wrote:
> On Thu, Oct 10, 2013 at 04:38:19PM +0530, Sourav Poddar wrote:
>> On Thursday 10 October 2013 03:44 PM, Mark Brown wrote:
>>> Essentially what it looks like this hardware is trying to do is adapt a
>>> serial flash so it looks more like a parallel flash.  It's not clear
>>> that this is a good idea if we are already able to understand serial
>>> flash though.
>> Do you have any idea of how to go about implementing it in a more
>> cleaner way?(taking care of all what the spi controller hardware needs to
>> do for the memory mapped mode.). I understand doing a memcpy in the caller
>> itself, but how to tackle the spi controller configuration at that
>> point of time.
> You'd need to lock the bus and return the address for the caller to use
> until it released the lock.  Like I say I'd want to see numbers on this
> helping though.
>
I explored the whole scenario at hand and tried to create something 
based on previous
feedbacks that memcpy should be done only at the flash layer and the entire
spi framework should be bypassed.

But there is one problem which I faced while trying to achieve the 
above. Currently, spi
framework takes care of the runtime clock control part in 
pump_message(spi.c). So, at the
beginning of each transfer, there is a "get_sync" while at the end there 
is a "put_sync". Now, if
I try to do a memcpy in flash and bypass the SPI framework, there is a 
data abort as the SPI
controller clocks are cut.

>> Memory mapped is  a spi controller feature rather than a flash.
> The way it appears to be implemented is pretty flash specific isn't it?


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
