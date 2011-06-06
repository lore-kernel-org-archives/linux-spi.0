From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Mon, 6 Jun 2011 11:00:38 +0200
Message-ID: <201106061100.38249.arnd@arndb.de>
References: <20110605071725.26517.11573.stgit@ponder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	"Jean Delvare (PC drivers, core)" <khali@linux-fr.org>,
	"Ben Dooks (embedded platforms)" <ben-lin
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110605071725.26517.11573.stgit@ponder>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia/>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Sunday 05 June 2011, Grant Likely wrote:
>  rename drivers/spi/{omap2_mcspi.c => spi_omap2_mcspi.c} (100%)
>  rename drivers/spi/{omap_spi_100k.c => spi_omap_100k.c} (100%)
>  rename drivers/spi/{omap_uwire.c => spi_omap_uwire.c} (100%)
>  rename drivers/spi/{orion_spi.c => spi_orion.c} (100%)
>  rename drivers/spi/{amba-pl022.c => spi_pl022.c} (100%)
>  rename drivers/spi/{pxa2xx_spi.c => spi_pxa2xx.c} (100%)
>  rename drivers/spi/{pxa2xx_spi_pci.c => spi_pxa2xx_pci.c} (100%)
>  rename drivers/spi/{ti-ssp-spi.c => spi_ti_ssp.c} (100%)
>  rename drivers/spi/{tle62x0.c => spi_tle62x0.c} (100%)
>  rename drivers/spi/{xilinx_spi.c => spi_xilinx.c} (100%)

I recently looked at the directory structure in drivers/ and found a lot
of bus drivers with very few files, plus a few bus drivers with a lot
of files in them besides directories for non-bus specific subsystems.

I think it would be good to move them into a deeper directory drivers/bus/
if we have support from the maintainers, and it's probably better if we
only have to move the files once to reduce the amount of churn on the
MAINTAINERS file and any out of tree patches.

Specifically, I'd like to do these moves:

drivers/{ => bus}/amba
drivers/{ => bus}/dio
drivers/{ => bus}/eisa
drivers/{ => bus}/firewire
drivers/{ => bus}/i2c
drivers/{ => bus}/mca
drivers/{ => bus}/nubus
drivers/{ => bus}/pcmcia
drivers/{ => bus}/rapidio
drivers/{ => bus}/sbus
drivers/{ => bus}/spi
drivers/{ => bus}/ssb
drivers/{ => bus}/tc
drivers/{ => bus}/uwb
drivers/{ => bus}/virtio
drivers/{ => bus}/vlync
drivers/{ => bus}/w1
drivers/{ => bus}/zorro

This leaves out the two most common buses, USB and PCI, mostly because
the directories contain a lot of stuff that is not really bus code
but actual drivers. It does include i2c and spi, which stick out by
being a lot larger than most others.

Opinions? Move or don't move?

	Arnd
