From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/12] misc: add driver for sequencer serial port
Date: Fri, 22 Oct 2010 14:48:17 +0200
Message-ID: <201010221448.17728.arnd@arndb.de>
References: <1287694873-12904-1-git-send-email-cyril@ti.com> <20101021161224.b4c0b623.akpm@linux-foundation.org> <4CC18605.80007@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"davinci-linux-open-source@linux.davincidsp.com"
	<davinci-linux-open-source@linux.davincidsp.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"broonie@opensource.wolfsonmicro.com"
	<broonie@opensource.wolfsonmicro.com>,
	"lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>,
	"dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rpurdie@rpsys.net" <rpurdie@rpsys.net>
To: cyril@ti.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CC18605.80007@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Friday 22 October 2010 14:39:33 Cyril Chemparathy wrote:
> >> +/* Register Access Helpers */
> >> +static inline u32 ssp_read(struct ti_ssp *ssp, int reg)
> >> +{
> >> +    return __raw_readl(ssp->regs + reg);
> >> +}
> >> +
> >> +static inline void ssp_write(struct ti_ssp *ssp, int reg, u32 val)
> >> +{
> >> +    __raw_writel(val, ssp->regs + reg);
> >> +}
> > 
> > Why are the __raw functions used here?
> > 
> 
> These registers are to be accessed native endian at all times, and
> therefore the le32 conversion done otherwise is inappropriate.

Won't that break on out-of-order CPUs that need the extra synchronization
done in readl/writel?

	Arnd
