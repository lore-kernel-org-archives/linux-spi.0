From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: amba_pl022 spi->mode fix/cleanup patches
Date: Mon, 13 Sep 2010 17:19:31 +0200
Message-ID: <AANLkTimtR6+TFX8w1_6MEEqbvk5-StkUTn5kKd4q3DeZ@mail.gmail.com>
References: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: rabin.vincent@stericsson.com, linux@arm.linux.org.uk, sameo@linux.intel.com,
	Lukasz.Baj@tieto.com, srinidhi.kasagar@stericsson.com,
	linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
	tj@kernel.org, spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: wellsk40@gmail.com
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

2010/9/10  <wellsk40@gmail.com>:

> This patch series updates drivers and platforms that depend on the
> amba_pl022 driver and use the pl022_config_chip structure for
> setting up the SPI mode and data transfer width.

I get regressions from the ab8500-spi.c driver from this patch:

> ssp-pl022 ssp0: ARM PL022 driver, device ID: 0x01080022
> pl022: mapped registers from 0x80002000 to d0834000
> ab8500-spi spi0.0: unknown chip, revision: 0x80
> ab8500-spi: probe of spi0.0 failed with error -22

The 0x80 above used to be 0x00 before these patches.
So all of a sudden bit 7 gets set...

I don't know why this happens, probably some flag that used to
be set had not been properly propagated in the first patch to alter
the AB8500 device registration?

Yours,
Linus Walleij
