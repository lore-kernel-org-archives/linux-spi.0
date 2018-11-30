From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 0/5] spi: imx: Fix polarity switching for mx51-ecspi
Date: Fri, 30 Nov 2018 07:47:04 +0100
Message-ID: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex@denx.de>, linux-arm-kernel@lists.infradead.org,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hello,

compared to v2 sent with Message-Id:
20181123085158.24753-1-u.kleine-koenig@pengutronix.de I squashed in the
change suggested by Robin (with s/filed/field/). Thanks for testing and
feedback.

Best regards
Uwe
