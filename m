From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 0/2] spi: spi_loopback_test regression test module
Date: Fri, 27 Nov 2015 13:56:02 +0000
Message-ID: <1448632564-2381-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

This adds a spi_loopback_test module that can get used to detect
regressions in spi_master drivers or the spi_core.

It will execute lots of spi_messages and try to figure out
if there are any issues with these messages.

It can also check that the content of received data is as expected when
we have a loopback situation (e.g: MOSI is wired to MISO) - this is
enabled via a module parameter.

Some spi_master drivers seem to support explicit loop-back without this
"cabeling", but right now there is no means to detect this reliably
by just by looking at spi_master (say spi_master.flags).
So this "feature" is for now not included and requires external cabling.

Also the currently defined set of 13 "tests", which may trigger the
generation of multiple spi_messages that get submitted via spi_sync.

There are some means to define some "variations" on each test based on:
* spi_transfer.len
* spi_transfer.tx_buf (alignment)
* spi_transfer.rx_buf (alignment)

All this  results in 752 distinct spi_messages that get submitted
on a Raspberry pi.

Geert Uytterhoeven for example recommended additional length iterations
including non power of 2 values, but he did not give recommendations
on which values exactly, so it is not included...

I hope the number of tests will increase over the years and will
allow us to do some extensive testing on spi_masters (maybe automated
via some test farms?) and detect regressions.

It obviously would also be helpfull that if a new issue is detected on
a spi_master that the loopback-test does not detect, that then the
test should get extended to allow such situations to get detected in
other drivers as well.

If the need arrises there is already some provisioning made to allow
the separation of the spi_test framework from the loopback_test driver
itself (if we want to integrate the tests deeper inside the spi_core).

Note that one of the reasons this test framework is written
is because I am writing a "spi_message" transformation layer that can
work in the spi_master and/or spi_core to optimize the spi message in
such a way that most of the limitations of the HW can get hidden from
normal spi device drivers.

Things that come to mind here:
* lenght limitations of the HW when using DMA
  (automatic splitting of one transfer into multiple transfers each
   below the HW limitation)
* alignment limitations of the HW
  (depending on the HW there are probably several variations
   of how this needs to get resolved)
* coalescing multiple spi_transfers into a single transfer
  to speed up the whole transfer reducing the number of interrupts
  required, but at the cost of copying some data to a new location

This loopback-test framework has already has helped me identify several
implementation issues in this proposed transformation layer.

Martin Sperl (2):
  spi: add spi_message_init_no_memset to avoid zeroing the spi_message
  spi: add loopback test driver to allow for spi_master regression
    tests

 drivers/spi/spi-loopback-test.c |  995 +++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-test.h          |  135 ++++++
 include/linux/spi/spi.h         |    7 +-
 3 files changed, 1136 insertions(+), 1 deletion(-)
 create mode 100644 drivers/spi/spi-loopback-test.c
 create mode 100644 drivers/spi/spi-test.h

--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
