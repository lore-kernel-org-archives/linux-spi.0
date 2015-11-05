From: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
Subject: Re: [PATCH v3 6/7] spi: imx: return error from dma channel request
Date: Thu, 5 Nov 2015 17:00:28 +0100
Message-ID: <563B7D1C.7010105@gmail.com>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1446388901-6073-7-git-send-email-anton.bondarenko.sama@gmail.com>
 <20151105085637.GJ8526@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, b38343@freescale.com,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	vladimir_zapolskiy@mentor.com, jiada_wang@mentor.com
To: Sascha Hauer <s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151105085637.GJ8526@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 05.11.2015 09:56, Sascha Hauer wrote:
> On Sun, Nov 01, 2015 at 03:41:40PM +0100, Anton Bondarenko wrote:
>> From: Anton Bondarenko <anton_bondarenko@mentor.com>
>>
>> On SDMA initialization return exactly the same error, which is
>> reported by dma_request_slave_channel_reason(), it is a preceding
>> change to defer SPI DMA initialization, if SDMA module is not yet
>> available.
>
> Maybe something like: "fix probe deferral when dmaengine is not yet
> available" in the subject line will better express that this is a patch
> that should be applied ASAP. Also you can move this up to the front of
> the series when resending.
>
> Sascha
>

This patch itself does not implement deferral for spi-imx if dmaengine 
not ready. The patch targets 2 things: give a bit more detailed error 
information of SPI dma slave channel initialization error and provide a 
basis for the next patch ([PATCH v3 7/7] spi: imx: defer spi 
initialization, if DMA engine is pending).

Regards, Anton
