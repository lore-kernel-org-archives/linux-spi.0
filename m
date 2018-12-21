From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
Date: Fri, 21 Dec 2018 13:22:26 +0300
Message-ID: <9945f585-ab50-978a-7290-249336b7f107@cogentembedded.com>
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
 <1544181199-3373-2-git-send-email-masonccyang@mxic.com.tw>
 <b638fedc-551a-63e4-9654-f9fed8d0e292@cogentembedded.com>
 <OFC335F545.7543A0F2-ON4825836A.0007E65A-4825836A.0008428D@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFC335F545.7543A0F2-ON4825836A.0007E65A-4825836A.0008428D@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 12/21/2018 04:30 AM, masonccyang@mxic.com.tw wrote:

>> > diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
>> > new file mode 100644
>> > index 0000000..cec5669
>> > --- /dev/null
>> > +++ b/drivers/spi/spi-renesas-rpc.c
>> > @@ -0,0 +1,776 @@
>> [...]
>> > +static const struct soc_device_attribute r8a7795es1[] __initconst = {
>>
>>    This __initconst shouldn't be there, it causes a build warning.
>>
>> > +   { .soc_id = "r8a7795", .revision = "ES1.*" },
>>
>>    Wait, the driver doesn't really probe on R8A7795 yet!
> 
> yup, this is for RPC_PHYCNT_STRTIM setting by Marek's comments.
> 
> On H3 ES1.x, the value should be 0, while on others, the value should be 6.
> 
> ES1.x is r8a7795.

   Why care if we don't support H3 yet? Add this when the R8A77950 support is added.

>> > +   { /* sentinel */ }
>> > +};
>> > +
>> > +static void rpc_spi_hw_init(struct rpc_spi *rpc)
>> > +{
>> > +   int strtim;
>> > +   /*
>> > +    * NOTE: The 0x260 are undocumented bits, but they must be set.
>> > +    *   RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
>> > +    *   0x0 : the delay is biggest,
>> > +    *   0x1 : the delay is 2nd biggest,
>> > +    *   On H3 ES1.x, the value should be 0, while on others,
>> > +    *   the value should be 6.
>> > +    */
>> > +   if (soc_device_match(r8a7795es1))
>> > +      strtim = 0;
>> > +   else
>> > +      strtim = 6;
>> [...]
>> > +static const struct of_device_id rpc_spi_of_ids[] = {
>> > +   { .compatible = "renesas,r8a77995-rpc", },
>>
>>    We only support R8A77995 now.
> 
> see above !

   There's difference between R8A77995 and R8A77950, right?

[...]
> thanks & best regards,
> Mason

MBR, Sergei
