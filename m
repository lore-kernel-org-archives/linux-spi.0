From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 0/3] Fix MODULE_LICENSE of bcm2835 drivers
Date: Wed, 7 Nov 2018 19:50:07 +0100 (CET)
Message-ID: <815844594.141792.1541616607053@email.ionos.de>
References: <1540292769-5905-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Chris Boot <bootc@bootc.net>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, linux-spi@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, Florian Meier <florian.meier@koalo.de>,
 dmaengine@vger.kernel.org, Martin Sperl <kernel@martin.sperl.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>
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

Hi Mark,
hi Vinod,

> Stefan Wahren <stefan.wahren@i2se.com> hat am 23. Oktober 2018 um 13:06 geschrieben:
> 
> 
> In preparation of a treewide switch of all bcm2835 drivers to SPDX tags,
> we need to make sure that the license text and MODULE_LICENSE matches.
> 
> This series starts sooner than usual to have more time to collect the authors
> ACK.
> 
> Stefan Wahren (3):
>   clk: bcm2835: make license text and module license match
>   dma: bcm2835: make license text and module license match
>   spi: bcm2835: make license text and module license match
> 
>  drivers/clk/bcm/clk-bcm2835-aux.c | 2 +-
>  drivers/clk/bcm/clk-bcm2835.c     | 2 +-
>  drivers/dma/bcm2835-dma.c         | 2 +-
>  drivers/spi/spi-bcm2835.c         | 2 +-
>  drivers/spi/spi-bcm2835aux.c      | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 

since i didn't receive any objections from the authors, could you please apply or should i resend with Eric's Reviewed-by?
