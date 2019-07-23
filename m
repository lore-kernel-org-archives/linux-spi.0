From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 0/3][V4] iio: imu: Add support for the ADIS16460 IMU
Date: Tue, 23 Jul 2019 10:36:37 +0300
Message-ID: <20190723073641.27801-1-alexandru.ardelean@analog.com>
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
The default CS change delay is 10 uS, while the ADIS16460 requires a
minimum of 16 uS.

As it turns out, the SPI framework support already has support for this
feature, which is currently present in the for-next branch:
   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=0ff2de8bb163551ec4230a5a6f3c40c1f6adec4f

This changeset now makes use of that feature, to allow longer CS change
times (as needed) for ADIS16460.

The SPI patch is present in the iio/testing branch, but not present in the
iio/togreg branch.

Changelog v3 -> v4:
* for SPI: no change
* for ADIS lib: use existing `cs_change_delay` feature (from SPI)
* for DT: no change

Changelog v2 -> v3:
* for SPI:
  * used `cs_change_delay` instead of `cs_change_delay_usecs` (i.e. removed
    `_usecs` suffix
  * used SPI specific subject line for SPI patch
* for ADIS lib:
  * updated to use the `cs_change_delay`
* for DT:
  * added Rob's `Reviewed-by` tag

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

Alexandru Ardelean (3):
  iio: imu: adis: Add support for SPI transfer cs_change_delay
  iio: imu: Add support for the ADIS16460 IMU
  dt-bindings: iio: imu: add bindings for ADIS16460

 .../bindings/iio/imu/adi,adis16460.yaml       |  53 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/imu/Kconfig                       |  12 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/adis.c                        |  12 +
 drivers/iio/imu/adis16460.c                   | 489 ++++++++++++++++++
 include/linux/iio/imu/adis.h                  |   2 +
 7 files changed, 577 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
 create mode 100644 drivers/iio/imu/adis16460.c

-- 
2.20.1
