From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH 0/2] IMG SPFI driver
Date: Wed, 12 Nov 2014 13:37:52 -0800
Message-ID: <1415828274-24727-1-git-send-email-abrestic@chromium.org>
Cc: Andrew Bresticker <abrestic@chromium.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	James Hartley <James.Hartley@imgtec.com>,
	Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This series adds support for the Sychronous Peripheral Flash Interface
master found on IMG SoCs.  The controller supports up to 5 chip-select
lines and single, dual, and optionally quad, mode transfers.

Tested on a platform using the MIPS-based Pistachio SoC with additional
out-of-tree patches - support for Pistachio will be submitted soon.

Based on 3.18-rc4.

Andrew Bresticker (2):
  of: Add binding document for IMG SPFI controller
  spi: Add driver for IMG SPFI controller

 Documentation/devicetree/bindings/spi/spi-img.txt |  37 ++
 drivers/spi/Kconfig                               |   7 +
 drivers/spi/Makefile                              |   1 +
 drivers/spi/spi-img.c                             | 703 ++++++++++++++++++++++
 4 files changed, 748 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-img.txt
 create mode 100644 drivers/spi/spi-img.c

-- 
2.1.0.rc2.206.gedb03e5
