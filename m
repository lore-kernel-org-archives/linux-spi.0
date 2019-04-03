From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 00/12] SPI GPIO improvements
Date: Tue,  2 Apr 2019 21:01:21 -0700
Message-ID: <20190403040133.1459-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Everyone:

This series contains a fix ("spi: Don't call spi_get_gpio_descs()
before device name is set) and improvements for SPI GPIO and driver I
made while looking at that code recently. Hopefully each patch is
self-explanatory.

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (12):
  spi: gpio: Drop unused spi_to_pdata()
  spi: gpio: Add local struct device pointer in spi_gpio_probe()
  spi: gpio: Add local struct spi_bitbang pointer in spi_gpio_probe()
  spi: gpio: Simplify SPI_MASTER_NO_TX check in spi_gpio_probe()
  spi: gpio: Drop unused pdata copy in struct spi_gpio
  spi: gpio: Don't request CS GPIO in DT use-case
  spi: Don't call spi_get_gpio_descs() before device name is set
  spi: gpio: Drop mflags argument from spi_gpio_request()
  spi: gpio: Drop unused pdev field in struct spi_gpio
  spi: gpio: Make sure spi_master_put() is called in every error path
  spi: bitbang: Introduce spi_bitbang_init()
  spi: gpio: Use devm_spi_register_master()

 drivers/spi/spi-bitbang.c       |  66 ++++++----
 drivers/spi/spi-gpio.c          | 226 ++++++++++++++------------------
 drivers/spi/spi.c               |  37 +++---
 include/linux/spi/spi_bitbang.h |   1 +
 4 files changed, 154 insertions(+), 176 deletions(-)

-- 
2.20.1
