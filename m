From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4] gpio: mcp23s08: convert driver to DT
Date: Wed, 10 Apr 2013 21:43:10 +0200
Message-ID: <CACRpkdY0XjHokUfXWQmgNAwrZOuuyfYcyE-9ihYtxKONEUmjuA@mail.gmail.com>
References: <1365069722-15408-1-git-send-email-larsi@wh2.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lars Poeschel <poeschel@lemonage.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Rob Landley <rob@landley.net>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	spi mailing list <spi-devel-general@lists.sourceforge.net>,
	Peter Korsgaard <jacmet@sunsite.dk>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Lars Poeschel <larsi@wh2.tu-dresden.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365069722-15408-1-git-send-email-larsi@wh2.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Apr 4, 2013 at 12:02 PM, Lars Poeschel <larsi@wh2.tu-dresden.de> wrote:

> From: Lars Poeschel <poeschel@lemonage.de>
>
> This converts the mcp23s08 driver to be able to be used with device
> tree.
> There is a "spi-present-mask" device tree property, that allows to
> use multiple of this spi chips on the same chipselect.
>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
> v4:
> - removed the ability to specify the pullup from device tree
> - updated binding doc

Patch applied!

Thanks,
Linus Walleij
