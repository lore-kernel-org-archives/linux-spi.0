From: Frode Isaksen <fisaksen@baylibre.com>
Subject: Re: Applied "spi: davinci: enable DMA when channels are defined in
 DT" to the spi tree
Date: Fri, 10 Mar 2017 11:24:43 +0100
Message-ID: <8ba9a2e0-6666-958f-b5a7-b73b047bb6ac@baylibre.com>
References: <E1clG07-0006mU-6x@finisterre>
 <11df78f1-7b4e-5093-f166-b3af21c03abc@baylibre.com>
 <20170308124316.56vn2qijllu6mi3v@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Fabien Parent <fparent@baylibre.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, nsekhar@ti.com,
        ptitiano@baylibre.com, khilman@baylibre.com
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170308124316.56vn2qijllu6mi3v@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 08/03/2017 13:43, Mark Brown wrote:
> On Wed, Mar 08, 2017 at 11:35:02AM +0100, Frode Isaksen wrote:
>
>> To avoid data corruption issues with UBIFS volume over SPI NOR, DMA should not be used for vmalloc'ed buffers. The 5'th patch in my series fixes that:
> It's best to always try to ensure that your patch serieses are
> bisectable...
My wrong - do you want me to re-submit the patch series with the the last patch in the series that really enabled DMA ?

Thanks,
Frode
