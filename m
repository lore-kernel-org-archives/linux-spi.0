From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFC 0/4] clk/driver: platform: Fix kfree() of const memory on setting driver_override
Date: Mon, 18 Feb 2019 11:15:56 +0100
Message-ID: <1550484960-2392-1-git-send-email-krzk@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

The problem
===========
Several device types (platform, amba, spi etc.) provide a driver_override
field.  On sysfs store or during device removal, they kfree() the
existing value.

However the users are unaware of this and set the driver_override like:

 	pdev->driver_override = "exynos5-subcmu";

which obviously leads to error.

Solution
========
I provided simple helper for platform device.  If this approach is
acceptable, I can convert also other buses, like AMBA, SPI.


Dependencies and pick up order
==============================
Patch 1: please pick it as is through clock tree
Patch 3: Depends on patch 1 (merge conflict) and 2.
Patch 4: Depends on patch 2.

Best regards,
Krzysztof


Krzysztof Kozlowski (4):
  clk: samsung: exynos5: Fix possible NULL pointer exception on
    platform_device_alloc() failure
  driver: platform: Provide helper for safer setting of driver_override
  clk: samsung: exynos5: Fix kfree() of const memory on setting
    driver_override
  slimbus: ngd: Fix kfree() of const memory on setting driver_override

 drivers/base/platform.c                  | 63 ++++++++++++++++++++++----------
 drivers/clk/samsung/clk-exynos5-subcmu.c | 12 ++++--
 drivers/slimbus/qcom-ngd-ctrl.c          |  2 +-
 include/linux/platform_device.h          |  9 ++++-
 4 files changed, 61 insertions(+), 25 deletions(-)

-- 
2.7.4
