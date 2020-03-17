From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 17/28] dt-bindings: mmc: Fix up clk-phase-sd-hs in an
 example
Date: Tue, 17 Mar 2020 13:04:55 +0300
Message-ID: <d7ccf5c1-4bfa-2fd2-b32d-a520e96bdd1e@cogentembedded.com>
References: <20200317093922.20785-1-lkundrak@v3.sk>
 <20200317093922.20785-18-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20200317093922.20785-18-lkundrak@v3.sk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 17.03.2020 12:39, Lubomir Rintel wrote:

> This way the validator can know that the two cells constitute a singlej

    Single?

> pair of clock phase degrees value, not separate items Otherwise it is

    Forgot a period after "items"?

> unhappy:
> 
>    mmc-controller.example.dt.yaml: mmc@ab000000: clk-phase-sd-hs:0:
>        [63] is too short
>    mmc-controller.example.dt.yaml: mmc@ab000000: clk-phase-sd-hs:1:
>        [72] is too short
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
[...]

MBR, Sergei
