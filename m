From: Bert Vermeulen <bert@biot.com>
Subject: Re: [PATCH v3] nand: Add NAND driver for Mikrotik RB4xx series boards
Date: Wed, 05 Aug 2015 12:02:00 +0200
Message-ID: <55C1DF18.4090800@biot.com>
References: <1431689631-7217-1-git-send-email-bert@biot.com>
 <20150721202904.GK24125@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Arnd Bergmann <arnd@arndb.de>, linux-spi@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org,
 fransklaver@gmail.com, dwmw2@infradead.org
To: Brian Norris <computersforpeace@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20150721202904.GK24125@google.com>
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

On 07/21/2015 10:29 PM, Brian Norris wrote:

>> +static struct spi_driver rb4xx_cpld_driver = {
>> +	.probe = rb4xx_cpld_probe,
>> +	.remove = rb4xx_cpld_remove,
>> +	.driver = {
>> +		.name = "rb4xx-cpld",
>> +		.owner = THIS_MODULE,
>> +	},
>> +};
> 
> I feel some deja vu here (did I make this comment before?); why do you
> need to embed both a SPI and a platform driver here? It appears that the
> NAND controller actually sits on the SPI bus, so this really is not a
> platform driver; it's a SPI driver. Can you just kill off all the
> platform_driver stuff and merge the probe functions?
> 
> Or if I'm missing something big, please do enlighten.

This driver was specifically refused by the SPI subsystem maintainer:

  http://www.linux-mips.org/archives/linux-mips/2015-03/msg00422.html

He suggested the MFD subsystem, where it was also refused:

  http://lkml.iu.edu/hypermail/linux/kernel/1504.0/03162.html

Andy Shevchenko suggested drivers/misc, so I mailed Arnd Bergmann and asked
if he would accept it there.

Arnd took a good look at the driver and suggested the MTD/NAND subsystem.
This is after all a driver for a NAND chip controller. The controller just
happens to reside in a CPLD with custom firmware, which is controlled via
SPI and has some GPIO controller functionality thrown in.

I realize it's an odd hardware setup, and I can't fix that, but this really
does seem to be the best place for it.

I can deal with your other comments on the patch, but I'd really like some
agreement on where this driver will be accepted first. I've come full circle
with getting referred back to the SPI subsystem.


-- 
Bert Vermeulen        bert@biot.com          email/xmpp

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
