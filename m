From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v3 4/7] dt-bindings: atmel-usart: remove wildcard
Date: Tue, 14 Jan 2020 16:03:53 +0100
Message-ID: <20200114150353.GP3137@piout.net>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
 <1578997397-23165-5-git-send-email-claudiu.beznea@microchip.com>
 <20200114104237.GM3137@piout.net>
 <f3c4d460-cff6-2e14-428a-a732a6bffe38@microchip.com>
 <20200114111704.GN3137@piout.net>
 <a7f9f8c6-7636-6c1d-ecd8-39e5a956b85a@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: robh+dt@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        a.zummo@towertech.it, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-rtc@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a7f9f8c6-7636-6c1d-ecd8-39e5a956b85a@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 14/01/2020 14:58:23+0000, Claudiu.Beznea@microchip.com wrote:
> > Then, what is the point of adding microchip,sam9x60-dbgu ?
> 
> Different meaning for CIDR register bits. Version is kept on bits 4 to 0
> but not documented in public datasheet, so version displayed by
> drivers/soc/atmel/soc.c should work.

But at91_get_cidr_exid_from_dbgu will not find the node unless you use
two fallbacks.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
