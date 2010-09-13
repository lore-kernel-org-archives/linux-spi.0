From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [git pull] spi and OF fixes
Date: Sun, 12 Sep 2010 23:28:33 -0600
Message-ID: <AANLkTik6ntBGd=qVEkN=asARVJs41ww8pR5Wr6Z1n1Lc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "Wang,
	Yong Y" <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>,
	Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

Here's a double handfull of SPI and OF (ll_temac, gpiolib, 52xx_uart).
 Should be nothing eyebrow raising here.

g.

The following changes since commit be6200aac985e0a3db56ec636763a32f3e32e7f1:
  Linus Torvalds (1):
        Merge branch 'kvm-updates/2.6.36' of
git://git.kernel.org/pub/scm/virt/kvm/kvm

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 next-spi

Anton Vorontsov (1):
      gpiolib: Add 'struct gpio_chip' forward declaration for !GPIOLIB case

David Lamparter (1):
      spi: free children in spi_unregister_master, not siblings

Feng Tang (1):
      spi/dw_spi: clean the cs_control code

Jassi Brar (2):
      spi/s3c64xx: Fix compilation warning
      spi/s3c64xx: Fix incorrect reuse of 'val' local variable.

Julia Lawall (1):
      powerpc/5200: mpc52xx_uart.c: Add of_node_put to avoid memory leak

Linus Walleij (2):
      spi/pl022: fix APB pclk power regression on U300
      spi/pl022: move probe call to subsys_initcall()

Mark Brown (5):
      spi/spi_s3c64xx: Make probe more robust against missing board config
      spi/spi_s3c64xx: Staticise non-exported functions
      spi/spi_s3c64xx: Move to subsys_initcall()
      spi/spi_s3c64xx: Increase dead reckoning time in wait_for_xfer()
      spi/spi_s3c64xx: Warn if PIO transfers time out

Michal Simek (1):
      of: Fix missing includes - ll_temac

Yong Wang (1):
      spi/dw_spi: Allow interrupt sharing

 drivers/net/ll_temac_main.c   |    1 +
 drivers/net/ll_temac_mdio.c   |    1 +
 drivers/serial/mpc52xx_uart.c |    1 +
 drivers/spi/amba-pl022.c      |   16 +++++++++-------
 drivers/spi/dw_spi.c          |   24 +++++++++++-------------
 drivers/spi/spi.c             |    9 +++------
 drivers/spi/spi_s3c64xx.c     |   37 +++++++++++++++++++++++++------------
 include/linux/gpio.h          |    1 +
 include/linux/spi/dw_spi.h    |    2 ++
 9 files changed, 54 insertions(+), 38 deletions(-)

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
