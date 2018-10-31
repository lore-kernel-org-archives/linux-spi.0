From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 00/12] Port the FSL QSPI driver to the SPI framework
Date: Wed, 31 Oct 2018 14:40:55 +0100
Message-ID: <20181031144055.32e1c8f1@bbrezillon>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: yogeshnarayan.gaur@nxp.com, richard@nod.at, prabhakar.kushwaha@nxp.com,
 shawnguo@kernel.org, linux-spi@vger.kernel.org, marek.vasut@gmail.com,
 han.xu@nxp.com, broonie@kernel.org, linux-mtd@lists.infradead.org,
 miquel.raynal@bootlin.com, fabio.estevam@nxp.com, david.wolfe@nxp.com,
 computersforpeace@gmail.com, dwmw2@infradead.org
To: Frieder Schrempf <frieder.schrempf@exceet.de>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
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

Hi Frieder, Yogesh,

On Thu,  5 Jul 2018 13:14:56 +0200
Frieder Schrempf <frieder.schrempf@exceet.de> wrote:

> Now that the SPI memory interface was introduced by Boris [1], it is
> possible to move drivers from mtd/spi-nor to the SPI framework in order
> to use them for different type of SPI memory chips.
> 
> Patch 1 adds a function spi_mem_get_name() to the SPI memory interface
> and a ->name field to struct spi_mem.
> Patch 2 uses it in m25p80.c to make it possible for SPI controller
> drivers to provide a custom naming scheme for the flash chip.
> This is needed to avoid breaking compatibility of mtdparts when switching
> from the old to the new driver.
> 
> Patch 3 adds a driver for the Freescale QSPI controller to the SPI
> framework. Together with m25p80.c it can be used to interface SPI
> NOR flashes just as the old driver did. For this to work properly a few
> minor changes to the devicetrees are necessary (see patches 5 to 7).
> 
> Patch 8 changes the defconfigs to use the new driver and patch 9 removes
> the old driver.
> 
> Patch 10 and 11 remove 'fsl,qspi-has-second-chip' from the devicetrees.
> Patch 12 adjusts the MAINTAINERS file.
> 
> The new driver was tested with i.MX6UL and a Micron SPI NOR @ 60MHz.
> The read performance of the new driver is almost the same or even better
> than the old driver, depending on the block size.
> The write performance is a bit slower on average (~10-15%).
> 
> The new driver was also tested with the SPI NAND framework [2] and a
> Winbond W25M02GV flash.
> 
> If someone has a board that uses both chips selects and/or both busses,
> it would be really nice to have the driver be tested on such a setup.

Any progress on this front? Yogesh, can you please remind us the
remaining issues? I'd really like to make some progress, otherwise the
conversion to spi-mem will take ages.

Regards,

Boris

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
