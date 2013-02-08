From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
 possible
Date: Fri, 08 Feb 2013 17:28:29 +0100
Message-ID: <11938235.WbhQmuClDR@wuerfel>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <3752726.iyKukyN6sF@wuerfel> <20130208162248.GY17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vinod Koul <vinod.koul@linux.intel.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, devicetree-discuss@lists.ozlabs.org,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Jon Hunter <jon-hunter@ti.com>, spi-devel-general@lists.sourceforge.net,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130208162248.GY17833@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Friday 08 February 2013 16:22:48 Russell King - ARM Linux wrote:
> If it's DMA _to_ a device, then we will only ever clean the lines prior to
> a transfer, never invalidate them.  So that's not really a concern.  (There
> better not be any dirty cache lines associated with the empty zero page
> either.)

Right, makes sense. I thought I had read about a CPU that
could not flush a cache line without also invalidating
it, but that must have been something other than ARM,
or maybe I'm misremembering it.

	Arnd
