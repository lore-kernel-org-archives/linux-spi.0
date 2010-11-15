From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [RFC 11/18] spi: add SPI controller driver for the Atheros
	AR71XX/AR724X/AR913X SoCs
Date: Sun, 14 Nov 2010 21:04:56 -0700
Message-ID: <20101115040456.GB19965@angua.secretlab.ca>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
	<1289598684-30624-12-git-send-email-juhosg@openwrt.org>
	<20101114082242.GA3137@angua.secretlab.ca>
	<4CE04EBC.4080701@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, "Luis R. Rodriguez" <mcgrof-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Cliff Holden <Cliff.Holden-R2DSYHpuZhhBDgjK7y7TUQ@public.gmane.org>,
	Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4CE04EBC.4080701-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Nov 14, 2010 at 10:03:56PM +0100, Gabor Juhos wrote:
> >> +static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned reg)
> >> +{
> >> +	return __raw_readl(sp->base + reg);
> >> +}
> >> +
> >> +static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned reg, u32 val)
> >> +{
> >> +	__raw_writel(val, sp->base + reg);
> >> +}
> > 
> > This is suspect.  Why is __raw_{readl,writel} being used instead of
> > ioread32/iowrite32?  The __raw versions don't provide any kind of
> > ordering barriers.
> 
> Mainly because the resulting code is smaller, and the performance is a bit
> better with the use of the __raw versions. The controller is embedded into the
> SoC and the registers are memory mapped, so i think it is safe to access them
> with __raw_{readl,writel}. However I can change it if that is the preferred method.
> 

Smaller, yes, because it doesn't have any io barriers; but is it safe?
Do you know whether or not the CPU will reorder the instructions on
you?  Being embedded into the SoC doesn't really mean anything in this
regard.  Unless you really understand all the behaviour of the CPU and
bus, then the safe versions must be used.

If you *do* really understand all the behaviour and decide it is safe
to use the __raw versions, then the driver needs to be well documented
as to the reasons why the __raw versions are safe to use.

g.


------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
