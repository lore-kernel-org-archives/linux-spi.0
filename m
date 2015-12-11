From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: GPIO: Add generic serializer binding
Date: Fri, 11 Dec 2015 22:48:41 +0100
Message-ID: <CACRpkdaV_dxzWUQcJ8pwPUDQNJ8qLhCvLvE9tBYFcTTGMoumWQ@mail.gmail.com>
References: <1449863184-29668-1-git-send-email-afd@ti.com>
	<1449863184-29668-2-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexandre Courbot <gnurou@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "Andrew F. Davis" <afd@ti.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449863184-29668-2-git-send-email-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Dec 11, 2015 at 8:46 PM, Andrew F. Davis <afd@ti.com> wrote:

> Add binding for generic parallel-in/serial-out shift register devices
> used as GPIO.
>
> Signed-off-by: Andrew F. Davis <afd@ti.com>

> +Generic Parallel-in/Serial-out Shift Register GPIO Driver
> +
> +This binding describes generic parallel-in/serial-out shift register
> +devices that can be used for GPI (General Purpose Input). This includes
> +SN74165 serial-out shift registers and the SN65HVS88x series of
> +industrial serializers.
> +
> +Required properties:
> + - compatible          : Should be "pisosr-gpio".

I think it should also define compatible strings on the "vendor,device"
format apart from the generic compatible. Sooner or later we may need
to differentiate them and then that comes in handy.

> + - gpio-controller     : Marks the device node as a GPIO controller.
> + - #gpio-cells         : Should be two. For consumer use see gpio.txt.
> +
> +Optional properties:
> + - ngpios              : Number of GPIO lines, default is 8.

If you didn't do "pisosr-gpio" but instead "foo,sn74165", maybe you
don't need to have this in the device tree but instead it can be
determined from the compatible string?

In that case do that.

> + - load-gpios          : GPIO pin specifier attached to load enable, this
> +                         pin is pulsed before reading from the device to
> +                         load input pin values into the the device.

OK seems necessary.

Yours,
Linus Walleij
