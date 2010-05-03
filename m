From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [spi-devel-general] [PATCH v6 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
Date: Mon, 3 May 2010 02:18:44 +0200
Message-ID: <h2r63386a3d1005021718k31125e4fz43a08025997b5c5c@mail.gmail.com>
References: <cover.1272805161.git.mika.westerberg@iki.fi>
	<0dce0e9fdb6af35854d26d7bd0d8af5a5ea8f76a.1272805161.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net, ryan@bluewatersys.com,
	martinwguy@gmail.com, linux-arm-kernel@lists.infradead.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0dce0e9fdb6af35854d26d7bd0d8af5a5ea8f76a.1272805161.git.mika.westerberg@iki.fi>
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

2010/5/2 Mika Westerberg <mika.westerberg@iki.fi>:

> This patch adds an SPI master driver for the Cirrus EP93xx SPI controller=
 found
> in EP93xx chips.
(...)
> +#define SSPCR0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0000
> +#define SSPCR0_MODE_SHIFT =A0 =A0 =A06
> +#define SSPCR0_SCR_SHIFT =A0 =A0 =A0 8
> +
> +#define SSPCR1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0004
> +#define SSPCR1_RIE =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
> +#define SSPCR1_TIE =A0 =A0 =A0 =A0 =A0 =A0 BIT(1)
> +#define SSPCR1_RORIE =A0 =A0 =A0 =A0 =A0 BIT(2)
> +#define SSPCR1_LBM =A0 =A0 =A0 =A0 =A0 =A0 BIT(3)
> +#define SSPCR1_SSE =A0 =A0 =A0 =A0 =A0 =A0 BIT(4)
> +#define SSPCR1_MS =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(5)
> +#define SSPCR1_SOD =A0 =A0 =A0 =A0 =A0 =A0 BIT(6)
> +
> +#define SSPDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0008
> +
> +#define SSPSR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x000c
> +#define SSPSR_TFE =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(0)
> +#define SSPSR_TNF =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(1)
> +#define SSPSR_RNE =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(2)
> +#define SSPSR_RFF =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(3)
> +#define SSPSR_BSY =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(4)
> +#define SSPCPSR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0010
> +
> +#define SSPIIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0014
> +#define SSPIIR_RIS =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
> +#define SSPIIR_TIS =A0 =A0 =A0 =A0 =A0 =A0 BIT(1)
> +#define SSPIIR_RORIS =A0 =A0 =A0 =A0 =A0 BIT(2)
> +#define SSPICR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSPIIR

When I look at this it's quite obvious that this is the same hardware or ve=
ry
close (maybe a redux version) of the thing supported by
drivers/spi/amba-pl022.c.

What is the difference really? I suspect this is a PL022 PrimeCell straight=
 off.
Even the CPSR algorithm is the same, just written differently.

Can you make a hexdump of the PrimeCell ID registers at offset
base+0xffe0..0xffff and post the contents?

Yours,
Linus Walleij
