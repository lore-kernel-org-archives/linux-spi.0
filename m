From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v6 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date: Mon, 08 Oct 2018 16:46:11 -0700
Message-ID: <153904237198.119890.2367876217526144231@swboyd.mtv.corp.google.com>
References: <20181002214709.162330-1-ryandcase@chromium.org>
 <20181002214709.162330-2-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Ryan Case <ryandcase@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Ryan Case <ryandcase@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002214709.162330-2-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Quoting Ryan Case (2018-10-02 14:47:08)
> From: Girish Mahadevan <girishm@codeaurora.org>
> =

> New driver for Qualcomm QuadSPI(QSPI) controller that is used to
> communicate with slaves such as flash memory devices. The QSPI controller
> can operate in 2 or 4 wire mode but only supports SPI Mode 0. The
> controller can also operate in Single or Dual data rate modes.
> =

> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

One nitpick below. Looks better now, thanks!

> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> new file mode 100644
> index 000000000000..b8163b40bb92
> --- /dev/null
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -0,0 +1,581 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/spi/spi.h>
[...]
> +
> +struct qspi_xfer {
> +       union {
> +               const void *tx_buf;
> +               void *rx_buf;
> +       };
> +       unsigned int rem_bytes;
> +       unsigned int buswidth;
> +       enum qspi_dir dir;
> +       bool is_last;
> +};
> +
> +enum qspi_clocks {
> +       QSPI_CLK_CORE,
> +       QSPI_CLK_IFACE,
> +       QSPI_NUM_CLKS
> +};
> +
> +struct qcom_qspi {
> +       void __iomem *base;
> +       struct device *dev;
> +       struct clk_bulk_data clks[QSPI_NUM_CLKS];
> +       struct qspi_xfer xfer;
> +       /* Lock to protect data accessed by IRQs */

Nitpick: What data? Registers? The SPI core can't do it?

> +       spinlock_t lock;
> +};
