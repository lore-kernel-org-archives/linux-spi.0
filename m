From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] spi: dt-bindings: Convert Arm pl022 to json-schema
Date: Wed, 22 May 2019 12:42:26 +0200
Message-ID: <20190522104226.nwcvx33akt6q576m@flea>
References: <20190521212325.16639-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190521212325.16639-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Rob,

On Tue, May 21, 2019 at 04:23:24PM -0500, Rob Herring wrote:
> +allOf:
> +  - $ref: "spi-controller.yaml#"

You're using a different construct on the spi-gpio binding you just
sent (/schemas/spi/spi-controller.yaml).

Is that on purpose?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
