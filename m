From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 0/3] Allow specifying properties with spi_register_board_info
Date: Mon, 27 Feb 2017 20:18:54 -0800
Message-ID: <20170228041857.13292-1-dmitry.torokhov@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

I am trying to convert some input drivers to use only generic device
properties, and get rid of legacy platform data. For that I need to be
able to attach property lists to devices before they are registered, and
quite a few boards use spi_register_board_info() to create their devices.

v2: change patch #2 from kmemdup to kmalloc + copy as they are different
    data types.

v1: initial posting

Dmitry Torokhov (3):
  spi: allow attaching device properties to SPI board info
  spi: allocate spi_board_info entries one by one
  spi: allow registering empty spi_board_info lists

 drivers/spi/spi.c       | 40 ++++++++++++++++++++++++++++------------
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 32 insertions(+), 12 deletions(-)

-- 
Dmitry
