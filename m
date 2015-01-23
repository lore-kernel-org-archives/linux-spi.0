From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 00/18] spi/xilinx: Speed-up
Date: Fri, 23 Jan 2015 17:08:32 +0100
Message-ID: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This set of patches has been developed after using the core to access a=
 spi
nor flash. The initial performance was not as desired. The following ch=
anges
have been done.

-This series of patches add driver support for hardware implemented mod=
es:
LSB_FIRS, LOOP and CS_HIGH.

-There is support for irq less operations.

-The buffer size of the core is detected at probe time, speeding up the
operations.

-Code has been simplify and cleaned

This are the results, before and after the patchet

Original
root@qt5022:~# dd if=3D/dev/mtd0 of=3D/dev/null
16384+0 records in
16384+0 records out
8388608 bytes (8.4 MB) copied, 117.985 s, 71.1 kB/s

=C2=A037: =C2=A0 =C2=A0 =C2=A0 =C2=A0107 =C2=A0 =C2=A0 =C2=A082853 =C2=A0=
Xilinx INTC Level =C2=A0 1 =C2=A0b0010000.spi-flash

After patchset (irq):
root@qt5022:~# dd if=3D/dev/mtd0 of=3D/dev/null
16384+0 records in
16384+0 records out
8388608 bytes (8.4 MB) copied, 49.009 s, 171 kB/s

After patchset (irq):
root@qt5022:~# dd if=3D/dev/mtd0 of=3D/dev/null
16384+0 records in
16384+0 records out
8388608 bytes (8.4 MB) copied, 41.2526 s, 203 kB/s

IRQS:=C2=A0ZERO

This set of patches supersedes the previous patchet with only LSB_FIRST=
 and LOOP

Ricardo Ribalda Delgado (18):
  spi/xilinx: Support for spi mode LSB_FIRST
  spi/xilinx: Support for spi mode LOOP
  spi/xilinx: Simplify data read from the Rx FIFO
  spi-xilinx: Simplify spi_fill_tx_fifo
  spi/xilinx: Leave the IRQ always enabled.
  spi/xilinx: Code cleanup
  spi/xilinx: Use cached value of register
  spi/xilinx: Support cores with no interrupt
  spi/xilinx: Do not inhibit transmission in polling mode
  spi/xilinx: Support for spi mode CS_HIGH
  spi/xilinx: Remove rx_fn and tx_fn pointer
  spi/xilinx: Make spi_tx and spi_rx simmetric
  spi/xilinx: Convert remainding_bytes in remaining words
  spi/xilinx: Convert bits_per_word in bytes_per_word
  spi/xilinx: Remove iowrite/ioread wrappers
  spi/xilinx: Reset core before buffer_size detection
  spi/xilinx: Remove remaining_words driver data variable
  spi/xilinx: Check number of slaves range

 drivers/spi/spi-xilinx.c | 306 ++++++++++++++++++++++-----------------=
--------
 1 file changed, 146 insertions(+), 160 deletions(-)

--=20
2.1.4
