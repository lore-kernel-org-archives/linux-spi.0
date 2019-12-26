From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 4/5] spi: uniphier: Add SPI_LOOP to the capabilities
Date: Thu, 26 Dec 2019 10:55:36 +0900
Message-ID: <20191226105536.302C.4A936039@socionext.com>
References: <1577149107-30670-5-git-send-email-hayashi.kunihiko@socionext.com> <20191225180142.GD27497@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191225180142.GD27497@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,
Thanks for your comment.

On Wed, 25 Dec 2019 18:01:42 +0000 <broonie@kernel.org> wrote:
> On Tue, Dec 24, 2019 at 09:58:26AM +0900, Kunihiko Hayashi wrote:
> > Add SPI_LOOP to the capabilities to support loopback mode.
> 
> >  	master->min_speed_hz = DIV_ROUND_UP(clk_rate, SSI_MAX_CLK_DIVIDER);
> > -	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
> > +	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
> > +			    SPI_LOOP;
> 
> I'd expect to see a matching change that configures the hardware
> in loopback mode when the driver is in SPI_MODE?  There's nothing
> in the existing driver.

I see. When doing loopback test using spi-loopback-test.c, I thought
'loop_req=1' option was needed, however, the controller doesn't need it.
We can ignore this patch.

Thank you,

---
Best Regards,
Kunihiko Hayashi
