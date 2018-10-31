From: Emil Renner Berthing <esmil@mailme.dk>
Subject: [PATCH v1 00/14] Rockchip SPI cleanup and use interrupts
Date: Wed, 31 Oct 2018 11:56:57 +0100
Message-ID: <20181031105711.19575-1-esmil@mailme.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Hi,

I took another look at the rockchip spi driver and ended up
with more cleanups and implementing an interrupt handler
to fill/empty the tx and rx fifos rather than busy-looping.

I have two question though:

The driver sets the SPI_LOOP flag in master->mode_bits,
but never checks if the flag is set on an spi device.
That looks suspicious to me, but I'm not exactly sure what
that flag means, so it might be ok?

The driver registers a master->max_transfer_size function
to always return 0xffff, but also checks each transfer
for xfer->len > 0xffff.
I thought that was redundant, but it turns out I can
trigger it with a simple
dd if=/dev/mtd0 of=/dev/null bs=[something > 0xffff]
Is that a bug or have I just not understood what
master->max_transfer_size is supposed to do?

/Emil

Emil Renner Berthing (14):
  spi: rockchip: make spi_enable_chip take bool
  spi: rockchip: use designated init for dma config
  spi: rockchip: always use SPI mode
  spi: rockchip: use atomic_t state
  spi: rockchip: disable spi on error
  spi: rockchip: read transfer info directly
  spi: rockchip: don't store dma channels twice
  spi: rockchip: remove master pointer from dev data
  spi: rockchip: simplify use_dma logic
  spi: rockchip: set min/max speed
  spi: rockchip: precompute rx sample delay
  spi: rockchip: use irq rather than polling
  spi: rockchip: support 4bit words
  spi: rockchip: support lsb-first mode

 drivers/spi/spi-rockchip.c | 579 +++++++++++++++++--------------------
 1 file changed, 264 insertions(+), 315 deletions(-)

-- 
2.19.1
