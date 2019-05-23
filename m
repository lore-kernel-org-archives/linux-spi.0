From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 00/12] LP0 entry and exit support for Tegra210
Date: Wed, 22 May 2019 18:28:29 -0700
Message-ID: <1558574922-16531-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <broonie@kernel.org>,
        <natechancellor@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch series includes Tegra210 deepsleep or LP0 support with
deep sleep exit through RTC alarm wake and power button wake events.

This series also includes save and restore of PLLs, clocks, OSC contexts
for basic LP0 exit.

This patch series is doesn't support for 100% suspend/resume to fully
functional state and we are working on some more drivers suspend and
resume implementations.

Sowjanya Komatineni (12):
  irqchip: tegra: do not disable COP IRQ during suspend
  pinctrl: tegra: add suspend and resume support
  clk: tegra: save and restore PLLs state for system
  clk: tegra: add support for peripheral clock suspend and resume
  clk: tegra: add support for OSC clock resume
  clk: tegra: add suspend resume support for DFLL clock
  clk: tegra: support for Tegra210 clocks suspend-resume
  soc/tegra: pmc: allow support for more tegra wake models
  soc/tegra: pmc: add pmc wake support for tegra210
  gpio: tegra: implement wake event support for Tegra210 and prior GPIO
  soc/tegra: pmc: configure tegra deep sleep control settings
  arm64: tegra: enable wake from deep sleep on RTC alarm.

 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi |   7 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi       |   5 +-
 drivers/clk/tegra/clk-dfll.c                   |  82 ++++++
 drivers/clk/tegra/clk-dfll.h                   |   2 +
 drivers/clk/tegra/clk-divider.c                |  19 ++
 drivers/clk/tegra/clk-pll-out.c                |  25 ++
 drivers/clk/tegra/clk-pll.c                    | 220 ++++++++++++--
 drivers/clk/tegra/clk-tegra-fixed.c            |  15 +
 drivers/clk/tegra/clk-tegra210.c               | 382 +++++++++++++++++++++++++
 drivers/clk/tegra/clk.c                        |  74 ++++-
 drivers/clk/tegra/clk.h                        |  18 ++
 drivers/gpio/gpio-tegra.c                      | 109 ++++++-
 drivers/irqchip/irq-tegra.c                    |  10 +-
 drivers/pinctrl/tegra/pinctrl-tegra.c          |  68 ++++-
 drivers/pinctrl/tegra/pinctrl-tegra.h          |   3 +
 drivers/pinctrl/tegra/pinctrl-tegra114.c       |   1 +
 drivers/pinctrl/tegra/pinctrl-tegra124.c       |   1 +
 drivers/pinctrl/tegra/pinctrl-tegra20.c        |   1 +
 drivers/pinctrl/tegra/pinctrl-tegra210.c       |   1 +
 drivers/pinctrl/tegra/pinctrl-tegra30.c        |   1 +
 drivers/soc/tegra/pmc.c                        | 159 +++++++++-
 21 files changed, 1167 insertions(+), 36 deletions(-)

-- 
2.7.4
