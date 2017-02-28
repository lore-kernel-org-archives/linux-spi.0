From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 0/2] Allow specifying properties with spi_register_board_info
Date: Tue, 28 Feb 2017 14:25:17 -0800
Message-ID: <20170228222519.38217-1-dmitry.torokhov@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

I am trying to convert some input drivers to use only generic device
properties, and get rid of legacy platform data. For that I need to be
able to attach property lists to devices before they are registered, and
quite a few boards use spi_register_board_info() to create their devices.

v3: dropped former patch #2 (spi: allocate spi_board_info entries one by
    one), changed patch #1 to not copy empty property sets and also to
    remove added properties when spi_add_device() fails (when it is
    successful driver core will free properties upon device removal).

v2: change patch #2 from kmemdup to kmalloc + copy as they are different
    data types.

v1: initial posting


Dmitry Torokhov (2):
  spi: allow attaching device properties to SPI board info
  spi: allow registering empty spi_board_info lists

 drivers/spi/spi.c       | 34 +++++++++++++++++++++++++++++-----
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 33 insertions(+), 5 deletions(-)

-- 
Dmitry
