From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 05/28] ARM: dts: pxa3xx: Fix up encoding of the /gpio interrupts property
Date: Sat, 21 Mar 2020 08:36:10 +0100
Message-ID: <87y2rudus5.fsf@belgarion.home>
References: <20200317093922.20785-1-lkundrak@v3.sk>
        <20200317093922.20785-6-lkundrak@v3.sk>
        <20200317132854.GF24270@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
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
        devicetree@vger.kernel.org, linux
To: Andrew Lunn <andrew@lunn.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317132854.GF24270@lunn.ch> (Andrew Lunn's message of "Tue,
        17 Mar 2020 14:28:54 +0100")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Andrew Lunn <andrew@lunn.ch> writes:

> On Tue, Mar 17, 2020 at 10:38:59AM +0100, Lubomir Rintel wrote:
>> This way the device tree validator learns that each cell of the property
>> constitutes a separate item. Otherwise it gets unnecessairly upset:
>> 
>>   pxa300-raumfeld-speaker-s.dt.yaml: gpio@40e00000: interrupts:
>>       [[8, 9, 10]] is too short
>> 
>> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr.>

-- 
Robert
