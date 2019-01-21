From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v6 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Mon, 21 Jan 2019 21:14:33 +0300
Message-ID: <5440645d-6b52-ad72-1c98-2d140f1cd15d@cogentembedded.com>
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-2-git-send-email-masonccyang@mxic.com.tw>
 <f4665653-503c-e1a1-a211-b8b322225bd6@cogentembedded.com>
 <OFE50FED81.5C117A38-ON48258389.0012FCE2-48258389.00139BD2@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFE50FED81.5C117A38-ON48258389.0012FCE2-48258389.00139BD2@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 01/21/2019 06:34 AM, masonccyang@mxic.com.tw wrote:

>> > +#define RPC_SMENR      0x0030   // R/W
>> > +#define RPC_SMENR_CDB(o)   (((o) & 0x2) << 30)
>> > +#define RPC_SMENR_OCDB(o)   (((o) & 0x2) << 28)
>> > +#define RPC_SMENR_ADB(o)   (((o) & 0x2) << 24)
>> > +#define RPC_SMENR_OPDB(o)   (((o) & 0x2) << 20)
>> > +#define RPC_SMENR_SPIDB(o)   (((o) & 0x2) << 16)
>>
>>    Ugh, s/0x2/0x3/! :-/
>>
>> [...]
>> > +#define RPC_SMDRENR      0x0064   // R/W
>> > +#define RPC_SMDRENR_HYPE   (0x5 << 12)
>>
>>    s/0x5/0x7/, and this is a field, not value.
>>
> 
> okay, both 0x2 and 0x5 are just make sure these registers was
> writing a correct value rather than a prohibited value.
> anyway, I will patch them.

   TIA.

>> [...]
>> > +static int rpc_spi_probe(struct platform_device *pdev)
>> > +{
>> > +   struct spi_controller *ctlr;
>> > +   struct resource *res;
>> > +   struct rpc_spi *rpc;
>> > +   const struct regmap_config *regmap_config;
>> > +   struct device_node *rpc_if;
>> > +   int ret;
>> > +
>> > +   rpc_if = of_find_compatible_node(pdev->dev.of_node, NULL,
>> > +                "jedec,spi-nor");
>>
>>    I doubt that this is a correct function to check for the child node's
>> "compatible" prop...

   You need of_get_next_child() or of_get_next_available_child().

>>
>> [...]
>> > +   regmap_config = &rpc_spi_regmap_config;
>>
>>    Doesn't look like this variable is needed...
> 
> why ?

   Why not just use &rpc_spi_regmap_config below?

>> > +   rpc->regmap = devm_regmap_init_mmio(&pdev->dev, rpc->base,
>> > +                   regmap_config);
[...]

> Mason

MBR, Sergei
