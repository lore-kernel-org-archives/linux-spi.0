From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Subject: [PATCH 0/2] spi: fix spi driver for UniPhier SoC
Date: Wed, 26 Jun 2019 09:41:46 +0900
Message-ID: <1561509708-4175-1-git-send-email-hayashibara.keiji@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jaswinder.singh@linaro.org, linux-kernel@vger.kernel.org,
 masami.hiramatsu@linaro.org, hayashibara.keiji@socionext.com
To: broonie@kernel.org, yamada.masahiro@socionext.com,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

This series fixes timeout problem and modifies timeout handling.
The zero-length transfer results in two second timeout
and the transfer speed becomes slow.

Keiji Hayashibara (2):
  spi: uniphier: fix timeout error
  spi: uniphier: fix zero-length transfer

 drivers/spi/spi-uniphier.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

-- 
2.7.4
