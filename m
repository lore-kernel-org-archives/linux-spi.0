From: Christophe Ricard <christophe.ricard@gmail.com>
Subject: [PATCH v7 0/3] ACPI: Add irq_type to gpio interrupt
Date: Tue, 15 Dec 2015 08:11:30 +0100
Message-ID: <1450163493-4938-1-git-send-email-christophe-h.ricard@st.com>
Cc: linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Christophe Ricard <christophe-h.ricard@st.com>
To: rjw@rjwysocki.net, lenb@kernel.org, linus.walleij@linaro.org,
	gnurou@gmail.com, andriy.shevchenko@linux.intel.com,
	mika.westerberg@linux.intel.com, broonie@kernel.org
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

ACPI probing method does not retrieve irq_type from a gpio interrupt declared
with GpioInt as it is done with devicetree probing. In other terms, irq_get_trigger_type
will always send back 0.

Those 3 patches propose a way to retrieve the correct interrupt polarity/type from a GpioInt
acpi declaration when using irq_get_trigger_type.

Since v4 after Mika and Andy's feedbacks:
- acpi_gpio_info active_low field got renamed polarity. Note that polarity/active_low is having sense
also when a gpio is not mapped as an interrupt but as an output (For example: check gpiod_set_value
in drivers/gpio/gpiolib.c).
- acpi_gsi_get_irq_type is now renamed acpi_dev_get_irq_type and moved to drivers/acpi/resource.c
- The irq described in the acpi spi slave node is now set once we fall back to retrieve normal interrupt.

Since v5 after Andy's feedbacks:
- Make sure we are not using u* type but pure C type for non hardware value.

Since v6:
- Patches now applies on top of Raphael tree tag linux-next

Best Regards
Christophe 

Christophe Ricard (3):
  acpi: Rename acpi_gsi_get_irq_type to acpi_dev_get_irq_type and export
    symbol
  ACPI / gpio: Add irq_type when a gpio is used as an interrupt
  ACPI / spi: attach gpio irq from acpi description to spi device

 drivers/acpi/gsi.c          | 21 +--------------------
 drivers/acpi/resource.c     | 26 ++++++++++++++++++++++++++
 drivers/gpio/gpiolib-acpi.c | 30 ++++++++++++++++++++++++------
 drivers/gpio/gpiolib.c      |  4 ++--
 drivers/gpio/gpiolib.h      |  3 ++-
 drivers/spi/spi.c           |  2 ++
 include/linux/acpi.h        |  1 +
 7 files changed, 58 insertions(+), 29 deletions(-)

-- 
2.1.4

