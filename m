From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: gpio: prevent memory leak in spi_gpio_probe" to the spi tree
Date: Tue,  1 Oct 2019 18:57:01 +0100 (BST)
Message-ID: <20191001175701.A2CF127429C0@ypsilon.sirena.org.uk>
References: <20190930205241.5483-1-navid.emamdoost@gmail.com>
Cc: "Cc:"@sirena.co.uk, "Cc:"@sirena.co.uk, emamd001@umn.edu,
        kjlu@umn.edu, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        smccaman@umn.edu
To: Navid Emamdoost <navid.emamdoost@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190930205241.5483-1-navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: gpio: prevent memory leak in spi_gpio_probe

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d3b0ffa1d75d5305ebe34735598993afbb8a869d Mon Sep 17 00:00:00 2001
From: Navid Emamdoost <navid.emamdoost@gmail.com>
Date: Mon, 30 Sep 2019 15:52:40 -0500
Subject: [PATCH] spi: gpio: prevent memory leak in spi_gpio_probe

In spi_gpio_probe an SPI master is allocated via spi_alloc_master, but
this controller should be released if devm_add_action_or_reset fails,
otherwise memory leaks. In order to avoid leak spi_contriller_put must
be called in case of failure for devm_add_action_or_reset.

Fixes: 8b797490b4db ("spi: gpio: Make sure spi_master_put() is called in every error path")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Link: https://lore.kernel.org/r/20190930205241.5483-1-navid.emamdoost@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 1d3e23ec20a6..f9c5bbb74714 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -371,8 +371,10 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	status = devm_add_action_or_reset(&pdev->dev, spi_gpio_put, master);
-	if (status)
+	if (status) {
+		spi_master_put(master);
 		return status;
+	}
 
 	if (of_id)
 		status = spi_gpio_probe_dt(pdev, master);
-- 
2.20.1
