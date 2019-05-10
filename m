From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 0/4] spi: A better solution for cros_ec_spi reliability
Date: Fri, 10 May 2019 15:34:33 -0700
Message-ID: <20190510223437.84368-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This series is a much better solution for getting the Chrome OS EC to
talk reliably and replaces commit 37a186225a0c ("platform/chrome:
cros_ec_spi: Transfer messages at high priority").

Note that the cros_ec bits can't land until the SPI bits are
somewhere.  If the SPI bits look OK to land it might be convenient if
they could be placed somewhere with a stable git hash?

Special thanks to Guenter Roeck for pointing out the "realtime"
feature of the SPI framework so I didn't re-invent the wheel.  I have
no idea how I missed it.  :-/


Douglas Anderson (4):
  spi: For controllers that need realtime always use the pump thread
  spi: Allow SPI devices to specify that they are timing sensitive
  platform/chrome: cros_ec_spi: Set ourselves as timing sensitive
  Revert "platform/chrome: cros_ec_spi: Transfer messages at high
    priority"

 drivers/platform/chrome/cros_ec_spi.c | 81 +++------------------------
 drivers/spi/spi.c                     | 41 +++++++++++---
 include/linux/spi/spi.h               |  3 +
 3 files changed, 43 insertions(+), 82 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog
