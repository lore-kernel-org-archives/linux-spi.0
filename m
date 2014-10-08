From: Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH] spi: pl022: Fix broken spidev when DMA is enabled
Date: Wed, 8 Oct 2014 09:14:35 -0700
Message-ID: <543562EB.8060300@broadcom.com>
References: <rjui@broadcom.com> <1412743127-4523-1-git-send-email-rjui@broadcom.com> <20141008112143.GT4609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	JD Zheng <jdzheng@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
To: Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141008112143.GT4609@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 10/8/2014 4:21 AM, Mark Brown wrote:
> On Tue, Oct 07, 2014 at 09:38:47PM -0700, Ray Jui wrote:
>
>> The PL022 SPI driver maps the DMA RX buffer before the DMA TX buffer. In
>> most cases, the sequence of the mapping does not matter. But in cases
>> where TX and RX happen to use the same buffer, e.g., spidev, it causes
>> the cached TX data not written to memory, because the same memory has
>> been marked invalid when dma_map_sg on the RX buffer is called
>
> This seems like it is a bug in spidev, using the same buffer simultaneously
> for both directions isn't something I'd think would be expected to work
> reliably unless it was explicitly mapped as bidirectional.
>
Hi Mark,

Thanks for the reply. It looks like you are also the maintainer of 
spidev. In this case, could you please help to confirm that you expect 
spidev to use separate buffers for TX and RX? If so, I can go ahead and 
make the change in spidev.

+ Grant

Thanks,

Ray
