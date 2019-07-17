From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 0/4][V2] iio: imu: Add support for the ADIS16460 IMU
Date: Wed, 17 Jul 2019 14:51:05 +0300
Message-ID: <20190717115109.15168-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This changeset adds support for the ADIS16460.

Support for this chip, requires changes in both IIO & SPI, in order to
support configurable/longer CS change delays.

The default CS change delay is 10 uS, while the ADIS16460 requires a
minimum of 16 uS. In order to accomodate this, the SPI transfer struct
requires a `cs_change_delay_usecs` parameter that is used when `cs_change`
is set.

The ADIS library also requires a small update to support the new SPI
`cs_change_delay_usecs`, and after that, support for ADIS16460 is added,
since all the required parts for operating the chip are in the kernel.

Changelog v1 -> v2:
* for SPI:
  * renamed `cs_change_stall_delay_us` -> `cs_change_delay_usecs`
    initial recommendation was `cs_change_delay`, but decided to name this
    `cs_change_delay_usecs`, since the convention for these delays seems
    to add the `_usecs` suffix
* for ADIS lib:
  * renamed `stall_delay` -> `cs_change_delay`
  * removed some assignments of `cs_change_delay`
    where `cs_change` is not set
* for ADIS16460 driver:
  * fixed license
  * adjusted to new `cs_change_delay[_usecs]`

Alexandru Ardelean (4):
  drivers: spi: core: Add optional stall delay between cs_change
    transfers
  iio: imu: adis: Add support for SPI transfer cs_change_stall_delay_us
  iio: imu: Add support for the ADIS16460 IMU
  dt-bindings: iio: imu: add bindings for ADIS16460

 .../bindings/iio/imu/adi,adis16460.yaml       |  53 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/imu/Kconfig                       |  12 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/adis.c                        |   6 +
 drivers/iio/imu/adis16460.c                   | 489 ++++++++++++++++++
 drivers/spi/spi.c                             |   3 +-
 include/linux/iio/imu/adis.h                  |   2 +
 include/linux/spi/spi.h                       |   3 +
 9 files changed, 576 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
 create mode 100644 drivers/iio/imu/adis16460.c

-- 
2.20.1
