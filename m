From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 2/2] spi/pl022: Add devicetree support
Date: Wed, 22 Aug 2012 13:15:31 +0200
Message-ID: <CACRpkdbpxZasesNb=uBv_+9_wnyiV79qj4jfSKhYwqbFKXQ+9Q@mail.gmail.com>
References: <1345564885-11970-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: aletes.xgr@gmail.com, broonie@opensource.wolfsonmicro.com,
	grant.likely@secretlab.ca, rob.herring@calxeda.com,
	rob@landley.net, devicetree-discuss@lists.ozlabs.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	gabriel.fernandez@stericsson.com, lee.jones@linaro.org,
	viresh.kumar@linaro.org, sachin.verma@st.co
To: Roland Stigge <stigge@antcom.de>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1345564885-11970-1-git-send-email-stigge@antcom.de>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Aug 21, 2012 at 6:01 PM, Roland Stigge <stigge@antcom.de> wrote:

> This patch adds device tree support to the spi-pl022 driver.
(...)

> --- linux-2.6.orig/Documentation/devicetree/bindings/spi/spi_pl022.txt
> +++ linux-2.6/Documentation/devicetree/bindings/spi/spi_pl022.txt
> @@ -6,7 +6,22 @@ Required properties:
>  - interrupts : Should contain SPI controller interrupt
>
>  Optional properties:
> +- num-cs : total number of chipselects

I don't know if it's proper to duplicate but atleast *also* patch
Documentation/devicetree/bindings/gpio/gpio.txt to indicate that
this is a generic property on all GPIO drivers.

The rest looks good.

Yours,
Linus Walleij
