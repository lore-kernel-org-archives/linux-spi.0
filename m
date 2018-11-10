From: kernel@martin.sperl.org
Subject: Re: [PATCH 0/3] Fix MODULE_LICENSE of bcm2835 drivers
Date: Sat, 10 Nov 2018 12:45:09 +0100
Message-ID: <B176A2C1-D221-4F36-9A61-571EF5AB6FEB@martin.sperl.org>
References: <1540292769-5905-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Chris Boot <bootc@bootc.net>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, linux-spi@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>, Florian Meier <florian.meier@koalo.de>,
 dmaengine@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1540292769-5905-1-git-send-email-stefan.wahren@i2se.com>
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


> On 23.10.2018, at 13:06, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> In preparation of a treewide switch of all bcm2835 drivers to SPDX tags,
> we need to make sure that the license text and MODULE_LICENSE matches.
> 
> This series starts sooner than usual to have more time to collect the authors
> ACK.
> 
> Stefan Wahren (3):
>  clk: bcm2835: make license text and module license match
>  dma: bcm2835: make license text and module license match
>  spi: bcm2835: make license text and module license match
> 
> drivers/clk/bcm/clk-bcm2835-aux.c | 2 +-
> drivers/clk/bcm/clk-bcm2835.c     | 2 +-
> drivers/dma/bcm2835-dma.c         | 2 +-
> drivers/spi/spi-bcm2835.c         | 2 +-
> drivers/spi/spi-bcm2835aux.c      | 2 +-
> 5 files changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Martin Sperl <kernel@martin.sperl.org>
