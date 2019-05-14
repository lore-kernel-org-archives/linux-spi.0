From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V5 0/4] additional features to Tegra SPI
Date: Mon, 13 May 2019 22:03:51 -0700
Message-ID: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

[V5] : This patch series version includes
	- Updated GPIO based chip select control using GPIO descriptor.
	- HW based chip select implementation is same as V3 but V5
	  has this patch updated to be on top of above changes.
	- HW CS timing implementation is same as V3 but V5
	  has this patch updated to be on top of above changes.
	- support for TX and RX trimmers implementation is same as V3
	  but V5 has this patch updated to be on top of above changes
	  and updated commit description.

[V4] : This version went out accidentally. Please discard.

[V3] : This patch series version includes
	- only patches that are not applied from V2.
	- splitted expanding mode and adding LSByte First support
	  in separate patches and removed DT property for selecting
	  LSByte First.
	- Updated GPIO based chip select control to use spi_set_cs
	  from SPI core.
	- HW based chip select implementation is same as V2 but V3
	  has this patch updated to be on top of above changes.
	- HW CS timing implementation is same as V2 but V3
	  has this patch updated to be on top of above changes.
	- support for TX and RX trimmers implementation is same as V2
	  but V3 has this patch updated to be on top of above changes
	  and updated commit description.

[V2] : This patch series version includes
	- only patches that are not applied from V1.
	- changed order of patches to include all fixes prior to new features
	  support.
	- Removed HW CS timing from DT properties and created set_cs_timing
	  SPI master optional method for SPI controllers to implement and
	  created API spi_cs_timing for SPI client drivers to request CS
	  setup, hold and inactive delay timing configuration.
	- Fixed HW based CS decision to be based on single transfer and
	  cs_change. Remove selection of HW based CS through DT.


Sowjanya Komatineni (4):
  spi: tegra114: add support for gpio based CS
  spi: tegra114: add support for hw based cs
  spi: tegra114: add support for HW CS timing
  spi: tegra114: add support for TX and RX trimmers

 drivers/spi/spi-tegra114.c | 167 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 151 insertions(+), 16 deletions(-)

-- 
2.7.4
