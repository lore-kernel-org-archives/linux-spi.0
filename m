From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/2] spi: add wakeup handling to SPI core
Date: Mon, 11 Nov 2019 21:54:09 -0800
Message-ID: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

These patches add wakeup handling for SPI devices to SPI core, mirroring
I2C subsystem. Users can mark devices as "wakeup-source" in device tree
(or using static device properties) and SPI core will mark the primary
interrupt line as wakeirq and mark the device as wakeup enabled.

There is also an option to define a dedicated wake irq.


Dmitry Torokhov (2):
  spi: dt-bindings: spi-controller: add wakeup-source and interrupts
  spi: wire up wakeup-source/wakeirq handling

 .../bindings/spi/spi-controller.yaml          | 23 ++++++++++++++++
 drivers/spi/spi.c                             | 27 ++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog
