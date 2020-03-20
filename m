From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 13/28] dt-bindings: serial: move Marvell compatible
 string to 8250 binding doc
Date: Fri, 20 Mar 2020 10:24:52 +0100
Message-ID: <20200320092452.GA24507@furthur.local>
References: <20200317093922.20785-1-lkundrak@v3.sk>
 <20200317093922.20785-14-lkundrak@v3.sk>
 <CAL_Jsq+wG+DTZ8Vxcw=NR2isABGrkoDiBt-uG9+NF6qdWuU62Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        devicetree@vger.kerne
To: Rob Herring <robh+dt@kernel.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+wG+DTZ8Vxcw=NR2isABGrkoDiBt-uG9+NF6qdWuU62Q@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Mar 19, 2020 at 10:11:02AM -0600, Rob Herring wrote:
> On Tue, Mar 17, 2020 at 3:40 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > These ports are compatible with NS8250 and handled by the same driver.
> > Get rid of the extra document that fails to document the properties that
> > are actually supported.
> >
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  Documentation/devicetree/bindings/serial/8250.txt        | 2 ++
> >  Documentation/devicetree/bindings/serial/mrvl-serial.txt | 4 ----
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/serial/mrvl-serial.txt
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> I'd really like to see 8250.txt converted to schema.

I'll follow up just with that.

Thanks quarantine.

> Rob

Lubo
