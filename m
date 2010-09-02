From: Hu Mingkai-B21284 <B21284@freescale.com>
Subject: RE: [spi-devel-general] [PATCH v2 3/6] mtd: m25p80: add support to
	parse the SPI flash's partitions
Date: Thu, 2 Sep 2010 16:57:30 +0800
Message-ID: <73839B4A0818E747864426270AC332C30561B6E8@zmy16exm20.fsl.freescale.net>
References: <AANLkTik9cy+at2n28U+Mut4RD6_cJ9uRZzjf+H86d-rp@mail.gmail.com>
	<796604.30863.qm@web180307.mail.gq1.yahoo.com>
	<AANLkTi=FGf9gbWDkO4qs01Z+qkip+Zm11=Jc4wHu3G8b@mail.gmail.com>
	<OF0D24DC16.E1FE65D2-ONC125777B.002E544A-C125777B.002EA7C2@transmode.se>
	<AANLkTinYYTj+dR6ckPoShHKZTUmENEA1O-DYP9mjnWrs@mail.gmail.com>
	<20100810160157.GA24553@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	David Brownell <david-b@pacbell.net>, linux-mtd@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net,
	Gala Kumar-B11780 <B11780@freescale.com>,
	David Woodhouse <dwmw2@infradead.org>
To: "Anton Vorontsov" <cbouatmailru@gmail.com>,
	"Grant Likely" <grant.likely@secretlab.ca>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Class: urn:content-classes:message
In-Reply-To: <20100810160157.GA24553@oksana.dev.rtsoft.ru>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: Anton Vorontsov [mailto:cbouatmailru@gmail.com]
> Sent: Wednesday, August 11, 2010 12:02 AM
> To: Grant Likely
> Cc: Joakim Tjernlund; Gala Kumar-B11780; David Brownell; linux-
> mtd@lists.infradead.org; spi-devel-general@lists.sourceforge.net; Hu Mingkai-
> B21284; David Woodhouse
> Subject: Re: [spi-devel-general] [PATCH v2 3/6] mtd: m25p80: add support to
> parse the SPI flash's partitions
> 
> On Tue, Aug 10, 2010 at 08:56:42AM -0600, Grant Likely wrote:
> [...]
> > The suggestion has been raised to use something like bus notifiers to
> > get a hook onto the device registration before the driver is probed so
> > that the platform_data can be translated in an separate chuck of code,
> > but down that path lies insanity.  There are all kinds of ordering
> > issues (like making sure the translation code is called before the
> > driver probe code), and it is a lot of complexity for what is really a
> > simple thing.
> 
> There's another option: platform data handlers (they could be chained, in case
> if we want to use several methods of obtaining platform data, i.e. "try raw data,
> then ACPI, then OF").
> 
> See include/linux/spi/mmc_spi.h (mmc_spi_get_pdata) and
> drivers/mmc/host/of_mmc_spi.c.
> 
> I think we might implement some library to make these handlers more generic, but
> even the simple implementation as in mmc_spi case proves that it is possible to
> separate OF/ACPI/DMI/whatever handling from the generic code.
> 

It's also a good suggestion, I'll try it.

Thanks,
Mingkai
______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
