From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 0/6] Optimize Spreadtrum ADI driver
Date: Fri, 26 Jul 2019 15:20:47 +0800
Message-ID: <cover.1564125131.git.baolin.wang@linaro.org>
Cc: weicx@spreadst.com, sherry.zong@unisoc.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patchset did some optimization to remove some redundant code,
add more reboot mode support and change hardware spinlock support
to be optional.

Baolin Wang (3):
  spi: sprd: adi: Remove redundant address bits setting
  spi: sprd: adi: Change hwlock to be optional
  dt-bindings: spi: sprd: Change the hwlock support to be optional

Chenxu Wei (1):
  spi: sprd: adi: Add a reset reason for TOS panic

Sherry Zong (2):
  spi: sprd: adi: Add a reset reason for factory test mode
  spi: sprd: adi: Add a reset reason for watchdog mode

 .../devicetree/bindings/spi/spi-sprd-adi.txt       |   11 ++-
 drivers/spi/spi-sprd-adi.c                         |   92 ++++++++++++++------
 2 files changed, 71 insertions(+), 32 deletions(-)

-- 
1.7.9.5
