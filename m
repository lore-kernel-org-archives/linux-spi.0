From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Thu, 10 Oct 2013 15:47:45 +0530
Message-ID: <52567EC9.1020708@ti.com>
References: <52566ACC.1080100@ti.com> <20131010101410.GG21581@sirena.org.uk>
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
In-Reply-To: <20131010101410.GG21581@sirena.org.uk>
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

On Thursday 10 October 2013 03:44 PM, Mark Brown wrote:
> On Thu, Oct 10, 2013 at 02:22:28PM +0530, Sourav Poddar wrote:
>
>> [Trent]: With mapping driver, I believe you are hinting at
>> drivers/mtd/maps? I had
>> a look at it and what I got is that it is used/suitable for parallel
>> flashes and not the
>> serial flashes.
> Essentially what it looks like this hardware is trying to do is adapt a
> serial flash so it looks more like a parallel flash.  It's not clear
> that this is a good idea if we are already able to understand serial
> flash though.
hmm..
one more point I want to add is that QSPI controller has
two parts to it:
1. SPI mode (used for SPI based external devices)
2. SFI mode (Serial flash interface) used for flash devices attached.
     Memory mapped mode is the one more applicable to the second one.


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
