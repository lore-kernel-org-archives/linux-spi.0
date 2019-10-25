From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] spi: Fix NULL pointer when setting SPI_CS_HIGH for GPIO CS
Date: Fri, 25 Oct 2019 09:50:50 +0200
Message-ID: <87woctp8kl.fsf@FE-laptop>
References: <20191024141309.22434-1-gregory.clement@bootlin.com> <20191024193225.GM46373@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "kernelci.org bot" <bot@kernelci.org>, stable@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191024193225.GM46373@sirena.co.uk>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

> On Thu, Oct 24, 2019 at 04:13:09PM +0200, Gregory CLEMENT wrote:
>> Even if the flag use_gpio_descriptors is set, it is possible that
>> cs_gpiods was not allocated, which leads to a kernel crash:
>> 
>> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> pgd = (ptrval)
>> [00000000] *pgd=00000000
>> Internal error: Oops: 5 [#1] ARM
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.4.0-rc3 #1
>> Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>> PC is at of_register_spi_device+0x20c/0x38c
>> LR is at __of_find_property+0x3c/0x60
>> pc : [<c09b45dc>]    lr : [<c0c47a98>]    psr: 20000013
>
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative then it's
> usually better to pull out the relevant sections.

You can remove it while applying it, or I can send a v2.

Actually I thought you would squash it with the initial patch to avoid
the bisectability break.

Gregory


-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
