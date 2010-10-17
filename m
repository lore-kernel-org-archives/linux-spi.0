From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/28] Blackfin SPI updates for 2.6.36
Date: Sun, 17 Oct 2010 18:59:13 -0400
Message-ID: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Quite a bit here, but these patches have been around for a while.  The
reason they haven't been pushed up before was that some of the first
changes introduced known bugs themselves and needed some manual fixing.

Also, while some files touch Blackfin headers in arch/blackfin/, I'd
like to keep them in this series and merge through the SPI tree to keep
conflict issues down, as well as possible breakage due to desync.

These are also available in my 'for-spi' branch of my git tree:
	git://git.kernel.org/pub/scm/linux/kernel/git/vapier/blackfin.git

Barry Song (6):
  Blackfin SPI: fix CS handling
  Blackfin SPI: redo GPIO CS handling
  Blackfin SPI: save/restore state when suspending/resuming
  Blackfin SPI: sync hardware state before reprogramming everything
  Blackfin SPI: use dma_disable_irq_nosync() in irq handler
  Blackfin SPI: warn when CS is driven by hardware (CPHA=0)

Bob Liu (1):
  Blackfin SPI: check per-transfer bits_per_word

Daniel Mack (1):
  Blackfin SPI: fix resources leakage

Michael Hennerich (1):
  Blackfin SPI: init early

Mike Frysinger (13):
  Blackfin SPI: drop custom cs_change_per_word support
  Blackfin SPI: punt useless null read/write funcs
  Blackfin SPI: fix up some unused/misleading comments
  Blackfin SPI: convert queue run state to true/false
  Blackfin SPI: convert read/write/duplex funcs to a dedicated ops
    structure
  Blackfin SPI: convert struct names to something more logical
  Blackfin SPI: drop extra memory we don't need
  Blackfin SPI: use the SPI namespaced bit names
  Blackfin: SPI: expand SPI bitmasks
  Blackfin SPI: push all size checks into the transfer function
  Blackfin SPI: reset ctl_reg bits when setup is run again on a device
  Blackfin SPI: combine duplicate SPI_CTL read/write logic
  Blackfin SPI: reject unsupported SPI modes

Rob Maris (2):
  Blackfin SPI: fix typo in comment
  Blackfin SPI: cs should be always low when a new transfer begins

Sonic Zhang (1):
  Blackfin SPI: work around anomaly 05000119

Wolfgang Muees (1):
  Blackfin SPI: force sane master-mode state at boot

Yi Li (2):
  Blackfin SPI: utilize the SPI interrupt in PIO mode
  Blackfin SPI: use nosync when disabling the IRQ from the IRQ handler

 arch/blackfin/include/asm/bfin5xx_spi.h |   81 +---
 drivers/spi/spi_bfin5xx.c               |  839 ++++++++++++++++---------------
 2 files changed, 441 insertions(+), 479 deletions(-)

-- 
1.7.3.1
