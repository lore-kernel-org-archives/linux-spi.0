From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] spi: add null check before pointer dereference
Date: Mon, 29 May 2017 21:33:16 -0500
Message-ID: <20170529213316.Horde.E_8getHmJAKt7ZcMf5DCefq@gator4166.hostgator.com>
References: <CGME20170523002511epcas4p3b7737552432363b089e4a9018e43f6f5@epcas4p3.samsung.com>
 <20170523002507.GA16670@embeddedgus>
 <20170529035925.oibpv254lyrdzoba@gangnam.samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org
To: Andi Shyti <andi.shyti@samsung.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170529035925.oibpv254lyrdzoba@gangnam.samsung>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Andi,

Quoting Andi Shyti <andi.shyti@samsung.com>:

> Hi Gustavo,
>
>>  	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>>  				       dma->direction, DMA_PREP_INTERRUPT);
>>
>> +	if (!desc) {
>> +		dev_err(&sdd->master->dev,
>> +			"%s:dmaengine_prep_slave_sg Failed\n", __func__);
>> +		return;
>> +	}
>> +
>
> I'm sorry, I would nack this patch for now. There was a smilar I
> sent before, but, as Krzysztof said, this needs more testing and
> a proper solution.
>

Yeah, I get it.

> That's anyway in my todo list.
>

That's great.

> Thanks,
> Andi

Thanks!
--
Gustavo A. R. Silva
