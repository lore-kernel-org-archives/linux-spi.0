From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] ARM: sunxi: spi: use proper errno when
 message is too long.
Date: Sat, 25 Apr 2015 21:21:07 +0200
Message-ID: <4c27d44b2bdd759424ce4a4b2e8f6abf5d5a6735.1430034797.git.hramrach@gmail.com>
References: <cover.1430034797.git.hramrach@gmail.com>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
  Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
  linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
Return-path: <linux-sunxi+bncBCQMLUOX54MBBGF56KUQKGQEBHR2RIY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <cover.1430034797.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-sun4i.c | 2 +-
 drivers/spi/spi-sun6i.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index fbb0a4d..8238b4e 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -176,7 +176,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	/* We don't support transfer larger than the FIFO */
 	if (tfr->len > SUN4I_FIFO_DEPTH)
-		return -EINVAL;
+		return -EMSGSIZE;
 
 	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index ac48f59..0f5dd91 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -166,7 +166,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 
 	/* We don't support transfer larger than the FIFO */
 	if (tfr->len > SUN6I_FIFO_DEPTH)
-		return -EINVAL;
+		return -EMSGSIZE;
 
 	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
-- 
2.1.4
