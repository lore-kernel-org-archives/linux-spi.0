From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v8 0/4] mtd: Add a SPI NAND driver
Date: Fri,  1 Jun 2018 15:13:56 +0200
Message-ID: <20180601131400.17634-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
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

Not much has changed in this v8, I mainly fixed bugs/issues reported
by Miquel and Frider.
This is hopefully the last version, and if everything goes well I
should merge this stuff just after 4.18-rc1 is out.

Mark, Rob, just one thing I'm not sure about: in patch 2 I use
spi-{tx,rx}-bus-width to encode board limitations on the SPI bus, but
I'm not sure these properties were created to express that. Should I
create a new prop (spi-max-bus-width?) or is it fine to reuse those
spi-{tx,rx}-bus-width props?

Comments/reviews are welcome.

Thanks,

Boris

v8 changes:
- dropped patch 1 which has been applied
- fix various bugs in the core (see changelog in patch 1)
- add a commit message to patch 4

v7 changes:
- Use the spi-mem interface
- Add support for on-die ECC
- Add support for Winbond W25M02GV chip

v6 changes:
- includes generic NAND framework patches in series
- rebase on nand/next (commit 6076fd1e9d879521f7082a5e22185b71e480b777)
- remove on-die ECC support
- remove devm_free() since everything allocated by devm_kmalloc() will be
  automatically freed when device is released
- add comment header for structs in spinand.h
- remove spinand_register()/unregister(), call spinand_detect() in
  spinand_init() and only expose spinand_init()/cleanup()
- add nand_release_bbt() in bbt.c and use it in nand_cleanup() and
  spinand_cleanup()
- use BIT(n) instead (1 << n) in macro of spinand.h
- rename spinand_alloc() to devm_spinand_alloc()
- name lables in better way
- fix some typos
- add empty lines between code blocks

v5 changes:
- rebase patch on nand/next with Boris's generic NAND framework patches[3]
- replace pr_xxx() with dev_xxx()
- replace kzalloc()i/kfree() with devm_kzalloc()/devm_kfree()
- rename spinand_op_init() to spinand_init_op() for consistency
- remove command opcode in function comments
- use BIT(n) instead (1 << n) in macro
- remove manufactures.c and put spinand_manufacturers table in core.c
- change spinand_write_reg() u8 *buf argument to u8 value,
  since the length is always 1
- remove spinand_manufacture->detect() check, since it is always != NULL
- alloc spinand_ecc_engine struct in vendor.c when using on-die ECC
  (for hardware ECC, it should be in controllers/*.c)
- add comment header for struct spinand_op
- fix timeout bug in spinand_wait(), thanks for Arnaud's debug
- make spinand_manufacturers const
- add ecc_engine_ops pointer in struct micron_spinand_info
- make controller->cap assignment right with SPI_TX/RX_QUAD/DUAL flag

v4 changes:
- initialize struct mtd_oob_ops to 0 in bbt.c
- rename new added helper in nand.h to nand_check_xxxx()
- add struct mtd_oob_ops consistency check in nand_check_oob_ops()
- add dataleft in struct nand_page_iter instead of offs
- remove spinand_manufacturers->ops->detect() check since it is mandatory
- remove spinand_set_manufacturer_ops() and do the job in
  spinand_manufacturer_detect()
- move .priv out of struct spinand_controller
- add spinand_alloc/free/register/unregister() and make
  spinand_detect/init() static
- make BBT be configured by device tree
- chip->id.data stores raw ID directly
- refine device info print message after detect success
- add struct mtd_layout_ops pointer in struct micron_spinand_info
- remove micron_spinand_init() and do its job in micron_spinand_detect()
- fix BBT block cannot be erased bug

v3 changes:
- rebase patch on 4.11-rc1[2]
- change read ID method. read 4 bytes ID out then let ->detect() of each
  manufacutre driver to decode ID and detect the device.
- make SPI NAND id table private to each manufacutre driver
- fix coding style to make checkpatch.pl happy
- update the MAINTAINERS file for spi nand code
- add nand_size() helper in nand.h
- use nand_for_each_page() helper in spinand_do_read/write_ops()
- create helper to check boundaries in generic NAND code and use it
  in SPI NAND core
- rename spinand_base.c to core.c
- manufactures' drivers expose spinand_manufacturer struct instead of
  spinand_manufacturer_ops struct to keep Manufacture ID macro in
  manufactures' drivers and rename spinand_ids.c to manufacture.c
- rename spinand_micron.c to micron.c
- rename chips/ directory to controllers/
- rename generic_spi.c to generic-spi.c
- replace ->build_column_addr() and ->get_dummy() hooks with ->prepare_op() in
  spinand_manufacturer_ops struct
- rename __spinand_erase() to spinand_erase()
- rename spinand_erase() to spinand_erase_skip_bbt()
- rename spinand_scan_ident() to spinand_detect()
- rename spinand_scan_tail() to spinand_init()
- move non detect related code from spinand_detect() to spinand_init()
- remove spinand_fill_nandd, assign nand->ops in spinand_detect()
- merge v2 patch 3(bad block support) and patch 4(BBT support)
- drop getchip parameter, remove spinand_get/remove_device(), take the lock
  by caller directly
- fix function comment headers
- use nand_bbt_is_initialized() helper
- replace spinand_ecc_engine and spinand_controller object in spinand_device
  struct with pointer
- replace struct spinand_manufacturer_ops pointer in spinand_device struct
  with spinand_manufacturer struct

v2 changes:
- replace "spi_nand" with "spinand".
- rename spi nand related structs for better understanding.
- introduce spi nand controller, manufacturer and ecc_engine struct.
- add spi nand manufacturer initialization function refer to Boris's
  manuf-init branch.
- remove NAND_SKIP_BBTSCAN from series. Add it later when enabling HW ECC.
- reorganize series according to Boris's suggestion.

*** BLURB HERE ***

Boris Brezillon (1):
  dt-bindings: Add bindings for SPI NAND devices

Frieder Schrempf (1):
  mtd: spinand: Add initial support for Winbond W25M02GV

Peter Pan (2):
  mtd: nand: Add core infrastructure to support SPI NANDs
  mtd: spinand: Add initial support for Micron MT29F2G01ABAGD

 Documentation/devicetree/bindings/mtd/spi-nand.txt |   27 +
 drivers/mtd/nand/Kconfig                           |    1 +
 drivers/mtd/nand/Makefile                          |    1 +
 drivers/mtd/nand/spi/Kconfig                       |    7 +
 drivers/mtd/nand/spi/Makefile                      |    2 +
 drivers/mtd/nand/spi/core.c                        | 1129 ++++++++++++++++++++
 drivers/mtd/nand/spi/micron.c                      |  133 +++
 drivers/mtd/nand/spi/winbond.c                     |  141 +++
 include/linux/mtd/spinand.h                        |  419 ++++++++
 include/linux/spi/spi-mem.h                        |    4 +-
 10 files changed, 1863 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
 create mode 100644 drivers/mtd/nand/spi/Kconfig
 create mode 100644 drivers/mtd/nand/spi/Makefile
 create mode 100644 drivers/mtd/nand/spi/core.c
 create mode 100644 drivers/mtd/nand/spi/micron.c
 create mode 100644 drivers/mtd/nand/spi/winbond.c
 create mode 100644 include/linux/mtd/spinand.h

-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
