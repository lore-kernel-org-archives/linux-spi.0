From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 06/28] ARM: dts: pxa910: Fix the gpio interrupt cell
 number
Date: Tue, 17 Mar 2020 14:29:16 +0100
Message-ID: <20200317132916.GG24270@lunn.ch>
References: <20200317093922.20785-1-lkundrak@v3.sk>
 <20200317093922.20785-7-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
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
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        devicetree@vger.k
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200317093922.20785-7-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Mar 17, 2020 at 10:39:00AM +0100, Lubomir Rintel wrote:
> gpio-pxa uses two cell to encode the interrupt source: the pin number
> and the trigger type. Adjust the device node accordingly.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
