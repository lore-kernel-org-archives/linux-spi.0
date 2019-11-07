From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] spi: more GPIO CS work
Date: Thu,  7 Nov 2019 17:42:33 +1300
Message-ID: <20191107044235.4864-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org, kdasu.kdev@gmail.com,
        bcm-kernel-feedback-list@broadcom.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

I've got a platform using the BCM 58525 CPU. The hardware design
connects to two SPI devices using a slightly odd arrangement of
GPIOs and native chip select. These patches however should be
relevant to any platform using that CPU with "normal" CS GPIOs

Chris Packham (2):
  spi: bcm-qspi: Convert to use CS GPIO descriptors
  spi: spi-mem: fallback to using transfers when CS gpios are used

 drivers/spi/spi-bcm-qspi.c | 7 +++++--
 drivers/spi/spi-mem.c      | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

--=20
2.24.0
