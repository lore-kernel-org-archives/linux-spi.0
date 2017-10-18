From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] spi: Detach spi device from driver when unregister it
Date: Wed, 18 Oct 2017 15:22:08 +0800
Message-ID: <20171018072208.9791-1-jeffy.chen@rock-chips.com>
Cc: briannorris@chromium.org, heiko@sntech.de,
        gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com,
        rjw@rjwysocki.net, dianders@chromium.org, tfiga@chromium.org,
        broonie@kernel.org, seanpaul@chromium.org,
        thierry.reding@gmail.com, Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Make sure spi device detached before unregistering it.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6e65524cbfd9..9114efb2eb8c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -648,6 +648,8 @@ void spi_unregister_device(struct spi_device *spi)
 	}
 	if (ACPI_COMPANION(&spi->dev))
 		acpi_device_clear_enumerated(ACPI_COMPANION(&spi->dev));
+
+	device_release_driver(&spi->dev);
 	device_unregister(&spi->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_device);
-- 
2.11.0
