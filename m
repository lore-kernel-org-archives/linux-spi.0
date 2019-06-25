From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/5] MAINTAINERS: add ADIS IMU driver library entry
Date: Tue, 25 Jun 2019 16:13:24 +0300
Message-ID: <20190625131328.11883-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This change adds the ADIS driver library to the MAINTAINERS list, and adds
myself as the current maintainer of this library.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1eb971608ac4..544e23753e96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -930,6 +930,13 @@ S:	Supported
 F:	drivers/mux/adgs1408.c
 F:	Documentation/devicetree/bindings/mux/adi,adgs1408.txt
 
+ANALOG DEVICES INC ADIS DRIVER LIBRARY
+M:	Alexandru Ardelean <alexandru.ardelean@analog.com>
+S:	Supported
+L:	linux-iio@vger.kernel.org
+F:	include/linux/iio/imu/adis.h
+F:	drivers/iio/imu/adis.c
+
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-pm@vger.kernel.org
-- 
2.20.1
