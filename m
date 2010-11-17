From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 00/49] spi: davinci: re-write existing driver
Date: Wed, 17 Nov 2010 16:13:32 +0530
Message-ID: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch series represents a break-up into reviewable portions
of the work originally done by Brian and posted here:

https://patchwork.kernel.org/patch/114924/

While this series does not exactly add up to what Brian's patch
is, it is pretty close functionally.

This series was tested by me on OMAP-L138, OMAP-L137, DM365 and DM355
EVMs and on their OMAP-L138 boards (not EVMs) by Brian and Michael.

The patch series applies to latest of Linus's tree in hope that
it will be considered for merge in 2.6.37 since the series is
about bug fixes and clean-up.

This series along with some patches to add SPI platform support
to OMAP-L1x EVMs and Mity-DSP board is also available here:

http://arago-project.org/git/projects/?p=linux-davinci.git;a=shortlog;h=refs/heads/davinci-spi-rewrite

Brian Niebuhr (42):
  spi: davinci: fix checkpatch errors
  spi: davinci: whitespace cleanup
  spi: davinci: remove unused variable 'pdata'
  spi: davinci: set chip-select mode in SPIDEF only once
  spi: davinci: enable both activation and deactivation of chip-selects
  spi: davinci: remove unnecessary data transmit on CS disable
  spi: davinci: enable GPIO lines to be used as chip selects
  spi: davinci: simplify prescalar calculation
  spi: davinci: remove 'wait_enable' platform data member
  spi: davinci: make chip-slect specific parameters really chip-select
    specific
  spi: davinci: consolidate setup of SPIFMTn in one function
  spi: davinci: setup chip-select timers values only if timer enabled
  spi: davinci: add support for wait enable timeouts
  spi: davinci: remove unused members of davinci_spi_slave
  spi: davinci: eliminate the single member structure davinci_spi_slave
  spi: davinci: eliminate unnecessary update of davinci_spi->count
  spi: davinci: simplify calculation of edma acount value
  spi: davinci: check for NULL buffer pointer before using it
  spi: davinci: remove unnecessary disable of SPI
  spi: davinci: remove unnecessary 'count' variable in driver private
    data
  spi: davinci: remove unnecessary completion variable initialization
  spi: davinci: remove non-useful interrupt mode support
  spi: davinci: simplify poll mode transfers
  spi: davinci: add support for interrupt mode
  spi: davinci: configure the invariable bits in spipc0 only once
  spi: davinci: remove unnecessary function davinci_spi_bufs_prep()
  spi: davinci: remove unnecessary call to davinci_spi_setup_transfer()
  spi: davinci: do not store DMA channel information per chip select
  spi: davinci: always start transmit DMA
  spi: davinci: do not use temporary buffer if no transmit data
    provided
  spi: davinci: always start receive DMA
  spi: davinci: use edma_write_slot() to setup EDMA PaRAM slot
  spi: davinci: fix DMA event generation stoppage
  spi: davinci: fix EDMA CC errors at end of transfers
  spi: davinci: handle DMA completion errors correctly
  spi: davinci: remove usage of additional completion variables for DMA
  spi: davinci: let DMA operation be specified on per-device basis
  spi: davinci: remove non-useful "clk_internal" platform data
  spi: davinci: enable and power-up SPI only when required
  spi: davinci: setup the driver owner
  spi: davinci: add additional comments
  spi: davinci: add EF Johnson Technologies copyright

Sekhar Nori (7):
  spi: davinci: removed unused #defines
  spi: davinci: remove unnecessary typecast
  spi: davinci: do not treat Tx interrupt being set as error
  spi: davinci: do not allocate DMA channels during SPI device setup
  spi: davinci: remove unnecessary private data member 'region_size'
  spi: davinci: shorten variable names
  spi: davinci: kconfig: add manufacturer name to prompt string

 arch/arm/mach-davinci/dm355.c            |    7 +-
 arch/arm/mach-davinci/dm365.c            |    6 -
 arch/arm/mach-davinci/include/mach/spi.h |   52 +-
 drivers/spi/Kconfig                      |    7 +-
 drivers/spi/davinci_spi.c                | 1314 ++++++++++++------------------
 5 files changed, 587 insertions(+), 799 deletions(-)

-- 
1.7.3.2
