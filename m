From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 0/3] spi: introduce `struct spi_delay` data-type
Date: Mon, 16 Sep 2019 10:10:21 +0300
Message-ID: <20190916071024.21447-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <jic23@kernel.org>, <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Discussion reference:
  https://lore.kernel.org/lkml/20190913114550.956-1-alexandru.ardelean@analog.com/

This changeset introduces an `spi_delay` struct/data-type and makes the
IIO ADIS driver library the first user of this.

The patchset base is Jonathan's `iio/togreg` branch, but it also applies on
Mark's `spi/for-next` branch.

The reasons for choosing `cs_change_delay`, is:
1. this change introduces delay units
2. it is not yet widely used, meaning it can still be changed 

Some delays like `delay` from `spi_transfer` would require a longer
update-time change & discussion.

Alexandru Ardelean (3):
  spi: move `cs_change_delay` backwards compat logic outside switch
  spi: introduce spi_delay struct as "value + unit" &  spi_delay_exec()
  spi: make `cs_change_delay` the first user of the `spi_delay` logic

 drivers/iio/imu/adis.c  | 24 +++++++--------
 drivers/spi/spi.c       | 68 +++++++++++++++++++++++++++++++----------
 include/linux/spi/spi.h | 22 +++++++++----
 3 files changed, 80 insertions(+), 34 deletions(-)

--

Changelog v2 -> v3:
* squash patches 3 & 4 into a single patch; otherwise the kernel is in
  broken state between those 2 patches

Changelog v1 -> v2:
* split away from the RFC patchset, which aims to be a broader explanation
  for this changeset; parts of v1 are not 100% defined yet, and may require
  some discussion and refinement.
 
2.20.1
