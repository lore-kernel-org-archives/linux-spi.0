From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v4 5/5] ARM: dts: at91: sam9x60: add device tree for soc
 and board
Date: Thu, 16 Jan 2020 14:52:08 +0100
Message-ID: <20200116135208.GG100374@piout.net>
References: <1579085987-13976-1-git-send-email-claudiu.beznea@microchip.com>
 <1579085987-13976-6-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        a.zummo@towertech.it, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        Sandeep Sheriker Mallikarjun
        <sandeepsheriker.mallikarjun@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1579085987-13976-6-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 15/01/2020 12:59:47+0200, Claudiu Beznea wrote:
> From: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
> 
> Add device tree files for SAM9X60 SoC and SAM9X60-EK board.
> 
> Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  arch/arm/boot/dts/Makefile           |   2 +
>  arch/arm/boot/dts/at91-sam9x60ek.dts | 647 ++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/sam9x60.dtsi       | 691 +++++++++++++++++++++++++++++++++++
>  3 files changed, 1340 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-sam9x60ek.dts
>  create mode 100644 arch/arm/boot/dts/sam9x60.dtsi
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
