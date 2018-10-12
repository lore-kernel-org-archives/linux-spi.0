From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH RFC 00/18] mtd: spi-nor: Proposal for 8-8-8 mode support
Date: Fri, 12 Oct 2018 10:48:07 +0200
Message-ID: <20181012084825.23697-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Julien Su <juliensu@mxic.com.tw>, Mark Brown <broonie@kernel.org>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-spi@vger.kernel.org,
 zhengxunli@mxic.com.tw
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
 Vignesh R <vigneshr@ti.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
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

Hello,

The trend has been around octo (or octal) SPI NOR lately, and both
Yogesh and Vignesh proposed patches to support 1-1-8 and 1-8-8 modes
on Micron SPI NORs (plus the associated patches to support that on the
Cadence and FlesSPI controllers). I'll probably take their patches in
4.20 since adding support for stateless octo modes is not invasive, but
I wanted to start a discussion on how we should support stateful modes
(X-X-X and XD-XD-XD, where X is the bus width and D means Double
Transfer Rate).

First question that might come to mind is why should we support such
stateful modes? If you think about it, the gain of transmitting the
opcode on 8 IO lines is rather small compared to the pain it is to
teach the SPI NOR framework how to deal with that. The problem is,
some SPI NOR manufacturers (Macronix for instance) only implement 1-1-1
and 8-8-8 (or 8D-8D-8D), and they want to be able to use their NORs in
8-8-8 mode when the controller supports it.

So, this patchset is aiming at starting a wider discussion on how you
think those modes should be supported. This is just a proposal, and I'm
of course open to other suggestions, as long as the answer is not as
definitive as "too bad for them, they should have supported 1-8-8 or
1-1-8 modes".

Just a few more details about the patches in this series. Some of them
are clearly conflicting with patches posted by Yogesh and Vignesh.
Don't worry guys, I'm still planning to take yours before, it's just
that I was too lazy to rebase on top of your modifications. Also, some
patches might not pass checkpatch or might trigger kbuild errors, but
before fixing those problems, I'd like to get your opinion on the
general approach.

It's also worth mentioning that I focused on spi-mem support only,
because on the long run, I want all SPI NOR controller drivers
converted to this interface, and if I can limit support of octo modes
to those implementing the spi-mem interface, that's an incentive to
push developers to do the conversion. This part is still open to
discussion though.

Also, in this patchset, I merge the m25p80 driver code in spi-nor.c,
which is something I wanted to do for quite some. Indeed, the m25p80 is
just a simple SPI NOR controller driver (a wrapper around the SPI mem
API). Not only it shouldn't be named after a specific SPI NOR chip, but
it also doesn't deserve a specific driver IMO, especially if the end
goal is to get rid of SPI NOR controller drivers found in
drivers/mtd/spi-nor/ and replace them by SPI mem drivers (which would
be placed in drivers/spi/). With this solution, we declare the SPI NOR
driver as a spi_mem_driver, just like the SPI NAND layer is declared as
a spi_mem driver. This solution also allows us to check at a
fined-grain level (thanks to the spi_mem_supports_op() function) which
operations are supported and which ones are not, while the original
m25p80 logic was basing this decision on the
SPI_{RX,TX}_{DUAL,QUAD,OCTO} flags only.

The last set of patches in the series are modifying the framework to
allow entering X-X-X modes in a chip-specific way, and then adds
support for 8-8-8 and 8D-8D-8D modes on a Macronix chip (mx25uw51245g).

Yogesh, Vignesh, Tudor (and maybe Cyrille and Marek if you have some
time), please have a look at this patch series and tell me what you
think.

Regards,

Boris

Boris Brezillon (18):
  mtd: spi-nor: Add a flash_info entry for Macronix mx25uw51245g
  spi: Prepare things for octo mode support
  spi: spi-mem: Prepare things for DTR mode support
  spi: spi-mem: Prepare things for dual bytes opcodes support
  spi: spi-mem: mxic: Add support for DTR and Octo mode
  mtd: spi-nor: Move m25p80 code in spi-nor.c
  mtd: spi-nor: Rework hwcaps selection for the spi-mem case
  mtd: spi-nor: Define the DPI, QPI and OPI hwcaps
  mtd: spi-nor: Add spi_nor_{read,write}_reg() helpers
  mtd: spi-nor: Add support for X-X-X modes
  mtd: spi-nor: Prepare things for 2byte opcodes
  mtd: spi-nor: Provide a hook to tweak flash parameters
  mtd: spi-nor: Add 8-8-8 mode support to Macronix mx25uw51245g
  mtd: spi-nor: Clarify where DTR mode applies
  mtd: spi-nor: Add DTR support to the spi-mem logic
  mtd: spi-nor: Add the concept of full DTR modes
  mtd: spi-nor: Add 8D-8D-8D mode
  mtd: spi-nor: Make sure the 8D-8D-8D can be selected on mx25uw51245g

 drivers/mtd/devices/Kconfig         |   18 -
 drivers/mtd/devices/Makefile        |    1 -
 drivers/mtd/devices/m25p80.c        |  324 ---------
 drivers/mtd/spi-nor/Kconfig         |    3 +-
 drivers/mtd/spi-nor/atmel-quadspi.c |    5 +-
 drivers/mtd/spi-nor/spi-nor.c       | 1331 +++++++++++++++++++++++++++++++----
 drivers/spi/spi-mem.c               |   15 +-
 drivers/spi/spi-mxic.c              |   27 +-
 drivers/spi/spi.c                   |   12 +-
 include/linux/mtd/spi-nor.h         |  168 ++++-
 include/linux/spi/spi-mem.h         |   69 +-
 include/linux/spi/spi.h             |    2 +
 12 files changed, 1424 insertions(+), 551 deletions(-)
 delete mode 100644 drivers/mtd/devices/m25p80.c

-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
