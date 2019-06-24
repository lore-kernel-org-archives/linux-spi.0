From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH] spi: spi-gpio: Make probe function __init_or_module
Date: Mon, 24 Jun 2019 20:42:43 +0200
Message-ID: <0323abd9-2c68-2d2e-0140-c34edf983f4f@metux.net>
References: <20190607155631.15072-1-paul@crapouillou.net>
 <20190607155907.GH2456@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: od@zcrc.me, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607155907.GH2456@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 07.06.19 17:59, Mark Brown wrote:
> On Fri, Jun 07, 2019 at 05:56:31PM +0200, Paul Cercueil wrote:
>> This allows the probe function to be dropped after the kernel finished
>> its initialization, in the case where the driver was not compiled as a
>> module.
> 
> Hopefully not since we might probe later on if something registers a new
> device...
> 

Common pitfall. Also fallen into this myself and wondered why
it oops'd :o.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
