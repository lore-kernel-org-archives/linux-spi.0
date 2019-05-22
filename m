From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: Convert Arm pl022 to json-schema
Date: Wed, 22 May 2019 07:49:44 -0500
Message-ID: <CAL_Jsq+JimAYW9GiPz6_hNJfnA+8bnN=kPDOEJFPyt+57bwriw@mail.gmail.com>
References: <20190521212325.16639-1-robh@kernel.org> <20190522104226.nwcvx33akt6q576m@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522104226.nwcvx33akt6q576m@flea>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 22, 2019 at 5:42 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi Rob,
>
> On Tue, May 21, 2019 at 04:23:24PM -0500, Rob Herring wrote:
> > +allOf:
> > +  - $ref: "spi-controller.yaml#"
>
> You're using a different construct on the spi-gpio binding you just
> sent (/schemas/spi/spi-controller.yaml).
>
> Is that on purpose?

No. This one is correct (though both work).

Rob
