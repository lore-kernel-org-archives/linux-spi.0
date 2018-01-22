From: Ben Whitten <ben.whitten@gmail.com>
Subject: [RFC] Add ability to multiplex SPI bus
Date: Mon, 22 Jan 2018 22:51:11 +0000
Message-ID: <1516661472-16452-1-git-send-email-ben.whitten@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Whitten <ben.whitten@gmail.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

A chip that I am working on acts as an SPI multiplexer for downstream radios,
this patch adds basic support for adding an SPI mux with DT.

The mux API is modeled on the I2C mux way of doing things with the addition of
being able to override the transfer_one_message. This is due to my mux exposing
the downstream radios through its regmap and not straight on the bus.

This is a first proof of concept and I'm expecting a few revisions, which is
why there is no documentation yet.

Thanks!

Ben Whitten (1):
  spi: add spi multiplexing functions for dt

 drivers/spi/Kconfig     |  10 +++
 drivers/spi/Makefile    |   3 +
 drivers/spi/spi-mux.c   | 181 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi-mux.h |  55 +++++++++++++++
 4 files changed, 249 insertions(+)
 create mode 100644 drivers/spi/spi-mux.c
 create mode 100644 include/linux/spi-mux.h

-- 
2.7.4
