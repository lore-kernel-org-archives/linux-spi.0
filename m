From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [RFC] generic iMX-spi driver
Date: Thu, 26 Feb 2009 23:26:39 +0000
Message-ID: <20090226232639.GF5811@n2100.arm.linux.org.uk>
References: <20090220144126.GA9203@pengutronix.de>
	<200902201641.21168.hs4233@mail.mn-solutions.de>
	<20090226103844.GB3058@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Holger Schurig <hs4233-x6+DxXLjN1AJvtFkdXX2Hg4jNU5vUVPG@public.gmane.org>,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090226103844.GB3058-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Feb 26, 2009 at 11:38:44AM +0100, Wolfram Sang wrote:
> On Fri, Feb 20, 2009 at 04:41:21PM +0100, Holger Schurig wrote:
> > > +struct spi_core_version {
> > > +	u32 rxdata;
> > > +	u32 txdata;
> > > +	u32 ctrl;
> > > +	u32 int_en;
> > > +	u32 status;
> > > +	u32 test;
> > > +	u32 period;
> > > +	u32 dma;
> > > +	u32 reset;
> > > +
> > > +	u32 int_te;
> > > +	u32 int_th;
> > > +	u32 int_ro;
> > > +	u32 int_te_en;
> > > +	u32 int_th_en;
> > > +	u32 int_ro_en;
> > > +	u32 xch;
> > > +
> > > +	u8 bitcount_shift;
> > > +	u8 sspol_shift;
> > > +	u8 ssctl_shift;
> > > +	u8 pha_shift;
> > > +	u8 pol_shift;
> > > +	u8 datarate_shift;
> > > +	u8 reset_val;
> > > +
> > > +	u32 max_divider;
> > > +	u32 max_bitcount;
> > > +	u32 default_ctrl;
> > > +	u32 (*calc_datarate)(struct driver_data *drv_data, u32
> > >           speed_hz, u32 *val); 
> > > +}; 
> > 
> > A number of u8's in the middle of a structure where later
> > 32 bit long entries are comming?
> > 
> > Move that to the end or change it to 32 (I yet have to verify if
> > the compiler creates stupid or good code when accessing u8 out of
> > a struct, but I assume that on ARM the code is more-or-less stupid).
> 
> Well, could be that I thought too much about size vs. performance issues
> here. My idea was to put the variables needed in hot-paths to the front
> of the struct.

That is a good reason for ordering structs like this.  ARM does generate
good code for accessing bytes in structures - it does have a byte load
instruction.

What it does do though is want to naturally align structure members, so
it's a good idea to group u8's together up to the next members natural
boundary.  So:

struct {
	u32 hot_32_1;
	u8 hot_8_1;
	u8 hot_8_2;
	u32 hot_32_2;
	u32 cold_32_1;
	u8 cold_8_1;
	u8 cold_8_2;
	u32 cold_32_2;
};

would be a silly layout - you'd end up adding an additional four bytes for
no gain.  Instead:

struct {
	u32 hot_32_1;
	u8 hot_8_1;
	u8 hot_8_2;
	u8 cold_8_1;
	u8 cold_8_2;
	u32 hot_32_2;
	u32 cold_32_1;
	u32 cold_32_2;
};

would be optimal use of memory without breaking the proximty of the hot
members (since you've put the two cold bytes into the wastage bytes.)

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
