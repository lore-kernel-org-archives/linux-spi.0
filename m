From: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [Patch v2 0/3] spi: qup: Fixes and new version support
Date: Thu, 12 Jun 2014 14:34:09 -0500
Message-ID: <1402601652-24641-1-git-send-email-agross@codeaurora.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Daniel Sneddon <dsneddon-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>,
	Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>,
	Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This set of patches provides a few fixes for the SPI QUP driver and support for
an earlier version of the QUP.

The first patch removes the use of the controller's own chip select
functionality.  The user should instead use GPIOs and make use of the SPI core's
GPIO chip select feature.

The second patch addresses failures during probing of slave devices that
required SPI transactions.  The spi_register_master needs to be called after
the runtime pm is initialized.

The last patch adds support for V1.1.1 of the QUP.  This version of the
controller is present in earlier devices (APQ8064, IPQ8064, and MSM8960).

Andy Gross (3):
  spi: qup: Remove chip select function
  spi: qup: Fix order of spi_register_master
  spi: qup: Add support for v1.1.1

 .../devicetree/bindings/spi/qcom,spi-qup.txt       |   12 ++-
 drivers/spi/spi-qup.c                              |   80 +++++++++-----------
 2 files changed, 46 insertions(+), 46 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
