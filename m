From: Joel Holdsworth <joel@airwebreathe.org.uk>
Subject: Re: [PATCH v8 2/3] Documentation: Add binding document for Lattice
 iCE40 FPGA manager
Date: Mon, 7 Nov 2016 11:57:20 -0700
Message-ID: <72ded69b-3103-0e52-b182-82bc0fe61206@airwebreathe.org.uk>
References: <1478486962-26794-1-git-send-email-joel@airwebreathe.org.uk>
 <1478486962-26794-2-git-send-email-joel@airwebreathe.org.uk>
 <7876f66a-f8c2-409b-0f18-e8055ddc7784@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marex@denx.de>, atull@opensource.altera.com,
        moritz.fischer@ettus.com, geert@linux-m68k.org, robh@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, clifford@clifford.at
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7876f66a-f8c2-409b-0f18-e8055ddc7784@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


>> +		cdone-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
>> +		reset-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
>
> Wouldn't it make more sense to have "gpios" and "gpio-names" ? That
> scales better imo, although in this case we cannot really talk about
> scaling.
>

I don't believe that would be conventional. '-gpios' seems to be the 
standard over '-gpio' even for a single GPIO.

Having multiple GPIOs in that field is only relevant when it could be an 
array e.g. multiple chip-select GPIO lines. Not for multiple GPIOs with 
differing functions.

Also it doesn't fit with the way devm_gpiod_get works where you select 
GPIO(s) from the device-tree, and specify whether it's an input or an 
output. In this case one is an output, one is an input.

Joel
