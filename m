From: Jim Quinlan <james.quinlan@broadcom.com>
Subject: [PATCH v2 0/1] spi: bcm2835: no dev_err() on clk_get() -EPROBE_DEFER
Date: Mon, 16 Dec 2019 18:08:01 -0500
Message-ID: <20191216230802.45715-1-jquinlan@broadcom.com>
Cc: Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jim Quinlan <james.quinlan@broadcom.com>
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Changes in v2:
- use dev_dbg() for -EPROBE_DEFER, dev_err() for other errors.

Jim Quinlan (1):
  spi: bcm2835: no dev_err() on clk_get() -EPROBE_DEFER

 drivers/spi/spi-bcm2835.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.17.1
