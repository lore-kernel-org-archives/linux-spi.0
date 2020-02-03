From: <patrice.chotard-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 0/2] spi: stm32-qspi: rework probe error path
Date: Mon, 3 Feb 2020 14:50:46 +0100
Message-ID: <20200203135048.1299-1-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <patrice.chotard-qxv4g6HH51o@public.gmane.org>, <christophe.kerello-qxv4g6HH51o@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>

This series is fixing the probe error path of spi-stm32-qspi driver: 
  - it allows to defer probe if reset controller driver is not yet probed.
  - if fixes the error path in releasing only allocated ressouces in case of error.

Etienne Carriere (1):
  spi: stm32-qspi: defer probe for reset controller

Lionel Debieve (1):
  spi: stm32-qspi: properly manage probe errors

 drivers/spi/spi-stm32-qspi.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

-- 
2.17.1
