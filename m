From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] spi: pxa2xx: Mark expected switch fall-through
Date: Wed, 3 Oct 2018 17:27:52 +0200
Message-ID: <22e7d33d-db33-d2e4-30b1-fa87176e4277@embeddedor.com>
References: <20181003121211.GA28108@embeddedor.com>
 <20181003152255.GE7132@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003152255.GE7132@sirena.org.uk>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 10/3/18 5:22 PM, Mark Brown wrote:
> On Wed, Oct 03, 2018 at 02:12:11PM +0200, Gustavo A. R. Silva wrote:
> 
>>  			switch (drv_data->n_bytes) {
>>  			case 4:
>>  				bytes_left >>= 1;
>> +				/* Fall through */
>>  			case 2:
>>  				bytes_left >>= 1;
>>  			}
> 
> I think this code is just being too cute and it'd be better to just
> rewrite it to directly do the expected number of shifts directly in each
> case and have break statements; your fix is good but still not ideal for
> readability I think.
> 

Okay. I agree. I'll rewrite and send v2.

Thanks
--
Gustavo
