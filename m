From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v2 0/8] spi: loopback-test: improvments and sharing dump code
Date: Mon, 21 Dec 2015 11:52:43 +0000
Message-ID: <1450698772-2379-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>


Move spi_message dump method into SPI-core and make use of
this extended version of the dumping code in loopback-test.

This requires also separation of some content verification
from the dump code itself.

Also it now handles module-parameters differently
(some renaming to make it clearer what they are for)
and adds SPI_LOOP support.

Changelog:
V1->V2: * changes recommended in review by Andy Shevchenko
        * better separation to smaller patches
	* reintroduction of check for RX guard-pattern
	  lost in V1
	* rename module parameters, variables and methods

Martin Sperl (8):
  spi: loopback-test: write rx pattern also when running without tx_buf
  spi: loopback-test: rename method spi_test_fill_tx to
    spi_test_fill_pattern
  spi: core: add spi_message_dump and spi_transfer_dump
  spi: loopback-test: move to use spi_message_dump_data
  spi: loopback-test: spi_check_rx_ranges can get always done
  spi: loopback-test: improve granularity of dump_messages module
    parameter
  spi: loopback-test: change module parameter name to
    have_external_loopback
  spi: loopback-test: added support for HW-loopback mode

 drivers/spi/spi-loopback-test.c |  216 +++++++++++++++++++++------------------
 drivers/spi/spi.c               |  169 ++++++++++++++++++++++++++++++
 include/linux/spi/spi.h         |   24 +++++
 3 files changed, 308 insertions(+), 101 deletions(-)

--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
