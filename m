From: Christophe Ricard <christophe.ricard@gmail.com>
Subject: [PATCH v4 0/3] ACPI: Add irq_type to gpio interrupt
Date: Mon,  7 Dec 2015 23:39:09 +0100
Message-ID: <1449527952-8399-1-git-send-email-christophe-h.ricard@st.com>
Cc: linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Christophe Ricard <christophe-h.ricard@st.com>
To: rjw@rjwysocki.net, lenb@kernel.org, linus.walleij@linaro.org,
	gnurou@gmail.com, andriy.shevchenko@linux.intel.com,
	mika.westerberg@linux.intel.com, broonie@kernel.org
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

ACPI probing method does not retrieve irq_type from a gpio interrupt declared
with GpioInt as it is done with devicetree probing. In other terms, irq_get_trigger_type
will always send back 0.

Those 3 patches propose a way to retrieve the correct interrupt polarity/type from a GpioInt
acpi declaration when using irq_get_trigger_type.

Since v3:
- A new fied irq_type in acpi_gpio_info is added and the way the irq_type is attached to the irq is improved.
- The irq described in the acpi spi slave node is now set 

Best Regards
Christophe 

Christophe Ricard (3):
  acpi: Rename acpi_gsi_get_irq_type to acpi_get_irq_type and export
    symbol
  ACPI / gpio: Add irq_type when a gpio is used as an interrupt
  ACPI / spi: attach gpio irq from acpi description to spi device

 drivers/acpi/gsi.c          | 21 +--------------------
 drivers/acpi/utils.c        | 21 +++++++++++++++++++++
 drivers/gpio/gpiolib-acpi.c | 22 ++++++++++++++++++----
 drivers/gpio/gpiolib.h      |  1 +
 drivers/spi/spi.c           |  2 +-
 include/linux/acpi.h        |  2 ++
 6 files changed, 44 insertions(+), 25 deletions(-)

-- 
2.1.4

