From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.4 128/350] spi: pxa2xx: Set
 controller->max_transfer_size in dma mode
Date: Thu, 19 Dec 2019 12:35:04 -0500
Message-ID: <20191219173504.GN17708@sasha-vm>
References: <20191210210735.9077-1-sashal@kernel.org>
 <20191210210735.9077-89-sashal@kernel.org>
 <20191211104738.GA3870@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191211104738.GA3870@sirena.org.uk>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 11, 2019 at 10:47:38AM +0000, Mark Brown wrote:
>On Tue, Dec 10, 2019 at 04:03:53PM -0500, Sasha Levin wrote:
>> From: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> [ Upstream commit b2662a164f9dc48da8822e56600686d639056282 ]
>>
>> In DMA mode we have a maximum transfer size, past that the driver
>> falls back to PIO (see the check at the top of pxa2xx_spi_transfer_one).
>> Falling back to PIO for big transfers defeats the point of a dma engine,
>> hence set the max transfer size to inform spi clients that they need
>> to do something smarter.
>
>This won't fix anything by itself, this asks other code to change how it
>behaves which may or may not work in older kernels.

I'll drop it then, thanks!

-- 
Thanks,
Sasha
