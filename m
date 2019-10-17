From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 0/7] atmel-spi: Allow using more than 4 GPIOs as CS
Date: Thu, 17 Oct 2019 16:18:39 +0200
Message-ID: <20191017141846.7523-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

the main purpose of this series is allowing to use more than 4 GPIOs
as CS. But while doing it, I also clean-up the code and the comments
to match the actual support of the hardware.

Thanks to this series, it is now more clear to see what can be done
with CS GPIO and native CS. It is also possible to mix native and GPIO
CS as expected by the SPI binding.

In the end even managment of the specific use case for CS0 on
AT91RM9200 has been simplified.

Gregory

Gregory CLEMENT (7):
  spi: atmel: Remove and fix erroneous comments
  spi: atmel: Fix CS high support
  spi: atmel: Configure GPIO per CS instead of by controller
  spi: atmel: Remove useless private field
  spi: atmel: Remove platform data support
  spi: atmel: Improve and fix GPIO CS usage
  spi: atmel: Improve CS0 case support on AT91RM9200

 drivers/spi/Kconfig     |   1 +
 drivers/spi/spi-atmel.c | 154 ++++++++++++++++++++++++----------------
 2 files changed, 92 insertions(+), 63 deletions(-)

-- 
2.23.0
